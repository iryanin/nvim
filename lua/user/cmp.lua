local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local lspkind = require("lspkind")
require("luasnip.loaders.from_vscode").lazy_load()

local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  luasnip = "[Snippet]",
  path = "[Path]",
  cmdline = "[Command]",
  cmp_tabnine = "[TabNine]",
}
local compare = require("cmp.config.compare")
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.setup({
  view = {
    entries = { name = 'custom' }
  },

  snippet = {
    expand = function(args)
      -- For `luasnip` users.
      require("luasnip").lsp_expand(args.body)
    end,
  },

  sources = cmp.config.sources({
    { name = "cmp_tabnine" },
    { name = "nvim_lsp" },
    -- For luasnip users.
    { name = "luasnip" },
  }, { { name = "buffer" }, { name = "path" } }),

  sorting = {
    priority_weight = 2,
    comparators = {
      require("cmp_tabnine.compare"),
      compare.offset,
      compare.exact,
      compare.score,
      compare.recently_used,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },

  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" }) .. " ".. vim_item.kind
      vim_item.menu = source_mapping[entry.source.name]
            if entry.source.name == "cmp_tabnine" then
        local detail = (entry.completion_item.data or {}).detail
        vim_item.kind = ""
        if detail and detail:find(".*%%.*") then
          vim_item.kind = vim_item.kind .. " " .. detail
        end

        if (entry.completion_item.data or {}).multiline then
          vim_item.kind = vim_item.kind .. " " .. "[ML]"
        end
      end
      local maxwidth = 80
      vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
      return vim_item
    end,
  },

  mapping = {
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

    ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),

    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),

    ["<CR>"] = cmp.mapping.confirm({
      select = false,
      behavior = cmp.ConfirmBehavior.Replace,
    }),

    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- elseif luasnip.expand_or_jumpable() then
        --   luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
        -- elseif luasnip.jumpable(-1) then
        --   luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

vim.cmd [[highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080]]
vim.cmd [[highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6]]
vim.cmd [[highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch]]
vim.cmd [[highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE]]
vim.cmd [[highlight! link CmpItemKindInterface CmpItemKindVariable]]
vim.cmd [[highlight! link CmpItemKindText CmpItemKindVariable]]
vim.cmd [[highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0]]
vim.cmd [[highlight! link CmpItemKindMethod CmpItemKindFunction]]
vim.cmd [[highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4]]
vim.cmd [[highlight! link CmpItemKindProperty CmpItemKindKeyword]]
vim.cmd [[highlight! link CmpItemKindUnit CmpItemKindKeyword]]
