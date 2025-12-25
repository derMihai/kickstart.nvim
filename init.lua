--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/


  And then you can explore or search through `:help lua-guide`
  - https://neovim.io/doc/user/lua-guide.html


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- vim.g.icons_enabled = false

-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end
-- vim.o.sessionoptions = vim.o.sessionoptions .. ",options,localoptions"
-- vim.o.sessionoptions = "blank,curdir,terminal,globals"

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local function set_colors(mode)
  vim.opt.background = mode
  local colors
  if mode == 'light' then
    colors = {
      bg0 = "#ffffff",
      bg1 = "#f8f8f8",
    }
  else
    colors = {
      bg0 = "#000000",
      bg1 = "#101010",
    }
  end

  require('onedark').setup {
    -- Set a style preset. 'dark' is default.
    -- style = 'dark', -- dark, darker, cool, deep, warm, warmer, light
    -- style = 'light', -- dark, darker, cool, deep, warm, warmer, light
    style = mode,
    colors = colors,
  }
  require('onedark').load()
end

local last_color = 1;
local function toggle_colors()
  local colors = {'light', 'dark'}
  last_color = last_color % 2 + 1
  set_colors(colors[last_color])
end

-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration
  'lervag/vimtex',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  {
    'github/copilot.vim',
    config = function ()
        vim.keymap.set('i', '<C-E>', 'copilot#Accept("\\<CR>")', {
          expr = true,
          replace_keycodes = false
        })
        vim.g.copilot_no_tab_map = true
        vim.api.nvim_command("Copilot disable")
    end,
    event = "VeryLazy",
    keys = {
      { "<leader>Ce", "<cmd>Copilot enable<cr>", desc = "Copilot [e]nable" },
      { "<leader>Cd", "<cmd>Copilot disable<cr>", desc = "Copilot [d]isable" },
    }
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    event = "VeryLazy",
    keys = {
      { "<leader>Cp", "<cmd>CopilotChatPrompts<cr>", desc = "chat [p]rompts", mode = {'n', 'v'} },
      { "<leader>Cc", "<cmd>CopilotChat<cr>", desc = "[c]hat", mode = {'n', 'v'} },
    }
  },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',  opts = { icons = { mappings = false } } },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        local function opendiff(picker, item, match_expr)
          picker:norm(function()
            if item then
              picker:close()
              local commit = item.text:match(match_expr)
              -- print(commit)
              if commit then
                gs.diffthis(commit)
              end
            end
          end)
        end

        -- Actions
        -- normal mode
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
        map('n', '<leader>hB', function()
          gs.blame_line { full = false }
        end, { desc = 'git [B]lame line' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = 'git diff against last commit' })
        map('n', '<leader>hc', function()
          require('snacks.picker').git_log({
            confirm = function(picker, item)
              opendiff(picker, item, "^(%S+)")
            end
          })
        end, { desc = 'git diff against [c]ommit' })
        map('n', '<leader>hb', function()
          require('snacks.picker').git_branches({
            confirm = function(picker, item)
              opendiff(picker, item, "%S+%s+(%S+)")
            end,
            all = true,
          })
        end, { desc = 'git diff against [b]ranch' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
      end,
    },
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      -- set_colors(vim.opt.background._value or 'light')
      set_colors('light')

      vim.keymap.set({ 'n', 'v' }, '<leader>b', toggle_colors, { desc = '[l]ight theme' })
      require('which-key').add {
        { "<leader>b", desc = "toggle [b]ackground color" },
      }
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = {},
        lualine_z = { 'location' }
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- snacks.picker replaces telescope
  {
    "folke/snacks.nvim",
    -- "dpetka2001/snacks.nvim",
    -- branch = "fix/preview_hack_win_opts",
    priority = 1000,
    lazy     = false,
    ---@type snacks.Config
    opts = {
      picker = {
        -- your picker configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        enabled = true,
        win = {
          preview = { wo = { number = false, relativenumber = false }},
        },
        prompt = " > ",
        icons = { files = { enabled = false } },
        formatters = { file = { truncate = 80 }},
        main = {
          -- allow opening a buffer in a window currently occupied by terminal
          file = false,
        },
      },
    },
    keys  = {
      { "<leader>sf",      function() Snacks.picker.files() end,                              desc = '[s]earch [f]ile ' },
      { '<leader>sF',      function() Snacks.picker.files({ dirs = { find_git_root() } }) end,     desc = '[s]earch [F]iles in git root' },
      { '<leader>sh',      function() Snacks.picker.help() end,                               desc = '[s]earch [h]elp' },
      { '<leader>sw',      function() Snacks.picker.grep_word() end,                          desc = '[s]earch current [w]ord' },
      { '<leader>sW',      function() Snacks.picker.grep_word({ dirs = { find_git_root() } }) end, desc = '[s]earch current [W]ord in git root' },
      { '<leader>sg',      function() Snacks.picker.grep() end,                               desc = '[s]earch by [g]rep' },
      { '<leader>sG',      function() Snacks.picker.grep({ dirs = { find_git_root() } }) end, desc = '[s]earch by [G]rep in git root' },
      { '<leader>sd',      function() Snacks.picker.diagnostics() end,                        desc = '[s]earch [d]iagnostics' },
      { '<leader>sr',      function() Snacks.picker.resume() end,                             desc = '[s]earch [r]esume' },
      { '<leader><space>', function() Snacks.picker.buffers() end,                            desc = '[ ] Find existing buffers' },
      { '<leader>sP',     function() Snacks.picker.pickers() end,                            desc = '[s]earch [p]ickers' },
      { "<leader>/",      function() Snacks.picker.lines( { layout = { preset = "vscode", preview = "preview" } }) end, desc = "fuzzy [/]" },
    }
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Rulers
vim.o.cc = '80,100'

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- vim.o.completeopt = 'menuone,noselect,longest'
-- Make autocompletion in command mode to match longest prefix
vim.o.wildmode = 'longest:full'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.api.nvim_command("autocmd TermOpen * setlocal nonumber")
vim.api.nvim_command("autocmd TermOpen * setlocal norelativenumber")
-- workaround buffers picker enabling lines in all views
vim.api.nvim_command("autocmd TermEnter * setlocal nonumber")
vim.api.nvim_command("autocmd TermEnter * setlocal norelativenumber")

-- remove trailing whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = {"*.c", "*.h", "*.py", "*.sh", "*.rs", "*.cpp", "*.lua", "Makefile*, *.rst"},
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- auto-center when jumping
vim.keymap.set({'n', 'v'}, '<C-d>', '<C-d>zz')
vim.keymap.set({'n', 'v'}, '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '[c', '[czz', { desc = 'Go to previous change' })
vim.keymap.set('n', ']c', ']czz', { desc = 'Go to next change' })

-- enable/disable spellcheck
vim.keymap.set('n', '<leader>ls',
  function()
    vim.api.nvim_command('set spell')
  end, { desc = '[S]pell' })
vim.keymap.set('n', '<leader>ln',
  function()
    vim.api.nvim_command('set nospell')
  end, { desc = '[N]ospell' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count =  1 }) end, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- See `:help telescope.builtin`
-- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- vim.keymap.set('n', '<leader>/', function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 10,
--     previewer = false,
--   })
-- end, { desc = '[/] Fuzzily search in current buffer' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'proto', 'devicetree', },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = {},
    -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
    modules = {},
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
  }
end, 0)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- map buffer-local LSP
  local nmap = function(keys, func, desc, options)
    if desc then
      desc = 'LSP: ' .. desc
    end

    options = options or {}

    options.buffer = bufnr
    options.desc = desc

    vim.keymap.set('n', keys, func, options)
  end

  local picker = require('snacks').picker;

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame', {})

  nmap('<leader>ca', vim.lsp.buf.code_action, 'code [a]ction', {})
  nmap('<leader>ci', function() vim.diagnostic.config({ virtual_lines = false, virtual_text = true }) end, '[i]nline diagnostics', {})
  nmap('<leader>cm', function() vim.diagnostic.config({ virtual_lines = true, virtual_text = false }) end, '[m]ultiline diagnostics', {})
  nmap('<leader>cd', function() vim.diagnostic.config({ virtual_lines = false, virtual_text = false }) end, '[d]isable diagnostics', {})

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation', {})

  -- Lesser used LSP functionality
  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder', {})
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder', {})
  -- nmap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders', {})

  nmap('<leader>ss', picker.lsp_workspace_symbols, '[s]earch workspace [s]ymbols', {})
  nmap("gd", picker.lsp_definitions, "[g]oto [d]efinition", {})
  nmap("gD", picker.lsp_declarations, "[g]oto [D]eclaration", {})
  nmap("gr", picker.lsp_references, "[g]oto [r]eferences", { nowait = true })
  nmap("gI", picker.lsp_implementations, "[g]oto [I]mplementation", {})
  nmap("gy", picker.lsp_type_definitions, "[g]oto T[y]pe Definition", {})

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
require('which-key').add {
  { "<leader>c",  group = "[c]ode" },
  { "<leader>c_", hidden = true },
  { "<leader>C",  group = "[C]opilot" },
  { "<leader>C_", hidden = true },
  { "<leader>g",  group = "[G]it" },
  { "<leader>g_", hidden = true },
  { "<leader>h",  group = "Git [H]unk" },
  { "<leader>h_", hidden = true },
  { "<leader>r",  group = "[R]ename" },
  { "<leader>r_", hidden = true },
  { "<leader>s",  group = "[S]earch" },
  { "<leader>s_", hidden = true },
  { "<leader>t",  group = "[T]oggle" },
  { "<leader>t_", hidden = true },
  { "<leader>l",  group = "spe[l]ling" },
  { "<leader>l_", hidden = true },
}
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').add({
  { "<leader>",  group = "VISUAL <leader>", mode = "v" },
  { "<leader>h", desc = "Git [H]unk",       mode = "v" },
})


