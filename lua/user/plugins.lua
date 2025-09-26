local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- UI elements
	"nvim-lua/popup.nvim",
	{ "nvim-lua/plenary.nvim", branch = "master" },
	{
		"nvim-lualine/lualine.nvim",
	},
	{
		"windwp/nvim-autopairs",
	},
	{
		"folke/zen-mode.nvim",
	},
	--Distraction free writing
	"lunarvim/colorschemes", -- A bunch of colorschemes you can try out
	"shaunsingh/nord.nvim",
	"folke/tokyonight.nvim",
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
	},
	{
		"echasnovski/mini.diff",
		config = function()
			local diff = require("mini.diff")
			diff.setup({
				-- Disabled by default
				source = diff.gen_source.none(),
			})
		end,
	},
	-- Autocompletions
	{
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			-- Snippet Engine
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
				opts = {},
			},
		},
	},

	-- Nvim Tree
	{
		"kyazdani42/nvim-tree.lua",
		-- commit = "bb375fb20327c49920c41d2b51c1ce2f4fe7deb3",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icon
		},
	},
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		-- commit = "6312868392331c9c0f22725041f1ec2bef57c751",
	},
	{
		"nvim-telescope/telescope-media-files.nvim",
		-- commit = "0826c7a730bc4d36068f7c85cf4c5b3fd9fb570a",
	},

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		-- commit = "7dfe4be94b4f84a9931098f0f0f618d055e50bd5",
	},
	{ "tpope/vim-fugitive" },
	{ "sindrets/diffview.nvim" },
	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		-- commit = "f197a15b0d1e8d555263af20add51450e5aaa1f0",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	{
		"kylechui/nvim-surround",
		version = "v2.0.5", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	------------------   Better writing experience
	--Better writing help
	-- "dpelle/vim-LanguageTool",

	-- Markdown support
	"godlygeek/tabular", -- I do use this plugin. Keep it here. RDG
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{ "dhruvasagar/vim-table-mode" }, -- Vim Table mode to aid in the writing of tables in markdown
	{
		"kiran94/edit-markdown-table.nvim",
		config = function()
			require("edit-markdown-table").setup({
				require("dressing").setup({
					input = {
						enabled = true,
						start_in_insert = false,
						win_options = {
							winblend = 0,
							wrap = true,
						},
					},
				}),
			})
		end,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cmd = "EditMarkdownTable",
	},
	{
		"tadmccorkle/markdown.nvim",
		ft = "markdown", -- or 'event = "VeryLazy"'
		opts = {
			-- configuration here or empty for defaults
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},

	-- Translation aid when wrinting some markdown
	{ "uga-rosa/translate.nvim" },

	-- A better aproach to note taking. Zettlecasten
	{
		"renerocksai/telekasten.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},

	{ -- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
	},

	-- LSP configuration ---
	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			{ "mfussenegger/nvim-dap" },
		},
	},
	{
		"mason-org/mason.nvim",
		config = true,
		dependencies = {
			"mason-org/mason-registry",
		},
	},
	{ "j-hui/fidget.nvim", opts = {} },
	{ "stevanmilic/nvim-lspimport" },

	--Autoformat
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
	},

	-- Linting
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
	},

	-- Ansible filetype support and execution
	{
		"mfussenegger/nvim-ansible",
	},

	-- Todo task management
	{ "freitass/todo.txt-vim" },

	-- Unit testing for development
	{ "nvim-neotest/nvim-nio" },
	{
		"rcasia/neotest-java",
		ft = "java",
		dependencies = {
			"mfussenegger/nvim-jdtls",
			"mfussenegger/nvim-dap", -- for the debugger
			"rcarriga/nvim-dap-ui", -- recommended
			"theHamsta/nvim-dap-virtual-text", -- recommended
		},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
		},
	},

	-- Debugging
	{
		"mfussenegger/nvim-dap",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
		config = function(_, opts)
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
		end,
	},
	{ "jrop/jq.nvim" },

	-- This allows not to use postman anymore
	{
		"oysandvik94/curl.nvim",
		cmd = { "CurlOpen" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("curl").setup({})
		end,
	},

	-- Gitlab MR integration
	{
		"harrisoncramer/gitlab.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
			"nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
		},
		enabled = true,
		build = function()
			require("gitlab.server").build(true)
		end, -- Builds the Go binary
	},

	-- AI code generator
	{
		"olimorris/codecompanion.nvim",
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
}, {
	dev = {
		path = "/home/roge/code",
		patterns = { "roge" }, -- For example {"folke"}
		fallback = false, -- Fallback to git when local plugin doesn't exist
	},
})

-- For some reason the lazy.nvim plugin seems to override the /site path in the rtp.
-- This line add it again. This is needed in order to spell to work, but the download of the spell file must be done manually
-- Maybe in a newer version of neovim this could be fixed.
-- Please, check https://github.com/neovim/neovim/issues/23082 for details of the issue.
vim.opt.rtp:append(vim.fn.stdpath("data") .. "/site")
