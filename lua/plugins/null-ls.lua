local config = function()
	local null_ls = require("null-ls")

	local ca = null_ls.builtins.code_actions
	local d = null_ls.builtins.diagnostics
	local f = null_ls.builtins.formatting
	local md_ft = { filetypes = { "markdown", "vimwiki" } }
	local prettier_ft = {
		filetypes = {
			"css",
			"html",
			"javascript",
			"json",
			"markdown",
			"scss",
			"typescript",
			"typescriptreact",
		},
		disabled_filetypes = { "lua", "yaml" },
	}
	local rustywind_ft = { filetypes = { "html", "javascript", "typescript", "typescriptreact" } }
	local cs_ignore = {
		extra_args = { "--ignore-words=~/.config/codespell/ignore_words" },
	}

	local sources = {
		ca.eslint_d,
		ca.refactoring,
		ca.ltrs,
		ca.shellcheck,
		d.codespell.with(cs_ignore),
		d.clang_check,
		d.cppcheck,
		d.eslint_d,
		d.fish,
		d.hadolint,
		d.jsonlint,
		d.markdownlint.with(md_ft),
		d.misspell,
		d.shellcheck,
		d.tsc,
		f.autopep8,
		f.beautysh,
		f.black,
		f.cbfmt.with(md_ft),
		f.clang_format,
		f.codespell.with(cs_ignore),
		f.fish_indent,
		f.fixjson,
		f.markdownlint.with(md_ft),
		f.prettierd.with(prettier_ft),
		f.reorder_python_imports,
		f.rustfmt,
		f.rustywind.with(rustywind_ft),
		f.shellharden,
		f.stylua.with({ filetypes = { "lua" } }),
		f.yamlfmt.with({ filetypes = { "yaml" } }),
		require("typescript.extensions.null-ls.code-actions"),
	}

	null_ls.setup({
		sources = sources,
		should_attach = function(bufnr)
			return not vim.api.nvim_buf_get_name(bufnr):match(".env$")
		end,
		on_init = function(new_client, _)
			new_client.offset_encoding = "utf-16"
		end,
		temp_dir = "/tmp",
	})
end

return {
	"jose-elias-alvarez/null-ls.nvim",
	config = config,
	event = "BufReadPre",
}
