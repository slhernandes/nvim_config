vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.rnu = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.cinoptions = "l1"

vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = (os.getenv("XDG_DATA_HOME") or
                      (os.getenv("HOME") .. "/.local/share")) .. "/vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.splitbelow = true

vim.opt.conceallevel = 3

vim.filetype.add({extension = {ned = 'ned'}})

vim.opt.list = true
vim.opt.lcs = "tab: 󰌒,trail:·,precedes:⋱"

vim.opt.showmode = false