-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
vim.lsp.config('texlab', {
  filetypes = {"tex", "bib"},
  on_attach = on_attach,
})

vim.lsp.config('ltex', {
  filetypes = {"tex", "bib"},
  on_attach = on_attach,
})

vim.lsp.config('bashls', {
  on_attach = on_attach,
})

vim.lsp.config('clangd', {
  cmd = { "clangd", "--header-insertion=never", -- do not auto-insert missing headers
    "--offset-encoding=utf-16", -- fix some warning
    -- e.g. for RIOT, we need to fix only one compilation database
    vim.env.FIX_COMPILE_COMMANDS_DIR,
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }, -- exclude "proto".
  on_attach = on_attach,
})

vim.lsp.config('pyright', {
  on_attach = on_attach,
})

vim.lsp.config('rust_analyzer', {
  on_attach = on_attach,
  cmd = { "rust-analyzer" },
  settings = {
    ['rust-analyzer'] = {
      diagnostics = { enable = true },
      check = { command = 'clippy' },
    }
  },
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
  on_attach = on_attach,
})
vim.lsp.config('typos_lsp', {
  init_options = {
    -- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
    -- Defaults to error.
    diagnosticSeverity = "Hint"
  },
  on_attach = on_attach,
})

vim.lsp.config("commit-lsp", {
    cmd = { "commit-lsp", "run" },
    root_markers = { '.git' },
    filetypes = { "gitcommit" }
})

if vim.fn.executable("commit-lsp") == 1 then
    vim.lsp.enable("commit-lsp")
end

if vim.fn.executable("rust-analyzer") == 1 then
    vim.lsp.enable("rust_analyzer")
end

-- I think these should happen in this order and after vim.lsp.config()
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'texlab', 'ltex', 'bashls', 'clangd', 'pyright', 'lua_ls', 'typos_lsp' }
})

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  -- performance = {
  --    debounce = 500,
  --    throttle = 550,
  --    fetching_timeout = 80,
  -- },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<Tab>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    -- Think of <c-l> as moving to the right of your snippet expansion.
    --  So if you have a snippet that's like:
    --  function $name($args)
    --    $body
    --  end
    --
    -- <c-l> will move you to the right of each of the expansion locations.
    -- <c-h> is similar, except moving you backwards.
    ['<C-l>'] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
