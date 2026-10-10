local function setupCSharp(dap)
    dap.adapters.coreclr = {
        type = "executable",
        command = "netcoredbg",
        args = { "--interpreter=vscode" },
    }
    dap.configurations.cs = {
        {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            program = function()
                return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopAtEntry = false,
            console = "integratedTerminal",
        },
    }
end

local function setupBash(dap)
    local mason_path = vim.fn.stdpath("data") .. "/mason"
    local bashdb_dir = mason_path .. "/packages/bash-debug-adapter/extension/bashdb_dir"

    dap.adapters.bashdb = {
        type = "executable",
        command = mason_path .. "/bin/bash-debug-adapter",
        name = "bashdb",
    }
    dap.configurations.sh = {
        {
            type = "bashdb",
            request = "launch",
            name = "Launch bash debugger",
            showDebugOutput = true,
            pathBashdb = bashdb_dir .. "/bashdb",
            pathBashdbLib = bashdb_dir,
            trace = true,
            file = "${file}",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            pathCat = "cat",
            pathBash = "/bin/bash",
            pathMkfifo = "mkfifo",
            pathPkill = "pkill",
            args = {},
            argsString = "",
            env = {},
            terminalKind = "integrated",
        },
    }
end

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio", -- richiesto da dap-ui
        "theHamsta/nvim-dap-virtual-text",
        "mason-org/mason.nvim",
    },

    keys = {
        {
            "<leader>db",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "Toggle Breakpoint",
        },
        {
            "<leader>dc",
            function()
                require("dap").continue()
            end,
            desc = "Run/Continue",
        },
        {
            "<leader>dC",
            function()
                require("dap").run_to_cursor()
            end,
            desc = "Run to Cursor",
        },
        {
            "<leader>di",
            function()
                require("dap").step_into()
            end,
            desc = "Step Into",
        },
        {
            "<leader>do",
            function()
                require("dap").step_out()
            end,
            desc = "Step Out",
        },
        {
            "<leader>dO",
            function()
                require("dap").step_over()
            end,
            desc = "Step Over",
        },
        {
            "<leader>dt",
            function()
                require("dap").terminate()
            end,
            desc = "Terminate",
        },
        {
            "<leader>dr",
            function()
                require("dap").repl.toggle()
            end,
            desc = "Apri/chiudi console debug (REPL)",
        },
        {
            "<leader>dl",
            function()
                require("dap").run_last()
            end,
            desc = "Run Last",
        },
    },

    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require("nvim-dap-virtual-text").setup()
        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- C# --
        setupCSharp(dap)
        -- Bash --
        setupBash(dap)
    end,
}
