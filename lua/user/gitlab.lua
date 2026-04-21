local status_ok, gl = pcall(require, "gitlab")
if not status_ok then
	return
end

gl.setup({
	discussion_tree = {
		position = "bottom",
	},
    attachment_dir = "/home/roge/",
	discussion_signs = {
		icons = {
			comment = "",
			range = " |",
		},
	},
    popup = {
        temp_registers = {'"', "+", "9"}
    }
})
