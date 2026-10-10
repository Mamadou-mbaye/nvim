return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
    },
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "csharp_ls",
                "ts_ls",
                "html",
                "cssls",
                "eslint",
                "emmet_ls",
                "vue_ls",
                "jsonls",
                "bashls",
                "docker_compose_language_service",
            },
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                },
            },
        })
        vim.lsp.enable({
            "lua_ls",
            "csharp_ls",
            "ts_ls",
            "html",
            "cssls",
            "eslint",
            "emmet_ls",
            "vue_ls",
            "jsonls",
            "bashls",
            "docker_compose_language_service",
        })

        --vim.diagnostic.config({
        --   virtual_text = {
        --       prefix = "●",
        --       spacing = 4,
        --   },
        --})
        -- keymap attivi solo nei buffer dove è collegato un LSP
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(event)
                local opts = { buffer = event.buf }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
            end,
        })
    end,
}
