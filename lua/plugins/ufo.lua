local u = require("util")
local m = u.lazy_map

local _, maxheight = u.screen_scale()

local opts = {
	fold_virt_text_handler = require("util.ufo").handler,
	preview = {
		win_config = {
			maxheight = maxheight,
			winhighlight = "Normal:Folded",
			winblend = 0,
		},
		mappings = {
			scrollU = "<C-u>",
			scrollD = "<C-d>",
		},
	},
	close_fold_kinds = {
		"imports",
		"comment",
	},
}

local lua_ufo = function(ufo_cmd)
	return [[lua require("ufo").]] .. ufo_cmd .. [[()]]
end

return {
	"kevinhwang91/nvim-ufo",
	dependencies = "kevinhwang91/promise-async",
	event = "VeryLazy",
	opts = opts,
	init = function()
		vim.o.foldcolumn = "auto"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
	end,
	keys = {
		m("zR", lua_ufo("openAllFolds")),
		m("zM", lua_ufo("closeAllFolds")),
		m("zr", lua_ufo("openFoldsExceptKinds")),
		m("zm", lua_ufo("closeFoldsWith")),
		m("]z", lua_ufo("goNextClosedFold")),
		m("[z", lua_ufo("goPreviousClosedFold")),
		m("<leader>o", "UfoToggleFold"),
		m("\\", "FoldParagraph"),
	},
}
