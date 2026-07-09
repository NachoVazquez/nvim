# Nvim Config Cleanup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove the leaked DB secret, dead files, and unused non-TypeScript language tooling from the LazyVim config, and replace the racy neotest adapter-swap keymaps with the supported per-run adapter API.

**Architecture:** Pure config surgery on an existing LazyVim setup — no new modules. Each phase is one jj commit. Spec: `docs/superpowers/specs/2026-07-09-nvim-cleanup-design.md`.

**Tech Stack:** Neovim 0.12.3, LazyVim, lazy.nvim, jujutsu (colocated git repo), stylua.

## Global Constraints

- All VCS via `jj` (never raw `git commit`). Run from `/Users/nachovazquez/.config/nvim`.
- No AI/Claude attribution in commit messages.
- Verification after every task: `stylua --check lua/` and a clean headless boot: `nvim --headless "+lua print('boot-ok')" +qa` must print `boot-ok` with no error output.
- There is no type-checker for this config; stylua + headless boot are the project's checks.
- Keep extras: typescript, biome, prettier, angular, astro, tailwind, json, docker, git, markdown, sql, toml, yaml, and all non-lang extras currently enabled.

---

### Task 1: Commit pending work and capture startup baseline

**Files:** none created/modified (VCS + measurement only)

**Interfaces:**
- Consumes: current jj working copy `@` containing sidekick/copilot extras, neotest-bun adapter, refactoring.nvim dep fix.
- Produces: a described commit for the pending work; baseline file `/private/tmp/claude-501/-Users-nachovazquez--config-nvim/72681a40-da74-4a1c-8dd1-3a92a24f9eae/scratchpad/startuptime-before.log` used by Task 7.

- [ ] **Step 1: Capture startup baseline (before any changes)**

```bash
nvim --startuptime /private/tmp/claude-501/-Users-nachovazquez--config-nvim/72681a40-da74-4a1c-8dd1-3a92a24f9eae/scratchpad/startuptime-before.log --headless +qa
tail -1 /private/tmp/claude-501/-Users-nachovazquez--config-nvim/72681a40-da74-4a1c-8dd1-3a92a24f9eae/scratchpad/startuptime-before.log
```

Expected: last line shows total ms (e.g. `123.456  --- NVIM STARTED ---`).

- [ ] **Step 2: Describe the pending working-copy commit**

```bash
jj describe -m "feat: add AI extras (copilot-native, sidekick), neotest-bun adapter, angular extra, refactoring.nvim dep fix"
```

- [ ] **Step 3: Open a fresh working copy for the cleanup**

```bash
jj new
jj log -r 'ancestors(@, 4)' --no-pager
```

Expected: `@` is empty with parent = the feat commit, whose parent is the spec commit.

### Task 2: Remove the leaked DB secret from options.lua

**Files:**
- Modify: `lua/config/options.lua` (whole file, currently 4 lines)
- Create: `~/.local/share/nvim/dbs.lua` (OUTSIDE the repo — never committed)

**Interfaces:**
- Produces: `vim.g.dbs` loaded from `vim.fn.stdpath("data") .. "/dbs.lua"` when that file exists; vim-dadbod behavior unchanged for the user.

- [ ] **Step 1: Create the untracked local DB file** (keeps current behavior; user must rotate the password and update this file — it is already public in git history)

Write `~/.local/share/nvim/dbs.lua` (expand `~` to `/Users/nachovazquez`):

```lua
-- Local vim-dadbod connections. NOT tracked in the nvim repo.
-- NOTE: this credential was exposed in the public repo history — rotate it,
-- then update this file.
return {
  naxo = "postgres://postgres:wZcAReAw3iq98BV3iornowXMuQ1SAGt8@atlas-nachovazquez-postgrescluster-uekmnkwx.cluster-ccfkkagy6f0p.us-east-1.rds.amazonaws.com/atlas",
}
```

- [ ] **Step 2: Replace options.lua contents entirely with**

```lua
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard

-- vim-dadbod connections live outside the repo (contains credentials)
local dbs_file = vim.fn.stdpath("data") .. "/dbs.lua"
if vim.uv.fs_stat(dbs_file) then
  vim.g.dbs = dofile(dbs_file)
end
```

- [ ] **Step 3: Verify**

