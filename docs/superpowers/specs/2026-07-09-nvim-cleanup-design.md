# Nvim Config Cleanup & Startup Trim — Design

Date: 2026-07-09
Repo: github.com/NachoVazquez/nvim (public, jj-colocated)

## Goal

Health-check and slim the LazyVim config: remove exposed secrets, dead files,
and the unused non-TypeScript language footprint; fix the fragile neotest
adapter hack. All VCS operations via jujutsu.

## Approved decisions

- Approach: phased cleanup (commit pending work first, then cleanup phases).
- Languages kept: TypeScript/JS ecosystem only (typescript, biome, prettier,
  angular, astro, tailwind, json) plus utility extras: docker, git, markdown,
  sql, toml, yaml, test.core, dap.core, and all non-lang extras already enabled.
- Languages removed: clangd, go, python, rust, zig extras.
- SQL and Docker extras: keep both.

## Security finding (urgent)

`lua/config/options.lua` hardcodes a Postgres connection string with password
for an AWS RDS instance (`vim.g.dbs`). The repo is public and the secret is in
git history — treat the credential as compromised and rotate it. The config
fix is to load it from outside the repo (e.g. `vim.g.dbs` read from a
non-tracked `~/.local/share/nvim/dbs.lua` or an env var). History rewrite is
out of scope; rotation makes it moot.

## Phases

### Phase 0 — Commit pending work (no code changes)

Describe the current jj working copy (sidekick/copilot extras, neotest-bun
adapter + keymaps, refactoring.nvim dependency fix) as its own commit and move
the `main` bookmark forward. Cleanup starts from a clean revision.

### Phase 1 — Secrets + dead code removal

- Remove the `vim.g.dbs` secret from `options.lua`; load DB connections from
  a non-tracked local file if present.
- Delete: `lua/plugins/example.lua`, `Untitled`, `snippets-bak/`,
  `parsers/` (local tree-sitter-vhs clone; the `vhs` parser in
  `treesitter.lua` installs from upstream and does not use this dir),
  `lua/config/snip/` and its `require` in `init.lua` (fully commented out).

### Phase 2 — Trim language footprint

- `lazyvim.json`: remove `lang.clangd`, `lang.go`, `lang.python`,
  `lang.rust`, `lang.zig`.
- `lua/plugins/coding.lua`: remove `uv.nvim` and the ruff/python conform
  block.
- `lua/plugins/lsp.lua`: shrink Mason `ensure_installed` to tools the kept
  extras don't already install: shell (bash-ls, shellcheck, shfmt), lua
  (stylua, selene), web (css-lsp, html-lsp, eslint-lsp), vim-language-server.
  Drop kotlin/php/ruby/terraform/ansible/svelte/go/rust/python/C tooling and
  prose linters (alex, proselint, write-good) unless the user objects.
- Note: removing extras does not uninstall Mason packages or treesitter
  parsers already on disk; optional `:MasonUninstall`/prune afterwards.

### Phase 3 — Fix neotest adapter hack

Replace the `<leader>tb`/`<leader>tv` runtime `neotest.setup()` swap (racy,
unsupported) with neotest's supported per-run adapter selection
(`neotest.run.run({ ..., adapter = <id> })` — exact form verified against
neotest docs during implementation). Behavior kept: run current file with bun
or vitest explicitly.

## Verification (each phase)

- `stylua --check lua/` (the repo's configured formatter; no other
  type-checker exists for this config — stated per verification rules).
- Headless boot: `nvim --headless "+lua print('ok')" +qa` exits clean with no
  errors.
- Before/after `nvim --startuptime` comparison (Phase 2).
- Manual smoke test by Nacho after Phase 3 (`<leader>tb`/`<leader>tv`).

## Out of scope

- Restructuring plugin file layout.
- Git history rewrite for the leaked secret (rotation supersedes it).
- Uninstalling already-downloaded Mason packages (left as optional manual
  step).
