local status_ok, chat = pcall(require, "chatgpt")
if not status_ok then
	return
end

chat.setup({
	api_key_cmd = "cat /home/roge/.chatgpt_token",
	openai_params = {
		model = "gpt-4o",
	},
})
