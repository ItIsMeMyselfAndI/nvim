require('blink.cmp').setup({
    keymap = { preset = 'default' },
    completion = { documentation = { auto_show = true } },
    fuzzy = { implementation = "lua" },
    signature = { enabled = true },
})

for _, server in pairs(SERVERS) do
    vim.lsp.config(server, {
        capabilities = require('blink.cmp').get_lsp_capabilities()
    })
end
