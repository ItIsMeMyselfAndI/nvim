-- lazy.nvim example
return {
    'brenoprata10/nvim-highlight-colors',
    config = function()
        vim.opt.termguicolors = true
        require("nvim-highlight-colors").setup {
            ---Render style
            ---@usage 'background'|'foreground'|'virtual'
            render = 'virtual',
            virtual_symbol = '■',
            virtual_symbol_prefix = '',
            virtual_symbol_suffix = ' ',
            virtual_symbol_position = 'inline',

            enable_hex = true,
            enable_short_hex = true,
            enable_rgb = true,
            enable_hsl = true,
            enable_ansi = true,
            enable_hsl_without_function = true,
            enable_var_usage = true,
            enable_named_colors = true,
            enable_tailwind = false,
            custom_colors = nil,
            exclude_filetypes = {},
            exclude_buftypes = {},
        }
    end
}
