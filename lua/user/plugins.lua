local fn = vim.fn

-- automatically setup packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.notify("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- run :PackerSync everytime this file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local packer = require("packer")

-- open packer in a floating window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "solid" })
		end,
	},
})

return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- packer manages itself

	-- a few common dependencies
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")
	use("kyazdani42/nvim-web-devicons")

	-- lsp
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")

	-- cmp
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("saadparwaiz1/cmp_luasnip")
	use("hrsh7th/cmp-nvim-lsp")
	use("onsails/lspkind-nvim")

	-- null-ls
	use("jose-elias-alvarez/null-ls.nvim")

	-- language specific
	use("simrat39/rust-tools.nvim")
	use("davidgranstrom/nvim-markdown-preview")

	-- lsp related plugins
	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup() -- customize
		end,
	})

	-- debugging TODO
	-- use 'mfussenegger/nvim-dap'

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-fzy-native.nvim")
	use("nvim-telescope/telescope-symbols.nvim")
	use("nvim-telescope/telescope-ui-select.nvim")

	-- programming helpers
	use("phaazon/hop.nvim")
	use("numToStr/Comment.nvim")
	use("windwp/nvim-autopairs")
	use({
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup() -- TODO customize
		end,
	})
	use("akinsho/toggleterm.nvim")
	use("rmagatti/auto-session")
	use("rmagatti/session-lens")

	-- appearance
	use("LunarVim/onedarker.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({ options = { theme = "onedarker" } }) -- TODO customize
		end,
	})
	use("akinsho/bufferline.nvim")

	use("folke/which-key.nvim")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
