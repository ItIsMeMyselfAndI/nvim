-- oil
vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "Open Oil file explorer" })
-- lsp
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "List references" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics in location list" })
vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, { desc = "Format buffer" })
-- copilot chat
vim.keymap.set({ "n", "v", "x" }, "<leader>cc", ":CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat window" })
vim.keymap.set("v", "<leader>ce", ":CopilotChatExplain<CR>", { desc = "Explain selected code with Copilot" })
vim.keymap.set("v", "<leader>co", ":CopilotChatOptimize<CR>", { desc = "Optimize selected code with Copilot" })
vim.keymap.set("v", "<leader>cf", ":CopilotChatFix<CR>", { desc = "Fix selected code with Copilot" })
vim.keymap.set("n", "<leader>cs", ":CopilotChatSave ", { desc = "Save Copilot Chat session" })
vim.keymap.set("n", "<leader>cl", ":CopilotChatLoad ", { desc = "Load Copilot Chat session" })
