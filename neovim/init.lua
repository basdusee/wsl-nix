------------------------------------------------------------------------
--  NVIM CONFIG
------------------------------------------------------------------------
-- all in one big file, for easy "installation"
-- this is bad for startup times (because no parallel)
-- but it becomes very easy to copy
------------------------------------------------------------------------

-- define some locals to decrease clutter
local opt = vim.opt
local g = vim.g

-- to be considered, don't know this options
-- opt.ttimeoutlen = 5   -- type timeout??? dont know

-- ultra obvious stuff, should be default
opt.compatible = false       -- disable weird old vi compatible stuff
opt.errorbells = false       -- don't beep
opt.hidden = true            -- open file in new buffer, do not destroy old buffer
opt.encoding = "utf-8"       -- standard should be utf-8 nowadays
opt.shortmess = "flmnxtsI"   -- short messages, 
                             -- flmnx are all status bar shorts, (3 of 5), 999L, 88B etcetera
			     -- t is trunkate file mesage
			     -- s is disable "search hit BOTTOM/TOP" msgs
			     -- I is disable intro message

-- some visual stuff, to improve look&feel
opt.ruler = true             -- show the line and pos in statusbar down right
opt.signcolumn = "number"    -- extra column for error signs and stuff
-- opt.cursorline = true     -- highlight the line the cursor is on
opt.wrap = false             -- disable line wrap, it's annoying and looks messy
opt.updatetime = 300         -- faster response times, for like autocomplete
opt.lazyredraw = true        -- performance improvement when for example macro's run
opt.relativenumber = true    -- numbers relative to current line, not absolute numbers
opt.number = true            -- show actual line number on active line
opt.showmatch = true         -- show matching parenthesis
opt.showcmd = true           -- show what command is given in right bottom
opt.guicursor = ""           -- use fat cursor, like it's supposed to
opt.termguicolors = true     -- better colors in terminal
opt.background = "dark"      -- use the dark variant of color themes
-- opt.cmdheight = 2         -- 2 lines between statusbar and bottom, 
                             -- for COC messages for example

-- use mouse and system clipboard
opt.mouse = "nv"             -- mouse in normal/visual, not insert bc of pasting
-- opt.clipboard = "unnamedplus" -- broken a.f., now using just terminal copy-paste

-- search and split
opt.hlsearch = false         -- do not highlight searches, it's annoying
opt.incsearch = true         -- do direct search as you type 
opt.splitbelow = true        -- new split below, not above
opt.splitright = true        -- new split on the right, not left

-- undo and backup related stuff
opt.history = 1000           -- remember more commands and search history
opt.undolevels = 1000        -- use many muchos levels of undo
opt.undofile = true          -- save undo's between sessions aka after leaving nvim
opt.undodir = "{{userdir}}/.config/nvimdid" -- save undo's in this file TODO: make this a var
opt.backup = false           -- no ~file files (disables because vim.cmd stuff) 
opt.writebackup = false      -- do not make ~file backup files
opt.swapfile = false         -- no .swp files
-- opt.autoread = true   -- reread file if it is edited outside nvim
opt.viminfo = ""             -- disable annoying viminfo
opt.viminfofile = "NONE"     -- no annoying viminfo file

-- stuff which lua does not support goes here
-- vim.cmd [[
--     set nobackup
-- ]]

opt.pastetoggle = "<F10>"

-- augroup numbertoggle
--   autocmd!
--   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
--   autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
-- augroup END

-------------------------------------------
--  Keybindings
-------------------------------------------

-- redefine map function for automatic noremap stuff
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- arrow keys are for pussies, so we disable them
-- but keem them in insert mode, or Telescope "breaks"
map('n', '<Up>', '')
map('n', '<Down>', '')
map('n', '<Left>', '')
map('n', '<Right>', '')

-- Easy window navigation with ctrl-vi-movement
map('', '<C-h>', '<C-w>h')
map('', '<C-j>', '<C-w>j')
map('', '<C-k>', '<C-w>k')
map('', '<C-l>', '<C-w>l')

-- Center screen after movement
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- mapleader definition, we use space
g.mapleader = ' '

-- random leader bindings
map('n', '<leader>u', ':set list!<CR>')  -- toggle listchars
map('n', '<leader><leader>', '<c-^>')    -- toggle between buffers
map('n', '<leader>e', ':Fern . -drawer -toggle<CR>')   -- activate Fern
map('n', '<leader>ff', ':Telescope find_files<CR>')
map('n', '<leader>fg', ':Telescope live_grep<CR>')
map('n', '<leader>b', ':Telescope buffers<CR>')
map('n', '<leader>r', ':Telescope registers<CR>')

