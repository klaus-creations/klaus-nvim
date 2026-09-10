return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup()

    local ensure_installed = {
      "vimdoc",
      "javascript",
      "typescript",
      "tsx",
      "c",
      "lua",
      "rust",
      "jsdoc",
      "bash",
      "css",
      "html",
      "json",
      "prisma",
      "templ",
    }

    -- Install any parsers we don't have yet (async, one-time).
    local installed = require("nvim-treesitter.config").get_installed("parsers")
    local missing = vim.tbl_filter(function(lang)
      return not vim.tbl_contains(installed, lang)
    end, ensure_installed)
    if #missing > 0 then
      require("nvim-treesitter").install(missing)
    end

    -- The main branch does not start highlighting for us; do it per buffer.
    local function start(buf)
      local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
      if not lang or not pcall(vim.treesitter.start, buf, lang) then
        return
      end
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        start(args.buf)
      end,
    })

    -- Buffers already open when lazy.nvim loaded us.
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) then
        start(buf)
      end
    end
  end,
}
