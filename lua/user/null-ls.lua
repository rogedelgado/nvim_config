local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.code_actions.refactoring,
		null_ls.builtins.completion.luasnip,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.flake8.with({ extra_args = { "--ignore=E501" } }),
		null_ls.builtins.diagnostics.yamllint,
		null_ls.builtins.diagnostics.markdownlint,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.yamlfmt,
		null_ls.builtins.formatting.sql_formatter,
		null_ls.builtins.formatting.beautysh,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.markdownlint,
	},
})
