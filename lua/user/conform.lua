local conform = require("conform")

conform.setup({
    formatters = {
        reformat_gherkin = {
            command = "/home/roge/.local/share/nvim/mason/bin/reformat-gherkin"
        }
    },
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        -- rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettier" },
        markdown = { "markdownlint" },
        cucumber = { "reformat_gherkin"},
        xml = {"xmlformat"},
    },
})


local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { desc = "LSP: " .. desc })
end

map("<space>fo", function()
    conform.format { async = true, lsp_fallback = true }
end, "[Fo]rmat")
