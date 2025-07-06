require("codecompanion").setup({
    adapters = {
        gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
                env = {
                    api_key = "cmd:cat /home/roge/.gemini",
                }
            })
        end,
    },
	strategies = {
		chat = {
			adapter = "gemini",
		},
		inline = {
			adapter = "gemini",
		},
	},
})
