# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.


## .NET debugging

Open Neovim in your solution or project directory, or use `:cd` to set it.
Open a C#, F#, or VB source file, set a breakpoint with `F9`, then press `F5`
and select **.NET: Build and debug project**. Choose the executable project
that calls the code you want to debug. The picker searches under Neovim's
current directory. For projects with multiple target frameworks, choose one.

This saves open buffers, builds the selected project in Debug mode, and uses
MSBuild to locate its output. The working directory is the selected project's
directory. Execution pauses at entry; press `F5` to reach your breakpoint.
The debugger UI opens automatically with locals, watches, and the call stack.
Console input and output use an integrated terminal.

| Action | Key | Leader alternative |
| --- | --- | --- |
| Start / continue | `F5` | `<Space>dc` |
| Toggle breakpoint | `F9` | `<Space>db` |
| Step over | `F10` | `<Space>dO` |
| Step into | `F11` | `<Space>di` |
| Step out | `Shift+F11` | `<Space>do` |
| Stop | `Shift+F5` | `<Space>dt` |
| Inspect expression or selection | | `<Space>de` |
| Toggle debugger UI | | `<Space>du` |
| Run to cursor | | `<Space>dC` |
| Conditional breakpoint | | `<Space>dB` |

Use the leader alternatives if your terminal intercepts a function key.
`<Space>da` starts a configuration with command-line arguments.
**Launch file** launches an already-built DLL; **.NET: Attach to process**
lets you select a running process. Existing `.vscode/launch.json`
configurations can use either `netcoredbg` or `coreclr` as their adapter type.

For tests supported by Neotest, `<Space>td` debugs the nearest test.
Console-based test runners, including the ones in `advanced-csharp`, use
**.NET: Build and debug project** instead. To debug a class library, select
an executable that references it and set breakpoints in the library source.
