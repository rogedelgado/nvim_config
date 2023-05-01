local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- UI elements
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  {"nvim-lualine/lualine.nvim", commit="84ffb80e452d95e2c46fa29a98ea11a240f7843e"},
  {"windwp/nvim-autopairs", commit="7566a86f44bb72ba2b1a609f528a27d93241502d"},
  {"lukas-reineke/indent-blankline.nvim", commit="018bd04d80c9a73d399c1061fa0c3b14a7614399"},
  "folke/which-key.nvim",
  {"folke/zen-mode.nvim", commit="6e6c963d70a8e47854fa656987666bfb863f9c4e"}, --Distraction free writing
  "lunarvim/colorschemes", -- A bunch of colorschemes you can try out
  "folke/tokyonight.nvim", 


  -- Completions
  {"hrsh7th/nvim-cmp", commit="e28fb7a730b1bd425fdddfdbd3d36bb84bd77611"},
  {"hrsh7th/cmp-buffer", commit="3022dbc9166796b644a841a02de8dd1cc1d311fa"}, -- buffer completions
  {"hrsh7th/cmp-path", commit="91ff86cd9c29299a64f968ebb45846c485725f23"},  -- path completions
  {"hrsh7th/cmp-cmdline", commit="5af1bb7d722ef8a96658f01d6eb219c4cf746b32"}, -- cmdline completions
  {"saadparwaiz1/cmp_luasnip", commit="18095520391186d634a0045dacaa346291096566"}, -- snippet completions
  {"hrsh7th/cmp-nvim-lsp", commit="0e6b2ed705ddcff9738ec4ea838141654f12eeef"},
  -- snippets
  "L3MON4D3/LuaSnip", --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use


  -- Nvim Tree
  {
      "kyazdani42/nvim-tree.lua",
      commit = "bb375fb20327c49920c41d2b51c1ce2f4fe7deb3",
      dependencies = {
        "kyazdani42/nvim-web-devicons", -- optional, for file icon
      }
  },

  -- Telescope
  {"nvim-telescope/telescope.nvim", commit="713d26b98583b160b50fb827adb751f768238ed3"},
  {"nvim-telescope/telescope-media-files.nvim", commit="0826c7a730bc4d36068f7c85cf4c5b3fd9fb570a"},

  -- Git
  {"lewis6991/gitsigns.nvim", commit="7dfe4be94b4f84a9931098f0f0f618d055e50bd5"},

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "b4d2640eab4b1f6373e1ded84ab9f6db0c02c756",
    build = ":TSUpdate"
  },
  "p00f/nvim-ts-rainbow",
  "nvim-treesitter/playground",

  {
    "numToStr/Comment.nvim",
    config = function()
        require('Comment').setup()
    end
  },

  {
    "kylechui/nvim-surround",
    version = "v2.0.5", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },

  ------------------   Better writing experience
  --Better writing help
  "dpelle/vim-LanguageTool",

  -- Markdown support
  "godlygeek/tabular",
  { "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" },
  },

  -- Translation aid when wrinting some markdown
  {'uga-rosa/translate.nvim'},

  -- ChatGPT OpenAI integration
  {
   "Bryley/neoai.nvim",
   dependencies = {
       "MunifTanjim/nui.nvim",
   },
   cmd = {
       "NeoAI",
       "NeoAIOpen",
       "NeoAIClose",
       "NeoAIToggle",
       "NeoAIContext",
       "NeoAIContextOpen",
       "NeoAIContextClose",
       "NeoAIInject",
       "NeoAIInjectCode",
       "NeoAIInjectContext",
       "NeoAIInjectContextCode",
   },
   keys = {
       { "<leader>as", desc = "summarize text" },
       { "<leader>ag", desc = "generate git message" },
   },
   config = function()
       require("neoai").setup({
           -- Options go here
       })
   end,
  },


  -- A better aproach to note taking. Zettlecasten
  {
    "renerocksai/telekasten.nvim",
    dependencies = {'nvim-telescope/telescope.nvim'}
  }

})
