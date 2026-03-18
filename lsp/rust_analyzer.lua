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
		},
	},
}
