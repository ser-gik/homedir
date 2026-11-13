local cmp = require('cmp')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

cmp.setup({
    preselect = cmp.PreselectMode.None,

    completion = {
        completeopt = 'menu,menuone,noselect',
    },

    window = {
        completion = {
        },

        documentation = {
            border = 'single',
        },
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),

        ['<CR>'] = cmp.mapping.confirm({
            select = false,
        }),

        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    }),

    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    },
})

vim.lsp.config('*', {
    capabilities = capabilities,
})

vim.lsp.enable({
    'clangd',
    'gopls',
    'rust_analyzer',
    'slang_server',
    'basedpyright',
    'starpls',
})



vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.lsp.start({
      name = "make-ls",
      cmd = { "make-ls" },
      root_dir = vim.fs.root(0, { "Makefile", "makefile", "GNUmakefile" }),
    })
  end,
})
