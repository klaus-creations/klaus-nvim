-- General UI / editing
vim.opt.guicursor     = ""                     -- disable fancy cursor in terminal
vim.opt.nu            = true                   -- absolute line numbers
vim.opt.relativenumber = true                  -- relative numbers (great combo with nu)

-- Indentation & tabs (4 spaces is perfect)
vim.opt.tabstop       = 4
vim.opt.softtabstop   = 4
vim.opt.shiftwidth    = 4
vim.opt.expandtab     = true                   -- tabs → spaces
vim.opt.smartindent   = false                  -- ← Important: disable when treesitter indent = true

-- Wrapping (nice for long lines / markdown / comments)
vim.opt.wrap          = true
vim.opt.linebreak     = true                   -- break at words, not mid-word

vim.opt.breakindent   = true                   -- wrapped lines keep indent
vim.opt.showbreak     = "↳ "                   -- visual prefix for wrapped lines

-- Files / history
vim.opt.swapfile      = false
vim.opt.backup        = false
vim.opt.undodir       = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile      = true

-- Search
vim.opt.hlsearch      = false                  -- don't keep highlights after search
vim.opt.incsearch     = true                   -- incremental live search

-- Appearance / performance
vim.opt.termguicolors = true                   -- true color support
vim.opt.scrolloff     = 8                      -- keep 8 lines above/below cursor
vim.opt.signcolumn    = "yes"                  -- always show sign column (for git/lsp/diagnostics)
vim.opt.isfname:append("@-@")                  -- treat @ as filename char (emails/urls)
vim.opt.updatetime    = 50                     -- faster CursorHold / gitgutter / etc.
vim.opt.colorcolumn   = "80"                   -- vertical line at 80 chars

