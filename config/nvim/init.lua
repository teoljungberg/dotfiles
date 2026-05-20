vim.cmd.source("~/.vimrc")

vim.g.editorconfig = false

if vim.fn.exists("&winborder") == 1 then
  vim.o.winborder = "single"
end

local t_nvimrc = vim.api.nvim_create_augroup("nvimrc", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
  group = t_nvimrc,
  pattern = { "*/nvim/init.lua", "init.local.lua", "*/plugin/*.lua" },
  callback = function(_)
    vim.bo.keywordprg = ":help"
    vim.b.dispatch = ":Runtime %:p"
  end,
})

vim.diagnostic.config({
  virtual_text = true,
})

vim.api.nvim_set_hl(0, "DiagnosticError", { link = "Comment" })
vim.api.nvim_set_hl(0, "DiagnosticHint", { link = "Comment" })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { link = "Comment" })
vim.api.nvim_set_hl(0, "DiagnosticOk", { link = "Comment" })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { link = "Comment" })

if vim.lsp and vim.lsp.config and vim.lsp.enable then
  local servers = {}

  if vim.fn.executable("lua-language-server") == 1 then
    vim.lsp.config("lua_ls", {
      cmd = { "lua-language-server" },
      root_markers = { ".git" },
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim", "hs" },
          },
          workspace = {
            library = {
              vim.env.VIMRUNTIME,
              "${3rd}/luv/library",
            },
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
    table.insert(servers, "lua_ls")
  end

  if vim.fn.executable("ruby-lsp") == 1 then
    table.insert(servers, "ruby_lsp")
  end

  if vim.fn.executable("typescript-language-server") == 1 then
    table.insert(servers, "ts_ls")
  end

  if #servers > 0 then
    vim.lsp.enable(servers)
  end
end

local t_lsp = vim.api.nvim_create_augroup("t_lsp", { clear = true })

vim.api.nvim_create_autocmd("DiagnosticChanged", {
  group = t_lsp,
  callback = function(args)
    if args.buf == vim.api.nvim_get_current_buf() then
      local close_loclist_if_empty = function()
        if #vim.fn.getloclist(0) == 0 then
          vim.cmd.lclose()
        end
      end

      vim.diagnostic.setloclist({ open = false })
      vim.schedule(close_loclist_if_empty)
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = t_lsp,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    -- Disable any LSP per-buffer by setting b:disable_{name}, e.g.:
    --   lua: vim.b.disable_ruby_lsp = true
    --   vimscript: let b:disable_ruby_lsp = 1
    local bufnr = args.buf
    local is_disabled = vim.b[bufnr]["disable_" .. client.name]
    if is_disabled then
      vim.lsp.buf_detach_client(bufnr, args.data.client_id)
      return
    end

    local supports = function(method)
      return client:supports_method(method, bufnr)
    end

    local map = function(keys, lsp_function, description)
      vim.keymap.set(
        "n",
        keys,
        lsp_function,
        { buffer = bufnr, desc = "LSP: " .. description }
      )
    end

    if supports("textDocument/completion") then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      vim.bo[bufnr].completefunc = "v:lua.vim.lsp.omnifunc"
    end

    if supports("textDocument/definition") then
      map("gd", vim.lsp.buf.definition, "Go to definition")
    end

    if supports("textDocument/declaration") then
      map("gD", vim.lsp.buf.declaration, "Go to declaration")
    end

    -- Override `<Plug>(ale_lint)` from vimrc
    map("`==", function()
      vim.diagnostic.setloclist({ open = true })
    end, "Show diagnostics in location list")

    -- Override `<Plug>(ale_hover)` from vimrc
    if supports("textDocument/hover") then
      map("`=?", vim.lsp.buf.hover, "Hover documentation")
    end

    -- Override `<Plug>(ale_fix)` from vimrc. Lua formatting goes through
    -- stylua via ALE, so skip lua_ls here.
    if client.name ~= "lua_ls" and supports("textDocument/formatting") then
      map("`=<CR>", vim.lsp.buf.format, "Format buffer")
    end

    -- LSP-era equivalent of the vimrc `<C-]>` workaround: temporarily clear
    -- `tagfunc` so `:tag` falls through to ctags instead of the LSP handler.
    map("g]", function()
      local cword = vim.fn.expand("<cword>")
      local saved_tagfunc = vim.bo[bufnr].tagfunc

      vim.bo[bufnr].tagfunc = ""
      local ok, err = pcall(vim.cmd.tag, cword)
      vim.bo[bufnr].tagfunc = saved_tagfunc

      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end, "Tag jump (ctags)")
  end,
})

local local_init = vim.fn.expand("~/.config/nvim/init.local.lua")
if vim.fn.filereadable(local_init) == 1 then
  dofile(local_init)
end

local git_safe_init = ".git/safe/../../init.local.lua"
if vim.fn.filereadable(git_safe_init) == 1 then
  dofile(git_safe_init)
end
