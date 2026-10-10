local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end

local function fix_diagnostic_underline()
    for _, name in ipairs({ "Error", "Warn", "Info", "Hint" }) do
        local diag_color = vim.api.nvim_get_hl(0, { name = "Diagnostic" .. name })
        vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. name, {
            underline = true,
            undercurl = false,
            sp = diag_color.fg,
        })
    end
end

return {
    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd.colorscheme("tokyonight")
            enable_transparency()
            fix_diagnostic_underline()
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = "tokyonight",
        },
    },
}