```bash
stylua --check lua/
nvim --headless "+lua print(vim.g.dbs and vim.g.dbs.naxo and 'dbs-ok' or 'dbs-MISSING')" +qa
```

Expected: stylua clean; prints `dbs-ok`.

- [ ] **Step 4: Commit**

```bash
jj commit -m "fix!: move dadbod connection strings out of the repo"
```

### Task 3: Delete dead files

**Files:**
- Delete: `lua/plugins/example.lua`, `Untitled`, `snippets-bak/`, `parsers/`, `lua/config/snip/`
- Modify: `init.lua` (remove line 3)

**Interfaces:**
- Consumes: nothing from other tasks.
- Produces: `init.lua` containing only the `require("config.lazy")` bootstrap.

- [ ] **Step 1: Delete dead files/dirs**

```bash
rm lua/plugins/example.lua Untitled
rm -rf snippets-bak parsers lua/config/snip
```

(`example.lua` is inert boilerplate; `parsers/tree-sitter-vhs` is an unused local clone — the `vhs` entry in `lua/plugins/treesitter.lua` installs from upstream; `lua/config/snip/init.lua` is 100% commented out.)

- [ ] **Step 2: Replace init.lua contents entirely with**

```lua
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
```

- [ ] **Step 3: Verify**

```bash
stylua --check lua/
nvim --headless "+lua print('boot-ok')" +qa
```

Expected: stylua clean; prints `boot-ok`, no `config.snip` error.

- [ ] **Step 4: Commit**

```bash
jj commit -m "chore: remove dead files (example.lua, snip module, snippets-bak, parsers, Untitled)"
```

### Task 4: Remove unused language extras

**Files:**
- Modify: `lazyvim.json`

**Interfaces:**
- Produces: extras list without clangd/go/python/rust/zig; Task 5/6 assume these are gone.

- [ ] **Step 1: Remove exactly these five lines from the `extras` array in `lazyvim.json`**

```json
    "lazyvim.plugins.extras.lang.clangd",
    "lazyvim.plugins.extras.lang.go",
    "lazyvim.plugins.extras.lang.python",
    "lazyvim.plugins.extras.lang.rust",
    "lazyvim.plugins.extras.lang.zig",
```

Keep everything else (including docker, git, markdown, sql, toml, yaml). Result must stay valid JSON (watch trailing commas).

- [ ] **Step 2: Verify**

```bash
python3 -m json.tool lazyvim.json > /dev/null && echo json-ok
nvim --headless "+lua print('boot-ok')" +qa
```

Expected: `json-ok`, then `boot-ok`.

- [ ] **Step 3: Commit**

```bash
jj commit -m "chore: drop unused language extras (clangd, go, python, rust, zig)"
```

### Task 5: Remove Python leftovers from coding.lua

**Files:**
- Modify: `lua/plugins/coding.lua`

**Interfaces:**
- Consumes: Task 4 (python extra already removed).
- Produces: coding.lua without `uv.nvim` and without the conform python block.

- [ ] **Step 1: Delete these two specs from `lua/plugins/coding.lua`**

Delete the uv.nvim spec:

```lua
  {
    "benomahony/uv.nvim",
    opts = {
      picker_integration = true, -- Enable UI picker integration if you have one
    },
  },
```

Delete the entire conform spec (its only content is python formatters):

```lua
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = {
          -- To fix auto-fixable lint errors.
          "ruff_fix",
          -- To run the Ruff formatter.
          "ruff_format",
          -- To organize the imports.
          "ruff_organize_imports",
        },
      },
    },
  },
```

- [ ] **Step 2: Verify**

```bash
stylua --check lua/
nvim --headless "+lua print('boot-ok')" +qa
```

- [ ] **Step 3: Commit**

```bash
jj commit -m "chore: remove python leftovers (uv.nvim, ruff conform config)"
```

### Task 6: Shrink Mason ensure_installed

**Files:**
- Modify: `lua/plugins/lsp.lua:6-67`

**Interfaces:**
- Consumes: Task 4 (kept extras auto-install their own tools: vtsls, biome, prettier, angular-ls, astro-ls, tailwind-ls, json-lsp, docker LSPs, hadolint, sqlfluff, marksman, markdownlint-cli2, yaml-ls, taplo, copilot-language-server, js-debug-adapter, stylua/shfmt via LazyVim core).
- Produces: a minimal list of tools NOT covered by any kept extra.

