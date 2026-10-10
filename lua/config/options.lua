vim.opt.number = true
vim.opt.cursorline = true
vim.opt.shiftwidth = 4
vim.opt.relativenumber = true
vim.api.nvim_create_autocmd("TermClose", {
    callback = function()
        if vim.v.event.status == 0 then
            vim.cmd("bdelete!")
        end
    end,
})
