return {
  "folke/todo-comments.nvim",
  opts = {
    highlight = {
      pattern = [[.*<(KEYWORDS)\s*(\(\w*\))?:]],
    },
    pattern = [[(KEYWORDS)\s*(\(\w*\))?:]],
  },
}
