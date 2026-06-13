return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = {
		"Cargo.toml",
		".git",
	},
	settings = {
		["rust-analyzer"] = {
			-- Enable specific lenses like references, implementations, etc.
			lens = {
				enable = true,
				references = { enable = true },
				implementations = { enable = true },
				run = { enable = true },
			},
			cargo = { allFeatures = true },
		},
	},
	-- on_attach = function(client, bufnr)
	-- 	if client:supports_method("inlayHint/resolve") then
	-- 		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	-- 	end
	-- 	if client:supports_method("textDocument/completion") then
	-- 		vim.lsp.completion.enable(true, client.id, bufnr, {})
	-- 	end
	-- end,
}
