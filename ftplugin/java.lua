local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = "/home/roge/code/workspace/" .. project_name

-- Set a Vim motion to <Space> + <Shift>J + o to organize imports in normal mode
vim.keymap.set(
	"n",
	"<leader>Jo",
	"<Cmd> lua require('jdtls').organize_imports()<CR>",
	{ desc = "[J]ava [O]rganize Imports" }
)
-- Set a Vim motion to <Space> + <Shift>J + v to extract the code under the cursor to a variable
vim.keymap.set(
	"n",
	"<leader>Jv",
	"<Cmd> lua require('jdtls').extract_variable()<CR>",
	{ desc = "[J]ava Extract [V]ariable" }
)
-- Set a Vim motion to <Space> + <Shift>J + v to extract the code selected in visual mode to a variable
vim.keymap.set(
	"v",
	"<leader>Jv",
	"<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>",
	{ desc = "[J]ava Extract [V]ariable" }
)

-- Set a Vim motion to <Space> + <Shift>J + m to extract the code selected in visual mode to a method
vim.keymap.set(
	"v",
	"<leader>Jm",
	"<Esc><Cmd> lua require('jdtls').extract_method(true)<CR>",
	{ desc = "[J]ava Extract [M]ethod" }
)
-- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code under the cursor to a static variable
vim.keymap.set(
	"n",
	"<leader>JC",
	"<Cmd> lua require('jdtls').extract_constant()<CR>",
	{ desc = "[J]ava Extract [C]onstant" }
)
-- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code selected in visual mode to a static variable
vim.keymap.set(
	"v",
	"<leader>JC",
	"<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>",
	{ desc = "[J]ava Extract [C]onstant" }
)
-- Set a Vim motion to <Space> + <Shift>J + t to run the test method currently under the cursor
vim.keymap.set(
	"n",
	"<leader>Jt",
	"<Cmd> lua require('jdtls.dap').test_nearest_method()<CR>",
	{ desc = "[J]ava [T]est Method" }
)
-- Set a Vim motion to <Space> + <Shift>J + t to run the test method that is currently selected in visual mode
vim.keymap.set(
	"v",
	"<leader>Jt",
	"<Esc><Cmd> lua require('jdtls.dap').test_nearest_method(true)<CR>",
	{ desc = "[J]ava [T]est Method" }
)
-- Set a Vim motion to <Space> + <Shift>J + <Shift>T to run an entire test suite (class)
vim.keymap.set("n", "<leader>JT", "<Cmd> lua require('jdtls.dap').test_class()<CR>", { desc = "[J]ava [T]est Class" })
-- Set a Vim motion to <Space> + <Shift>J + u to update the project configuration
vim.keymap.set("n", "<leader>Ju", "<Cmd> JdtUpdateConfig<CR>", { desc = "[J]ava [U]pdate Config" })
-- Set a vim motion to <Space> + <Shift>J + t + j to jump to the test class. Check `:h jdtls.tests.goto_subjects` function
-- If there is no test to jump to, the jdtls.tests.generate() function is called instead. Again, read `:h jdtls.tests.goto_subjects`
vim.keymap.set(
	"n",
	"<leader>Jtj",
	"<Cmd> lua require('jdtls.tests').goto_subjects()<CR>",
	{ desc = "[J]ava [t]test [j]ump" }
)

-- Jdtls definition of the extenden capabilities
local jdtls = require("jdtls")
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.onCompletionItemSelectedCommand = "editor.action.triggerParameterHints"

local on_attach = function(client, bufnr)
	vim.lsp.inlay_hint.enable(true)
end

-- Bundles jars to extends the functionalityu of jdtls.
-- java-debug
-- vscode-java-tests
local bundles_extentions = {
	vim.fn.glob(
		"/home/roge/Downloads/jdtls/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.0.jar",
		1
	),
}
vim.list_extend(
	bundles_extentions,
	vim.split(vim.fn.glob("/home/roge/Downloads/jdtls/vscode-java-test/server/*.jar", 1), "\n")
)

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	on_attach = on_attach,
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {

		-- 💀
		"/usr/lib/jvm/java-17-openjdk/bin/java", -- or '/path/to/java17_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		"-javaagent:/home/roge/Downloads/jdtls/lombok.jar",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- 💀
		"-jar",
		"/home/roge/Downloads/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar",
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
		-- Must point to the                                                     Change this to
		-- eclipse.jdt.ls installation                                           the actual version

		-- 💀
		"-configuration",
		"/home/roge/Downloads/jdtls/config_linux",
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
		-- Must point to the                      Change to one of `linux`, `win` or `mac`
		-- eclipse.jdt.ls installation            Depending on your system.

		-- 💀
		-- See `data directory configuration` section in the README
		"-data",
		workspace_dir,
	},

	-- 💀
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	--
	-- vim.fs.root requires Neovim 0.10.
	-- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
	root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),


	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			signatureHelp = {
				enabled = true,
			},
			inlayhints = { parameterNames = { enabled = "all" } },
			codeGeneration = {
				generateComments = true,
			},
			completion = {
				enabled = true,
				guessMethodArguments = true,
				overwrite = true,
			},
			configuration = {
				-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
				-- And search for `interface RuntimeOption`
				-- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
				runtimes = {
					{
						name = "JavaSE-11",
						path = "/usr/lib/jvm/java-11-openjdk/",
					},
					{
						name = "JavaSE-1.7",
						path = "/usr/lib/jvm/java-7-jdk/",
					},
					{
						name = "JavaSE-1.8",
						path = "/usr/lib/jvm/java-8-openjdk/",
					},
				},
			},
		},
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = bundles_extentions,
		extendedClientCapabilities = extendedClientCapabilities,
	},
}

-- This line was needed to support Autocomplete parameters. Check the github discussion: https://github.com/mfussenegger/nvim-jdtls/discussions/440 
config.capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
