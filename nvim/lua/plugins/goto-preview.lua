return {
  "rmagatti/goto-preview",
  dependencies = { "rmagatti/logger.nvim" },
  event = "BufEnter",
  -- config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
  config = function()
    require("goto-preview").setup({
      width = 120,
      height = 15,
      border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
      default_mappings = true,
      debug = false,
      opacity = nil,
      resizing_mappings = false,
      post_open_hook = nil,
      post_close_hook = nil,
      references = {
        provider = "default", -- telescope|fzf_lua|snacks|mini_pick|default
      },
      focus_on_open = true,
      dismiss_on_move = false,
      force_close = true,
      bufhidden = "wipe",
      stack_floating_preview_windows = true,
      preview_window_title = { enable = true, position = "left" },
      zindex = 1,
    })
  end,
}
