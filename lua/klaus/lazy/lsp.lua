
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },
    config = function()
        local cmp = require("cmp") or error("Failed to load nvim-cmp")
        local cmp_lsp = require("cmp_nvim_lsp") or error("Failed to load cmp_nvim_lsp")
        local lspconfig = require("lspconfig") or error("Failed to load lspconfig")
        local luasnip = require("luasnip") or error("Failed to load LuaSnip")

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require("mason").setup()

        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = {
                -- Core dev servers
                "lua_ls",
                "rust_analyzer",
                "tsserver",

                -- Additional servers
                "pyright",        -- Python
                "ruff",       -- Python linting
                "gopls",          -- Go
                "html",
                "cssls",
                "jsonls",
                "bashls",
                "marksman",       -- Markdown
                "jdtls",          -- Java
            },
            handlers = {
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            print("LSP " .. server_name .. " attached to buffer " .. bufnr)
                        end,
                    })
                end,

                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                },
                                workspace = {
                                    library = vim.api.nvim_get_runtime_file("", true),
                                    checkThirdParty = false,
                                },
                            },
                        },
                        on_attach = function(client, bufnr)
                            print("lua_ls attached to buffer " .. bufnr)
                        end,
                    })
                end,

                ["rust_analyzer"] = function()
                    lspconfig.rust_analyzer.setup({
                        capabilities = capabilities,
                        root_dir = lspconfig.util.root_pattern("Cargo.toml") or function()
                            return vim.fn.getcwd()
                        end,
                        settings = {
                            ["rust-analyzer"] = {
                                checkOnSave = {
                                    command = "clippy",
                                },
                                completion = {
                                    callable = {
                                        snippets = true,
                                    },
                                },
                                cargo = {
                                    allFeatures = true,
                                    loadOutDirsFromCheck = true,
                                },
                                procMacro = {
                                    enable = true,
                                },
                            },
                        },
                        on_attach = function(client, bufnr)
                            print("rust_analyzer attached to buffer " .. bufnr)
                        end,
                    })
                end,

                ["jdtls"] = function()
                    -- Java needs extra configuration if you're using workspace folders or debugging
                    lspconfig.jdtls.setup({
                        capabilities = capabilities,
                        cmd = { "jdtls" },
                        on_attach = function(client, bufnr)
                            print("jdtls (Java) attached to buffer " .. bufnr)
                        end,
                    })
                end,

        },
        })

        -- Autocompletion setup
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    if luasnip then
                        luasnip.lsp_expand(args.body)
                    else
                        error("LuaSnip not loaded")
                    end
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp", max_item_count = 20 },
                { name = "luasnip", max_item_count = 10 },
                { name = "buffer", max_item_count = 10 },
                { name = "path", max_item_count = 10 },
            }),
            completion = {
                autocomplete = { cmp.TriggerEvent.TextChanged },
            },
        })

        -- Diagnostic UI
        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        -- Filetype tweaks
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "rust",
            callback = function()
                vim.bo.filetype = "rust"
                print("Rust filetype set")
            end,
        })
    end,
}

