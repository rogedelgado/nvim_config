local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<c-h>", "<cmd>:TmuxNavigateLeft<cr>", opts)
keymap("n", "<c-j>", "<cmd>:TmuxNavigateDown<cr>", opts)
keymap("n", "<c-k>", "<cmd>:TmuxNavigateUp<cr>", opts)
keymap("n", "<c-l>", "<cmd>:TmuxNavigateRight<cr>", opts)

keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>c", "<cmd>bdelete!<CR>", opts)
keymap("n", "<leader>q", ":q!<CR>", opts)


-- NO highlight
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)



-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


-- Tree 
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Telescope
keymap("n", "<leader>tb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>tk", "<cmd>Telescope keymaps<cr>", opts)

-- Find files and text inside files
keymap("n", "<leader>ff", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false, hidden = true }))<cr>", opts)
keymap("n", "<leader>fF", "<cmd>Telescope live_grep theme=ivy<cr>", opts)
keymap("n", "<leader>fr", "<cmd>lua require('telescope.builtin').resume()<CR>", opts)

-- General writing --
keymap("n", "<leader>w", "<cmd>set wrap! linebreak<cr>", opts)
keymap("n", "<leader>De", "<cmd>lua vim.diagnostic.enable()<cr>", opts)
keymap("n", "<leader>Dd", "<cmd>lua vim.diagnostic.disable()<cr>", opts)

-- Translate
keymap("v", "ten", ":Translate EN --source=ES<CR>", opts)
keymap("v", "tes", ":Translate ES --source=EN <CR>", opts)

-- Spellcheck
keymap("n", "<leader><F7>", "<cmd>setlocal spell! spelllang=es_mx<cr>", opts)
keymap("n", "<leader><F8>", "<cmd>setlocal spell! spelllang=en_us<cr>", opts)
keymap("n", "<leader>ss", "<cmd>lua require('telescope.builtin').spell_suggest()<CR>", opts)

-- Telekasten note system
keymap("n", "<leader>z", "<cmd>lua require('telekasten').panel()<CR>", opts)
keymap("n", "<leader>zf", "<cmd>lua require('telekasten').find_notes()<CR>", opts)
keymap("n", "<leader>zi", "<cmd>lua require('telekasten').insert_link()<CR>", opts)
keymap("n", "<leader>zg", "<cmd>lua require('telekasten').search_notes()<CR>", opts)
keymap("n", "<leader>zz", "<cmd>lua require('telekasten').follow_link()<CR>", opts)
keymap("n", "<leader>zn", "<cmd>lua require('telekasten').new_note()<CR>", opts)
keymap("n", "<leader>zy", "<cmd>lua require('telekasten').yank_notelink()<CR>", opts)
keymap("n", "<leader>zt", "<cmd>lua require('telekasten').toggle_todo()<CR>", opts)
keymap("n", "<leader>zb", "<cmd>lua require('telekasten').show_backlinks()<CR>", opts)
keymap("n", "<leader>zF", "<cmd>lua require('telekasten').find_friends()<CR>", opts)
keymap("n", "<leader>z#", "<cmd>lua require('telekasten').show_tags()<CR>", opts)
keymap("n", "<leader>zr", "<cmd>lua require('telekasten').rename_note()<CR>", opts)
keymap("n", "<leader>zp", "<cmd>lua require('telekasten').paste_img_and_link()<CR>", opts)
keymap("n", "<leader>zv", "<cmd>lua require('telekasten').preview_img()<CR>", opts)

-- Open link under cursor in the browser
-- This remap is needed because the nvim-tree plugin disables the netrw plugin.
keymap("n", "gx", [[:silent execute '!brave ' . shellescape(expand('<cfile>'), 1)<CR>]], opts)

-- Custom commands
vim.cmd "command Curl set splitright | vnew | set filetype=sh | read !sh # | jq ."
vim.cmd "command SelCurl set splitright | vnew | set filetype=sh | '<,'>read !sh # | jq ."

-- Git mappings --
keymap("n", "ghl", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", opts)
keymap("n", "ghh", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", opts)
keymap("n", "gbl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", opts)
keymap("n", "gph", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", opts)
keymap("n", "grh", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", opts)
keymap("n", "grb", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", opts)
keymap("n", "gbb", ":G blame<cr>", opts)

-- Gitlab Code review mappings
-- keymap("n", "glb", "<cmd>lua require 'gitlab'.choose_merge_request()<cr>", opts)
-- keymap("n", "glr", "<cmd>lua require 'gitlab'.review()<cr>", opts)
-- keymap("n", "gls", "<cmd>lua require 'gitlab'.summary()<cr>",opts)
-- keymap("n", "glA", "<cmd>lua require 'gitlab'.approve()<cr>",opts)
-- keymap("n", "glR", "<cmd>lua require 'gitlab'.revoke()<cr>",opts)
-- keymap("n", "glq", "<cmd>lua require 'gitlab'.create_comment()<cr>", opts)
-- keymap("v", "glc", "<cmd>lua require 'gitlab'.create_multiline_comment()<cr>", opts)
-- keymap("v", "glC", "<cmd>lua require 'gitlab'.create_comment_suggestion()<cr>",opts)
-- keymap("n", "glO", "<cmd>lua require 'gitlab'.create_mr()<cr>",opts)
-- keymap("n", "glm", "<cmd>lua require 'gitlab'.move_to_discussion_tree_from_diagnostic()<cr>", opts)
-- keymap("n", "gln", "<cmd>lua require 'gitlab'.create_note()<cr>",opts)
-- keymap("n", "gld", "<cmd>lua require 'gitlab'.toggle_discussions()<cr>",opts)
-- keymap("n", "glaa", "<cmd>lua require 'gitlab'.add_assignee()<cr>",opts)
-- keymap("n", "glad", "<cmd>lua require 'gitlab'.delete_assignee()<cr>",opts)
-- keymap("n", "glla", "<cmd>lua require 'gitlab'.add_label()<cr>",opts)
-- keymap("n", "glld", "<cmd>lua require 'gitlab'.delete_label()<cr>",opts)
-- keymap("n", "glra", "<cmd>lua require 'gitlab'.add_reviewer()<cr>",opts)
-- keymap("n", "glrd", "<cmd>lua require 'gitlab'.delete_reviewer()<cr>",opts)
-- keymap("n", "glp", "<cmd>lua require 'gitlab'.pipeline()<cr>",opts)
-- keymap("n", "glo", "<cmd>lua require 'gitlab'.open_in_browser()<cr>",opts)
-- keymap("n", "glM", "<cmd>lua require 'gitlab'.merge()<cr>",opts)
-- keymap("n", "glu", "<cmd>lua require 'gitlab'.copy_mr_url()<cr>",opts)
-- keymap("n", "glP", "<cmd>lua require 'gitlab'.publish_all_drafts()<cr>",opts)
-- keymap("n", "glD", "<cmd>lua require 'gitlab'.toggle_draft_mode()<cr>",opts)
