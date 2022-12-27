local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
  ensure_installed = { "rust", "python", "c", },
	ignore_install = { "" },
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
	indent = { enable = true, disable = { "python", "css" } },
})
