
return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Always use the latest commit
    build = "make", -- Adjust to "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" for Windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
    opts = {
      provider = nil,  -- No provider, no Copilot
      providers = {},
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = true,
        support_paste_from_clipboard = true,
      },
      mappings = {
        ask = "<leader>aa",
        edit = "<leader>ae",
        refresh = "<leader>ar",
      },
      windows = {
        position = "right",
        width = 30,
      },
    },
    config = function(_, opts)
      require("avante").setup(opts)
    end,
  },
}

