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
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                transparent_background = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    which_key = true,
                    notify = true,
                    mini = false,
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    -- {
    --     "zbirenbaum/copilot.lua",
    --     cmd = "Copilot",
    --     event = "InsertEnter",
    --     config = function()
    --         require("copilot").setup({})
    --     end,
    -- },
    --
    -- {
    --     "zbirenbaum/copilot-cmp",
    --     config = function()
    --         require("copilot_cmp").setup()
    --     end
    -- },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    { "stevearc/dressing.nvim" },
    -- Lua
    {
        "folke/persistence.nvim",
        event = "BufReadPre",                                             -- this will only start session saving when an actual file was opened
        opts = {
            dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
            options = { "buffers", "curdir", "tabpages", "winsize" },     -- sessionoptions used for saving
            pre_save = nil,                                               -- a function to call before saving the session
            save_empty = false,                                           -- don't save if there are no open file buffers
            -- add any custom options here
        }
    },
    -- {
    --     "rmagatti/auto-session",
    --     config = function()
    --         require("auto-session").setup({
    --             auto_session_enabled = true,
    --             auto_save_enabled = true,
    --             auto_restore_enabled = false,
    --             pre_save_cmds = { "NvimTreeClose", "OutlineClose", },
    --             -- post_restore_cmds = { "NvimTreeOpen", },
    --             session_lens = {
    --                 -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
    --                 buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
    --                 load_on_setup = true,
    --                 theme_conf = { border = true },
    --                 previewer = false,
    --             },
    --         })
    --     end,
    -- },
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
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup({
                filters = { custom = { "^.git$" }, },
            })
        end,
    },
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua",
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },
    {
        'famiu/bufdelete.nvim',
    },
    {
        "akinsho/bufferline.nvim",
        config = function()
            local bufferline = require("bufferline")
            bufferline.setup({
                options = {
                    close_command = "Bdelete! %d",       -- can be a string | function, | false see "Mouse actions"
                    right_mouse_command = "Bdelete! %d", -- can be a string | function | false, see "Mouse actions"
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
                            local sym = e == "error" and " " or (e == "warning" and " " or " ")
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
                -- extensions = { "nvim-tree", "symbols-outline", "nvim-dap-ui" },
                extensions = { "nvim-tree", "nvim-dap-ui" },
            })
        end,
    },
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({
                sync_root_with_cwd = true,
                respect_buf_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_root = true,
                },
            })
        end,
    },
    { "lukas-reineke/indent-blankline.nvim" },
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dap_breakpoint = {
                error = {
                    -- text = "🧘🛑⊚⭕🟢🔵🚫👉⭐️⛔️🔴",
                    text = "🔴",
                    texthl = "LspDiagnosticsSignError",
                    linehl = "",
                    numhl = "",
                },
                rejected = {
                    text = "",
                    texthl = "LspDiagnosticsSignHint",
                    linehl = "",
                    numhl = "",
                },
                stopped = {
                    text = "👉",
                    texthl = "LspDiagnosticsSignInformation",
                    linehl = "DiagnosticUnderlineInfo",
                    numhl = "LspDiagnosticsSignInformation",
                },
            }

            vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
            vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
            vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
            dap.adapters.lldb = {
                type = "executable",
                command = "/opt/homebrew/opt/llvm/bin/lldb-dap", -- adjust as needed, must be absolute path
                name = "lldb",
            }
            dap.adapters.codelldb = {
                type = 'server',
                port = "${port}",
                executable = {
                    command = '/Users/ryan/.config/nvim/lua/user/codelldb/adapter/codelldb',
                    args = { "--port", "${port}" },

                    -- On windows you may have to uncomment this:
                    -- detached = false,
                }
            }
            dap.configurations.cpp = {
                -- {
                --     name = "Launch",
                --     type = "lldb",
                --     request = "launch",
                --     program = function()
                --         return vim.fn.input("Path to executable: ",
                --             vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":r"))
                --     end,
                --     cwd = "${workspaceFolder}",
                --     stopOnEntry = true,
                --     args = function()
                --         local input = vim.fn.input("Input args: ")
                --         return require("user.util").str2argtable(input)
                --     end,
                --     -- runInTerminal = false,
                -- },
                {
                    name = "Launch file",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = true,
                },

            }
            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("nvim-dap-virtual-text").setup()
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            require("dapui").setup()
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
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
                dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
                dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("p", "󰉋  Find project", ":Telescope projects <CR>"),
                -- dashboard.button("s", "󰍣  Open session", ":lua require'auto-session.session-lens'.search_session()<CR>"),
                dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
                dashboard.button("t", "󰦨  Find text", ":Telescope live_grep <CR>"),
                dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
            }

            local function footer()
                return "Take the hits, lick our wounds, and move on."
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
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true })

                    -- Actions
                    map('n', '<leader>hs', gs.stage_hunk)
                    map('n', '<leader>hr', gs.reset_hunk)
                    map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
                    map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
                    map('n', '<leader>hS', gs.stage_buffer)
                    map('n', '<leader>hu', gs.undo_stage_hunk)
                    map('n', '<leader>hR', gs.reset_buffer)
                    map('n', '<leader>hp', gs.preview_hunk)
                    map('n', '<leader>hb', function() gs.blame_line { full = true } end)
                    map('n', '<leader>tb', gs.toggle_current_line_blame)
                    map('n', '<leader>hd', gs.diffthis)
                    map('n', '<leader>hD', function() gs.diffthis('~') end)
                    map('n', '<leader>td', gs.toggle_deleted)

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
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
            lspkind.init({
                symbol_map = {
                    -- Copilot = "",
                },
            })
            local compare = require("cmp.config.compare")
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
                sorting = {
                    priority_weight = 2,
                    comparators = {
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
                sources = {
                    -- { name = "copilot" },
                    { name = 'nvim_lsp_signature_help' },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        menu = {
                            -- copilot = "[Copilot]",
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
                    ['<C-e>'] = cmp.mapping.abort(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<CR>"] = cmp.mapping.confirm({
                        select = false,
                        behavior = cmp.ConfirmBehavior.Replace,
                    }),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    -- ["<C-d>"] = cmp.mapping(function(fallback)
                    --     if luasnip.expand_or_jumpable() then
                    --         luasnip.expand_or_jump()
                    --     end
                    -- end, { "i", "s" }),
                    -- ["<C-u>"] = cmp.mapping(function(fallback)
                    --     if luasnip.jumpable(-1) then
                    --         luasnip.jump(-1)
                    --     end
                    -- end, { "i", "s" }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
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
                sources = {
                    { name = "path" },
                    { name = "cmdline" },
                },
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
                -- root_dir = function(fname)
                --     return require("lspconfig.util").root_pattern(
                --         "Makefile",
                --         "configure.ac",
                --         "configure.in",
                --         "config.h.in",
                --         "meson.build",
                --         "meson_options.txt",
                --         "build.ninja"
                --     )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
                --         fname
                --     ) or require("lspconfig.util").find_git_ancestor(fname)
                -- end,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=chromium",
                },
                init_options = {
                    clangdFileStatus = true,
                    usePlaceholders = true,
                    completeUnimported = true,
                    -- fallbackFlags = { '--std=c++2b' },
                },
                capabilities = capabilities,
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
            })
            lspconfig.texlab.setup({
                capabilities = capabilities,
                settings = {
                    texlab = {
                        build = {
                            args = {
                                "-pdf",
                                "-xelatex",
                                "-shell-escape",
                                "-interaction=nonstopmode",
                                "-synctex=1",
                                "%f",
                            },
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
    -- {
    -- 	"jose-elias-alvarez/null-ls.nvim",
    -- 	config = function()
    -- 		require("null-ls").setup({
    -- 			sources = {
    -- 				require("null-ls").builtins.formatting.black,
    -- 				require("null-ls").builtins.formatting.stylua,
    -- 			},
    -- 		})
    -- 	end,
    -- },
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            -- This module contains a number of default definitions
            local rainbow_delimiters = require("rainbow-delimiters")

            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = rainbow_delimiters.strategy["global"],
                    vim = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            }
        end,
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            local toggleterm = require('toggleterm')
            toggleterm.setup({
                open_mapping = '<C-\\>',
                direction = 'horizontal',
                shade_terminals = true,
                close_on_exit = true,   -- close the terminal window when the process exits
                start_in_insert = true,
                insert_mappings = true, -- whether or not the open mapping applies in insert mode
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
        },
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
            telescope.load_extension("undo")
            -- telescope.load_extension("file_browser")
            -- telescope.load_extension("session-lens")
        end,
    },
    -- {
    --     "nvim-telescope/telescope-file-browser.nvim",
    --     dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    -- },
    {
        "onsails/lspkind.nvim"
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = {
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
                mode = "toggleterm",
                filetype = {
                    javascript = "node",
                    java = "cd $dir && javac $fileName && time java $fileNameWithoutExt",
                    c =
                    -- "cd $dir && clang -g -Wl,-stack_size -Wl,0x10000000 -Wextra -fsanitize=address -Wall -Wsign-compare -Wwrite-strings -Wtype-limits $fileName -o $fileNameWithoutExt && time $dir/$fileNameWithoutExt",
                    "cd $dir && clang $fileName -o $fileNameWithoutExt && time $dir/$fileNameWithoutExt",
                    cpp =
                    "cd $dir && clang++ --std=c++2b $fileName -o $fileNameWithoutExt && time $dir/$fileNameWithoutExt",
                    python = "time python3 -u",
                    typescript = "time deno run",
                    sh = "zsh",
                    -- rust = "cd $dir && rustc $fileName && time $dir/$fileNameWithoutExt",
                    rust = "cd $dir && cargo build && time cargo run",
                    markdown =
                    "pandoc -f markdown --pdf-engine=xelatex --listings --template eisvogel $fileName -o $fileNameWithoutExt.pdf",
                },
            })
        end,
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
    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({})
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = ":call mkdp#util#install()",
    },
    {
        "hedyhli/outline.nvim",
        config = function()
            require("outline").setup({
                outline_window = {
                    -- Where to open the split window: right/left
                    position = 'right',
                    -- Percentage or integer of columns
                    width = 25,
                    -- Whether width is relative to the total width of nvim
                    -- When relative_width = true, this means take 25% of the total
                    -- screen width for outline window.
                    relative_width = true,
                },
                symbol_folding = {
                    autofold_depth = false,
                    -- auto_unfold = {
                    --     hovered = true,
                    -- },
                },
                preview_window = {
                    auto_preview = false,
                },
            })
        end,
    },
    -- {
    --     'stevearc/aerial.nvim',
    --     opts = {},
    --     config = function()
    --         require("aerial").setup({
    --             backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
    --         })
    --     end,
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --         "nvim-tree/nvim-web-devicons"
    --     },
    -- },
})
