local status_ok, gl = pcall(require, "gitlab")
if not status_ok then
	return
end

gl.setup({
	discussion_tree = {
		position = "bottom",
	},
})
