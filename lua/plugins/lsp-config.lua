return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    }, {
    "williamboman/mason-lspconfig.nvim",
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "gopls", "pyright", "ruff" }
        })
    end
}, {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        lspconfig.lua_ls.setup({
            capabilities = capabilities
        })
        lspconfig.gopls.setup({
            capabilities = capabilities
        })
        lspconfig.pyright.setup({
            capabilities = capabilities,
            settings = {
                pyright = {
                    -- Using Ruff's import organizer
                    disableOrganizeImports = true,
                },
                python = {
                    analysis = {
                        -- Ignore all files for analysis to exclusively use Ruff for linting
                        ignore = { '*' },
                    },
                },
            },
        })
        lspconfig.ruff.setup({})

        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end
} }