- [ ] **Step 1: Replace the `ensure_installed` table in `lua/plugins/lsp.lua` with**

```lua
      ensure_installed = {
        "bash-language-server",
        "css-lsp",
        "eslint-lsp",
        "html-lsp",
        "shellcheck",
        "shfmt",
        "stylua",
        "vim-language-server",
      },
```

Everything removed is either owned by a kept extra (it re-ensures itself) or belongs to dropped/never-configured stacks (kotlin, php, ruby, terraform, ansible, svelte, go, rust, python, C, prose linters alex/proselint/write-good, luacheck/selene — no selene.toml/.luacheckrc exists).

- [ ] **Step 2: Verify**

```bash
stylua --check lua/
nvim --headless "+lua print('boot-ok')" +qa
```

- [ ] **Step 3: Commit**

```bash
jj commit -m "chore: trim mason ensure_installed to tools actually used"
```

### Task 7: Replace neotest adapter-swap hack with per-run adapter arg

**Files:**
- Modify: `lua/plugins/test.lua` (whole file)

**Interfaces:**
- Consumes: neotest's `args.adapter` (verified in `neotest/client/init.lua:_get_adapter` — accepts a full adapter ID like `neotest-vitest:/repo/root`); `neotest.state.adapter_ids()` lists active IDs.
- Produces: `<leader>tb` / `<leader>tv` running the current file with an explicit adapter, no runtime `neotest.setup()` calls.

- [ ] **Step 1: Replace test.lua contents entirely with**

```lua
-- Run the current file with an explicit neotest adapter (IDs look like
-- "neotest-bun:/path/to/project-root").
local function run_file_with(adapter_prefix)
  local neotest = require("neotest")
  for _, id in ipairs(neotest.state.adapter_ids()) do
    if vim.startswith(id, adapter_prefix) then
      neotest.run.run({ vim.fn.expand("%"), adapter = id })
      return
    end
  end
  vim.notify("No active " .. adapter_prefix .. " adapter in this project", vim.log.levels.WARN)
end

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
      "arthur944/neotest-bun",
    },
    opts = {
      adapters = {
        ["neotest-vitest"] = {},
        ["neotest-bun"] = {},
      },
    },
    keys = {
      {
        "<leader>tb",
        function()
          run_file_with("neotest-bun")
        end,
        desc = "Run File with Bun",
      },
      {
        "<leader>tv",
        function()
          run_file_with("neotest-vitest")
        end,
        desc = "Run File with Vitest",
      },
    },
  },
}
```

- [ ] **Step 2: Verify**

```bash
stylua --check lua/
nvim --headless "+lua print('boot-ok')" +qa
```

Full behavior needs a real JS project — flagged for Nacho's manual smoke test at the end (open a test file, `<leader>tv`).

- [ ] **Step 3: Commit**

```bash
jj commit -m "refactor: use neotest per-run adapter arg instead of setup() swapping"
```

### Task 8: Final verification, startup comparison, advance main

**Files:** none

**Interfaces:**
- Consumes: baseline from Task 1.

- [ ] **Step 1: Sync plugin state and measure**

```bash
nvim --headless "+Lazy! sync" +qa
nvim --startuptime /private/tmp/claude-501/-Users-nachovazquez--config-nvim/72681a40-da74-4a1c-8dd1-3a92a24f9eae/scratchpad/startuptime-after.log --headless +qa
tail -1 /private/tmp/claude-501/-Users-nachovazquez--config-nvim/72681a40-da74-4a1c-8dd1-3a92a24f9eae/scratchpad/startuptime-*.log
```

Expected: after-time ≤ before-time. `Lazy! sync` updates `lazy-lock.json` (removed plugins pruned); if it changed, commit it:

```bash
jj commit -m "chore: update lazy-lock after plugin cleanup"
```

(If nothing changed, jj working copy stays empty — skip the commit.)

- [ ] **Step 2: Advance the main bookmark**

```bash
jj bookmark set main -r @-
jj log -r 'ancestors(@, 10)' --no-pager
```

Expected: `main` points at the last cleanup commit.

- [ ] **Step 3: Report**

Summarize commits, startup delta, and remind Nacho: (1) rotate the RDS password, (2) manual smoke test `<leader>tb`/`<leader>tv` in a real project, (3) decide whether to `jj git push`.
