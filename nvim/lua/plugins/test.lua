-- Neotest. The rust extra already registers the `rustaceanvim.neotest` adapter
-- as optional, so importing this is all that's needed to activate it.
return {
  { import = "lazyvim.plugins.extras.test.core" },
}
