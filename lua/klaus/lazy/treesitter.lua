return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.config").setup({
      ensure_installed = {
        "vimdoc",
        "javascript",
        "typescript",
        "c",
        "lua",
        "rust",
        "jsdoc",
        "bash",
        "css",
        "html",
      },
      sync_install = false,
      auto_install = true,
      indent = { enable = true },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
      },
    })

    -- Register custom parsers (new style)
    local parsers = require("nvim-treesitter.parsers")

    -- templ
    parsers.templ = {
      install_info = {
        url = "https://github.com/vrischmann/tree-sitter-templ.git",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master",
      },
    }

    -- prisma (community parser)
    parsers.prisma = {
      install_info = {
        url = "https://github.com/victorhqc/tree-sitter-prisma.git",
        files = { "src/parser.c" },
      },
    }

    vim.treesitter.language.register("templ", "templ")
    vim.treesitter.language.register("prisma", "prisma")

    vim.filetype.add({
      extension = {
        prisma = "prisma",
      },
    })
  end,
}