-- More specific meuk
--  ------------------
-- Visual stuff, only colorscheme, listchars and syntax for now
-- nvim lua doesn't have a real colorscheme function, so vim.cmd it is.
-- vim.cmd(colorscheme moonscape)
vim.cmd("colorscheme gruvbox")
opt.title = true -- change the terminal's title, totally irrelevant for me, I do not use window titles in XMonad
opt.listchars = { tab = '»·', eol = '↲', nbsp = '␣', conceal = '…', space = '␣', precedes = '<', extends = '>', trail = '·' }

-- plugin config stuff
g.rainbow_active = true   -- activate color matched parenthesis
g.tokyonight_transparent_sidebar = true
g.tokyonight_transparent = true

-- netrw stuff to make it NERDTree-like
g.netrw_banner = 0        -- kill annoying banner
g.netrw_liststyle = 3     -- treeview
g.netrw_browse_split = 4  -- open in previous window
g.netrw_altv = 1
g.netrw_winsize = 30      -- 30% size of screen

-- Screw fuzzy finder plugins, let's do it native
-- This tells VIM to look in all subdirectories for find "thing"
-- and wildmenu does display matches in a sexy bar kind of way
opt.path:append {"**"}
opt.wildmenu = true

-- use ripgrep as default grepper
-- TODO: check if rg is actually on the system, first
opt.grepprg = "rg --no-heading --vimgrep"
opt.grepformat = "%f:%l:%c:%m"

-- Language specific
-- -----------------
-- augroup configgroup
--   autocmd!
-- 
--   autocmd VimEnter * RainbowToggleOn
--   "flag unneccesary whitespace
--   autocmd BufRead, BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/  
--   
--   " voor (Python) coding PEP8 conform
--   autocmd filetype python 
--       \ set tabstop=4 |
--       \ set softtabstop=4 |
--       \ set shiftwidth=4 |
--       \ set textwidth=79 |
--       \ set expandtab |
--       \ set autoindent |
--       \ set fileformat=unix
--   autocmd filetype python colorscheme mustang
--   autocmd filetype python highlight ColorColumn ctermbg=8
--   autocmd filetype python set colorcolumn=100
--   
--   " voor C coding
--   autocmd filetype c
--       \ set tabstop=4 |
--       \ set softtabstop=0 |
--       \ set shiftwidth=4 |
--       \ set autoindent |
--       \ set fileformat=unix
--   autocmd filetype c colorscheme mustang
--   autocmd filetype h colorscheme mustang
--   
--   "Voor Rust
--   autocmd filetype rust 
--       \ colorscheme mustang |
--       \ compiler cargo
--   
--   "Voor web meuk
--   au BufNewFile,BufRead *.js, *.html, *.css
--       \ set tabstop=2 |
--       \ set softtabstop=2 |
--       \ set shiftwidth=2
--   
--   "For Clojure
--   "autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry
--   autocmd filetype lisp,clojure,scheme 
--       \ colorscheme grb256
-- 
-- 
-- augroup END


-------------------------------------------
--  LSP on-attach keybindings 
-------------------------------------------

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-------------------------------------------
--   LSP setup
-------------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_options = {
    on_attach = on_attach,
    capabilities,
}


-- -- activate all language servers, and activate autocompletion for it
require'lspconfig'['rnix'].setup(lsp_options)
require'lspconfig'['rust_analyzer'].setup(lsp_options)
require'lspconfig'['lua_ls'].setup {
  on_attach = on_attach,
  capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


-------------------------------------------
--   Autocomplete stuff
-------------------------------------------
vim.o.completeopt = "menu,menuone,noselect"

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- (stupid) REQUIREMENT - delete if snippet engine no longer necessary
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    -- strange, currently snippets from lsp gets prioritized, shouldnt be
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  }),
  -- TODO, figure out what ghost_text is. jonhoo uses it
  -- experimental = {
  --   ghost_text = true,
  -- },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

--  treesitter stuff
require("nvim-treesitter.configs").setup {

  indent = {  -- still highly experimental
    enable = true,
    disable = { "lua" },
  },

  autopairs = { enable = true, },

  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 100,
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

