local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({ "git", "clone", "--depth", "1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and re-open NeoVim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
    display = {
       open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    use "wbthomason/packer.nvim"
    use "nvim-lua/plenary.nvim"
    use "windwp/nvim-autopairs"
    use "numToStr/Comment.nvim"
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use "kyazdani42/nvim-web-devicons"
    use "kyazdani42/nvim-tree.lua"
    use { "akinsho/bufferline.nvim", tag = "v3.*" }
    use "nvim-lualine/lualine.nvim"
    use "akinsho/toggleterm.nvim"
    use "lukas-reineke/indent-blankline.nvim"
    use "nvchad/nvim-colorizer.lua"
    use "folke/zen-mode.nvim"
    use "folke/twilight.nvim"
    use "goolord/alpha-nvim"
    use "RRethy/vim-illuminate"
    use "xiyaowong/nvim-transparent"
--
--	-- Colorschemes
    use "folke/tokyonight.nvim"
    use { "catppuccin/nvim", as = "catppuccin" }
    use "navarasu/onedark.nvim"
--
--	-- Cmp 
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-buffer"
    use "saadparwaiz1/cmp_luasnip"
--
--	-- Snippets
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"
--
-- -- Telescope
    use "nvim-telescope/telescope.nvim"
--
--	-- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use "p00f/nvim-ts-rainbow"
--
-- -- Git
	use "lewis6991/gitsigns.nvim"

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
