require("telescope").setup {
    defaults = {
      file_ignore_patterns = {
        "node_modules"
      },
      layout_config = {
        height = 0.5,
        width = 0.6,
        prompt_position = "top",
        preview_cutoff = 120
      },
      enable_preview = true
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_cursor {}
      },
      specific_opts = {
        codeactions = false -- disable custom buildin code actions
      }
    }
  }
  
  require("telescope").load_extension("ui-select")
  