local M = {}

-- nvim-dap evaluates callable configurations in a coroutine.
local function await(start)
  local thread = coroutine.running()
  start(function(value)
    vim.schedule(function()
      local ok, err = coroutine.resume(thread, value)
      if not ok then
        vim.notify(tostring(err), vim.log.levels.ERROR)
      end
    end)
  end)
  return coroutine.yield()
end

local function select(items, prompt)
  if #items == 1 then
    return items[1]
  end
  return await(function(done)
    vim.ui.select(items, { prompt = prompt }, done)
  end)
end

local function command(args, cwd)
  local result = await(function(done)
    vim.system(args, { cwd = cwd, text = true }, done)
  end)
  if result.code ~= 0 then
    vim.notify(result.stdout .. result.stderr, vim.log.levels.ERROR, { title = ".NET debug build" })
    return nil
  end
  return result.stdout
end

function M.build(config)
  local abort = vim.tbl_extend("force", {}, config, { program = require("dap").ABORT })
  local cwd = vim.fn.getcwd()
  local projects = {}
  for name, kind in
    vim.fs.dir(cwd, {
      depth = math.huge,
      skip = function(dir)
        return not vim.tbl_contains({ ".git", "bin", "obj", "node_modules" }, vim.fs.basename(dir))
      end,
    })
  do
    if kind == "file" and (name:match("%.csproj$") or name:match("%.fsproj$") or name:match("%.vbproj$")) then
      table.insert(projects, vim.fs.joinpath(cwd, name))
    end
  end
  table.sort(projects)
  if #projects == 0 then
    vim.notify("No .NET projects under cwd. Use :cd to enter your project or choose Launch file.", vim.log.levels.WARN)
    return abort
  end
  local project = select(projects, "Project to build and debug:")
  if not project then
    return abort
  end
  local directory = vim.fs.dirname(project)
  local properties = command({
    "dotnet",
    "msbuild",
    project,
    "-nologo",
    "-p:Configuration=Debug",
    "-getProperty:OutputType,TargetFramework,TargetFrameworks",
  }, directory)
  if not properties then
    return abort
  end
  local props = vim.json.decode(properties).Properties
  if props.OutputType ~= "Exe" and props.OutputType ~= "WinExe" then
    vim.notify(
      "Select an executable project that calls this library, or use <Space>td for a test.",
      vim.log.levels.WARN
    )
    return abort
  end
  local framework = props.TargetFramework
  if framework == "" and props.TargetFrameworks ~= "" then
    framework = select(vim.split(props.TargetFrameworks, ";", { trimempty = true }), "Target framework:")
    if not framework then
      return abort
    end
  end
  local target = "-p:TargetFramework=" .. framework
  vim.cmd("wall")
  vim.notify("Building " .. vim.fs.basename(project) .. " (Debug)")
  if not command({ "dotnet", "build", project, "-c", "Debug", target, "--nologo", "-v", "quiet" }, directory) then
    return abort
  end
  local program = command(
    { "dotnet", "msbuild", project, "-nologo", "-p:Configuration=Debug", target, "-getProperty:TargetPath" },
    directory
  )
  if not program then
    return abort
  end
  program = vim.trim(program)
  if vim.fn.filereadable(program) ~= 1 then
    vim.notify("Build output not found: " .. program, vim.log.levels.ERROR)
    return abort
  end
  return vim.tbl_extend("force", {}, config, { program = program, cwd = directory })
end

return M
