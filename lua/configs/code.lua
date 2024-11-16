return {
	display = {
		diff = {
			provider = "mini_diff",
		},
	},
	strategies = {
		chat = { adapter = "ollama" },
		inline = { adapter = "ollama" },
		agent = { adapter = "ollama" },
	},
	adapters = {
		ollama = function()
			return require("codecompanion.adapters").extend("ollama", {
				name = "assistant",
				schema = {
					model = {
						default = "assistant:latest",
					},
				},
				parameters = { sync = true },
			})
		end,
	},
}
