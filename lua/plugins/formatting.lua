return {
    "stevearc/conform.nvim",
    dependencies = {
        "mason-org/mason.nvim",
        "zapling/mason-conform.nvim",
    },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                json = { "prettier" },
                cs = { "csharpier" },
                markdown = { "mdformat" },
                vue = { "prettier" },
            },
            formatters = {
                csharpier = {
                    timeout_ms = 15000,
                },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        })

        require("mason-conform").setup()
    end,
}
--return {
--    "stevearc/conform.nvim",
--    dependencies = {
--	"mason-org/mason.nvim",
--        "zapling/mason-conform.nvim",
--    },
--    opts = {
--        formatters_by_ft = {
--            lua = { "stylua" },
--            javascript = { "prettier" },
--            typescript = { "prettier" },
--            json = { "prettier" },
--            cs = { "csharpier" },
--            markdown = { "mdformat" },
--        },
--        format_on_save = {
--            timeout_ms = 500,
--            lsp_fallback = true,
--        },
--    },
--}
