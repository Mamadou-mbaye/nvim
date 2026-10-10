return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")
        --ts.setup({
        --    highlight = { enable = true },
        --    indent = { enable = true },
        --    autotage = { enable = true },
        --})
        -- Installazione parser (sostituisce ensure_installed)
        ts.install({
            "lua",
            "html",
            "css",
            "javascript",
            "typescript",
            "c_sharp",
            "json",
            "vue",
            "sql",
            "markdown",
        })

        -- HighLight
        --        vim.api.nvim_create_autocmd("FileType", {
        --            pattern = { "lua", "c_sharp" },
        --            callback = function()
        --                vim.treesitter.start()
        --            end,
        --        })

        -- Autocmd per abilitare highlight + indent per ogni filetype
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(event)
                local lang = vim.treesitter.language.get_lang(event.match)
                if not lang then
                    return
                end

                pcall(vim.treesitter.start, event.buf, lang)
                vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
