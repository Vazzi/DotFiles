require("nvim-treesitter.configs").setup {
    build = ":TSUpdate",
    ensure_installed = {
      "lua",
      "luadoc",
      "bash",
      "c",
      "cmake",
      "make",
      "html",
      "css",
      "scss",
      "markdown",
      "markdown_inline",
      "vim",
      "vimdoc",
      "query",
      "dockerfile",
      "gitignore",
      "javascript",
      "jsdoc",
      "typescript",
      "tsx",
      "python",
      "diff",
      "groovy"
    },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
      enable = true,
      disable = {}
    },
    indent = {
      enable = true,
      disable = {}
    },
    autotag = {
      enable = false
    }
  }
  
  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
  parser_config.tsx.filetype_to_parsername = {"javascript", "typescript.tsx"}
  