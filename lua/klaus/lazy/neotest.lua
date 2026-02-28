return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",           -- ← Required dependency (fixes the error)
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "marilari88/neotest-vitest",
            "nvim-neotest/neotest-plenary",
        },
        config = function()
            local neotest = require("neotest")
            neotest.setup({
                adapters = {
                    require("neotest-vitest"),
                    require("neotest-plenary").setup({
                        -- this is my standard location for minimal vim rc
                        -- in all my projects
                        min_init = "./scripts/tests/minimal.vim",
                    }),
                },
            })

            -- Keymaps for running tests
            vim.keymap.set("n", "<leader>tc", function()
                neotest.run.run()
            end, { desc = "Run nearest test" })

            vim.keymap.set("n", "<leader>tf", function()
                neotest.run.run(vim.fn.expand("%"))
            end, { desc = "Run tests in current file" })
        end,
    },
}
