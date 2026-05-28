local template_dir = vim.fn.stdpath("config") .. "/templates/"

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "[0-9]*.cpp",
  group = vim.api.nvim_create_augroup("template", {clear = false}),
  desc = "C++ template creation (codeforces)",
  command = "0r " .. template_dir .. "template.cpp"
})
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "aoc*.rs",
  group = vim.api.nvim_create_augroup("template", {clear = false}),
  desc = "Rust template creation (AOC)",
  command = "0r " .. template_dir .. "template.rs"
})
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.cc",
  group = vim.api.nvim_create_augroup("template", {clear = false}),
  desc = "C++ Template creation (OMNeT++)",
  command = "0r " .. template_dir .. "opp_template.cc"
})
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.ned",
  group = vim.api.nvim_create_augroup("template", {clear = false}),
  desc = "Ned template creation (OMNeT++)",
  command = "0r " .. template_dir .. "opp_template.ned"
})
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.ini",
  group = vim.api.nvim_create_augroup("template", {clear = false}),
  desc = "Ini template creation (OMNeT++)",
  command = "0r " .. template_dir .. "opp_template.ini"
})
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.typ",
  group = vim.api.nvim_create_augroup("template", {clear = false}),
  desc = "Typst template creation",
  command = "0r " .. template_dir .. "template.typ"
})
