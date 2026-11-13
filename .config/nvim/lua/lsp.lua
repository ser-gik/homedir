vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,

    float = {
        border = 'single',
        source = 'if_many',
        focusable = false,
    },

    severity_sort = true,
})

local function setup_keymaps(bufnr)
    local opts = { buffer = bufnr, silent = true }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    vim.keymap.set('n', 'K', function()
        vim.lsp.buf.hover({
            border = 'single',
            focusable = false,
        })
    end, opts)

    vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)

    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

    vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol, opts)
    vim.keymap.set('n', 'gS', vim.lsp.buf.workspace_symbol, opts)

    vim.keymap.set('n', '[g', function()
        vim.diagnostic.jump({ count = -1 })
    end, opts)

    vim.keymap.set('n', ']g', function()
        vim.diagnostic.jump({ count = 1 })
    end, opts)
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf

        setup_keymaps(bufnr)

        vim.api.nvim_create_autocmd('CursorHold', {
            buffer = bufnr,
            callback = function()
                vim.diagnostic.open_float(nil, {
                    focus = false,
                })
            end,
        })
    end,
})

require('lsp_signature').setup({
    bind = true,
    handler_opts = {
        border = 'single',
    },
    hint_enable = false,
    floating_window = true,
    close_timeout = 4000,
    fix_pos = true,
})
