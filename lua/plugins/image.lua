return {
  {
    "3rd/image.nvim",
    -- ft = {"norg", "md", "py", "ipynb", "qmd", "jpeg", "jpg", "png"},
    -- luarocks config in neorg.lua
    dependencies = {'leafo/magick'},
    lazy = true,
    config = function()
      -- default config
      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = true,
            download_remote_images = true,
            only_render_image_at_cursor = true,
            filetypes = {"markdown", "vimwiki", "ipynb"} -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = true,
            download_remote_images = true,
            only_render_image_at_cursor = true,
            filetypes = {"norg"}
          },
          html = {enabled = false},
          css = {enabled = false}
        },
        max_width = 100,
        max_height = 12,
        max_width_window_percentage = math.huge,
        max_height_window_percentage = math.huge,
        window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = {"cmp_menu", "cmp_docs", ""},
        editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = {
          "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif"
        } -- render image files as images when opened
      })
    end
  }
}
