require("codecompanion").setup({
	interactions = {
		chat = {
			-- You can specify an adapter by name and model (both ACP and HTTP)
			adapter = {
				name = "ollama",
				model = "gpt-oss",
			},
		},
		-- Or, just specify the adapter by name
		inline = {
			adapter = {
				name = "ollama",
				model = "gpt-oss",
			},
		},
		cmd = {
			adapter = {
				name = "ollama",
				model = "gpt-oss",
			},
		},
		background = {
			adapter = {
				name = "ollama",
				model = "gpt-oss",
			},
		},
	},
})
