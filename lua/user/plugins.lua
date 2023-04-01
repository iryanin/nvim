local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "nvim-lua/plenary.nvim",
    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    { "stevearc/dressing.nvim" },
    -- {
    --     "folke/noice.nvim",
    --     config = function()
    --         require("noice").setup({})
    --     end,
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --         "rcarriga/nvim-notify",
    --     },
    -- },
    {
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup()
        end,
    },

    {
        "akinsho/bufferline.nvim",
        config = function()
            local bufferline = require("bufferline")
            bufferline.setup({
                options = {
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            highlight = "Directory",
                            text_align = "center",
                        },
                    },
                    diagnostics = "nvim_lsp",
                    ---@diagnostic disable-next-line: unused-local
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local s = " "
                        for e, n in pairs(diagnostics_dict) do
                            local sym = e == "error" and " " or (e == "warning" and " " or "")
                            s = s .. n .. sym
                        end
                        return s
                    end,
                },
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            local lualine = require("lualine")
            lualine.setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = {
                        left = "|",
                        right = "|",
                    },
                    section_separators = {
                        left = " ",
                        right = "",
                    },
                    disabled_filetypes = {
                        statusline = { "alpha" },
                        winbar = { "alpha" },
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = {
                        "filename",
                        {
                            "lsp_progress",
                            display_components = { "lsp_client_name", "spinner", { "title", "percentage", "message" } },
                            separators = {
                                component = " ",
                                progress = " | ",
                                message = { pre = "(", post = ")", commenced = "In Progress", completed = "Completed" },
                                percentage = { pre = "", post = "%% " },
                                title = { pre = "", post = ": " },
                                lsp_client_name = { pre = "[", post = "]" },
                                spinner = { pre = "", post = "" },
                            },
                            timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
                            spinner_symbols = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
                        },
                    },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                extensions = { "nvim-tree", "symbols-outline", "nvim-dap-ui" },
            })
        end,
    },
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({})
        end,
    },
    { "lukas-reineke/indent-blankline.nvim" },
    {
        "goolord/alpha-nvim",
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
            dashboard.section.header.val = {
                [[                               __                ]],
                [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
                [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
                [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
                [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
                [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
            }
            dashboard.section.buttons.val = {
                dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
                dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
                dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
                dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
                dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
                dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
            }

            local function footer()
                return "Footer"
            end

            dashboard.section.footer.val = footer()

            dashboard.section.footer.opts.hl = "Type"
            dashboard.section.header.opts.hl = "Include"
            dashboard.section.buttons.opts.hl = "Keyword"

            dashboard.opts.opts.noautocmd = true
            alpha.setup(dashboard.opts)
        end,
    },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({})
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { hl = "GitSignsAdd", text = "A|", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                    change = {
                        hl = "GitSignsChange",
                        text = "C|",
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                    delete = {
                        hl = "GitSignsDelete",
                        text = "D_",
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    topdelete = {
                        hl = "GitSignsDelete",
                        text = "D‾",
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    changedelete = {
                        hl = "GitSignsChange",
                        text = "D~",
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    map("n", "[c", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    -- Actions
                    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
                    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
                    map("n", "<leader>hS", gs.stage_buffer)
                    map("n", "<leader>hu", gs.undo_stage_hunk)
                    map("n", "<leader>hR", gs.reset_buffer)
                    map("n", "<leader>hp", gs.preview_hunk)
                    map("n", "<leader>hb", function()
                        gs.blame_line({ full = true })
                    end)
                    map("n", "<leader>tb", gs.toggle_current_line_blame)
                    map("n", "<leader>hd", gs.diffthis)
                    map("n", "<leader>hD", function()
                        gs.diffthis("~")
                    end)
                    map("n", "<leader>td", gs.toggle_deleted)

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                end,
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, { { name = "buffer" }, { name = "path" } }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        menu = {
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            path = "[Path]",
                            cmdline = "[Command]",
                        },
                    }),
                },
                mapping = {
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-e>"] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<CR>"] = cmp.mapping.confirm({
                        select = false,
                        behavior = cmp.ConfirmBehavior.Replace,
                    }),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    ["<C-d>"] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { "i", "s" }),
                    ["<C-u>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { "i", "s" }),
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

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

            vim.cmd([[highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080]])
            vim.cmd([[highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6]])
            vim.cmd([[highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch]])
            vim.cmd([[highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE]])
            vim.cmd([[highlight! link CmpItemKindInterface CmpItemKindVariable]])
            vim.cmd([[highlight! link CmpItemKindText CmpItemKindVariable]])
            vim.cmd([[highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0]])
            vim.cmd([[highlight! link CmpItemKindMethod CmpItemKindFunction]])
            vim.cmd([[highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4]])
            vim.cmd([[highlight! link CmpItemKindProperty CmpItemKindKeyword]])
            vim.cmd([[highlight! link CmpItemKindUnit CmpItemKindKeyword]])
        end,
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            lspconfig.clangd.setup({
                capabilities = capabilities,
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
            })
            lspconfig.texlab.setup({
                capabilities = capabilities,
                settings = {
                    texlab = {
                        build = {
                            args = { "-pdf", "-xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
                            executable = "latexmk",
                            forwardSearchAfter = true,
                            onSave = true,
                        },
                        forwardSearch = {
                            executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
                            args = { "-g", "%l", "%p", "%f" },
                        },
                        chktex = {
                            onEdit = true,
                            onOpenAndSave = true,
                        },
                        latexindent = {
                            modifyLineBreaks = true,
                        },
                    },
                },
            })
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("null-ls").setup({
                sources = {
                    require("null-ls").builtins.formatting.black,
                    require("null-ls").builtins.formatting.stylua,
                },
            })
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                mappings = {
                    i = {
                        ["<C-n>"] = "move_selection_next",
                        ["<C-p>"] = "move_selection_previous",
                        ["<Down>"] = "cycle_history_next",
                        ["<Up>"] = "cycle_history_prev",
                        ["<C-u>"] = "preview_scrolling_up",
                        ["<C-d>"] = "preview_scrolling_down",
                    },
                },
            })
            telescope.load_extension("projects")
        end,
    },
    "onsails/lspkind.nvim",
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "HiPhish/nvim-ts-rainbow2",
            "nvim-treesitter/nvim-treesitter-context",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                highlight = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                },
                rainbow = {
                    enable = true,
                },
            })
        end,
    },

    {
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup()
        end,
    },
    {
        "CRAG666/code_runner.nvim",
        config = function()
            require("code_runner").setup({
                filetype = {
                    javascript = "node",
                    java = "cd $dir && javac $fileName && time java $fileNameWithoutExt",
                    c =
                    "cd $dir && clang -g -Wl,-stack_size -Wl,0x10000000 -Wextra -fsanitize=address -Wall -Wsign-compare -Wwrite-strings -Wtype-limits $fileName -o $fileNameWithoutExt && time $dir/$fileNameWithoutExt",
                    cpp =
                    "cd $dir && clang++ -g -Wextra -fsanitize=address -Wall -Wsign-compare -Wwrite-strings -Wtype-limits $fileName -o $fileNameWithoutExt && time $dir/$fileNameWithoutExt",
                    python = "time python3 -u",
                    typescript = "time deno run",
                    sh = "zsh",
                    rust = "cd $dir && rustc $fileName && time $dir/$fileNameWithoutExt",
                },
            })
        end,
    },
    {
        "mfussenegger/nvim-jdtls",
    },
    {
        "utilyre/barbecue.nvim",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("barbecue").setup()
        end,
    },
    "SmiteshP/nvim-navic",
    "arkav/lualine-lsp-progress",

    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = ":call mkdp#util#install()",
    },

    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require("symbols-outline").setup()
        end,
    },
})
