local opt = vim.opt
local o = vim.o
local fn = vim.fn

-- require("config.statuscol")

-- General
opt.numberwidth = 1
opt.number = true
opt.relativenumber = true
opt.signcolumn = "auto"
opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┨",
	vertright = "┣",
	verthoriz = "╋",
	fold = "⠀",
	eob = " ",
	diff = "┃",
	msgsep = "‾",
	foldsep = "│",
	foldclose = "▶",
	foldopen = "▼",
}
opt.confirm = true
opt.shortmess = "filnxtToOFWIcC"
opt.autoread = true
opt.lazyredraw = true
opt.updatetime = 100
opt.splitkeep = "screen"

-- Window
opt.splitright = true
opt.splitbelow = true
opt.title = true

-- Movement
opt.scrolloff = 99
opt.whichwrap = o.whichwrap .. "<,>,h,l"

-- Status
opt.showmode = false
opt.mouse = "a"
opt.showcmd = false
opt.showtabline = 0

-- Indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.linebreak = true
opt.showbreak = string.rep(" ", 3)

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum"

-- Editing
opt.modelines = 1
opt.breakindent = true
opt.showmatch = true
opt.swapfile = false
opt.undodir = fn.stdpath("data") .. "/undodir"
opt.undofile = true
opt.textwidth = 80
opt.wrap = true
opt.inccommand = "split"
opt.diffopt = {
	"internal",
	"filler",
	"closeoff",
	"hiddenoff",
	"algorithm:minimal",
}
opt.conceallevel = 0

opt.pumblend = 12
opt.cursorline = true
opt.clipboard = "unnamedplus"
opt.formatoptions = opt.formatoptions
	- "t" -- wrap with text width
	+ "c" -- wrap comments
	- "r" -- insert comment after enter
	- "o" -- insert comment after o/O
	- "q" -- allow formatting of comments with gq
	- "a" -- format paragraphs
	+ "n" -- recognized numbered lists
	- "2" -- use indent of second line for paragraph
	+ "l" -- long lines are not broken
	+ "j" -- remove comment when joining lines
opt.syntax = "off"
opt.spell = false

-- Colors
opt.termguicolors = true

-- Shada
opt.shada = "!,'1000,f1,<1000,s100,:1000,/1000,h"

-- CMP
opt.completeopt = { "menu", "menuone", "noselect" }

-- Sessions
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"