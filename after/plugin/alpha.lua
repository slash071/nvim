local ok, alpha = pcall(require, "alpha")
if not ok then
    return
end

math.randomseed(os.time())

local function pick_color()
    local colors = { "String", "Identifier", "Keyword", "Number", "AlphaHeader" }
    return colors[math.random(#colors)]
end

local function button(sc, txt, keybind)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
        position = "center",
        text = txt,
        shortcut = sc,
        cursor = 5,
        width = 36,
        align_shortcut = "right",
        hl = "AlphaButtons",
    }

    if keybind then
        opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
    end

    return {
        type = "button",
        val = txt,
        on_press = function()
            local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
            vim.api.nvim_feedkeys(key, "normal", false)
        end,
        opts = opts,
    }
end

local fn = vim.fn
local marginTopPercent = 0.3
local headerPadding = fn.max { 2, fn.floor(fn.winheight(0) * marginTopPercent) }

local options = {
    header = {
        type = "text",
        val = {
            "                         .^!^                                           .!~:                        ",
            "                    ^!JPB&B!.                                            !&&BPJ!:                   ",
            "                ^?P#@@@@@G.                   :       :                   !@@@@@&BY!:               ",
            "             ^JB@@@@@@@@@7                   .#~     ?P                   .&@@@@@@@@&G?:            ",
            "          .7G@@@@@@@@@@@@#!                  ?@#^   ~@@^                 .5@@@@@@@@@@@@@G7.         ",
            "        .?#@@@@@@@@@@@@@@@@BY!^.             B@@&BBB&@@Y              :~Y&@@@@@@@@@@@@@@@@#?.       ",
            "       !#@@@@@@@@@@@@@@@@@@@@@@#G5Y?!~^:..  !@@@@@@@@@@#.   ..::^!7J5B&@@@@@@@@@@@@@@@@@@@@@B!      ",
            "     .5@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&##B#@@@@@@@@@@@BBBB##&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y     ",
            "    :B@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@5    ",
            "   .B@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@?   ",
            "   5@&#BGGPPPPPGGB&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&BGGPP5PPPGBB#&#.  ",
            "   ^:..           .^!YB@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&57^.            .:^.  ",
            "                       ~G@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y.                      ",
            "                         P@@@#BGGGGB#@@@@@@@@@@@@@@@@@@@@@@@@@#BP5555PG#@@@P                        ",
            "                         :J!:.      .^!JG&@@@@@@@@@@@@@@@@#57^.        .:!5~                        ",
            "                                         :?G@@@@@@@@@@@@P!.                                         ",
            "                                            ~5@@@@@@@@5^                                            ",
            "                                              ^P@@@@G^                                              ",
            "                                                !#@?                                                ",
            "                                                 :^ ",
        },
        opts = {
            position = "center",
            hl = pick_color(),
        }, 
    },

    buttons = {
        type = "group",
        val = {
            button("SPC a n", "ﱐ  New file  ", ":ene<CR>"),
            button("SPC a f", "  Find File  ", ":Telescope find_files<CR>"),
            button("SPC a o", "  Recent File  ", ":Telescope oldfiles<CR>"),
            button("SPC a w", "  Find Word  ", ":Telescope live_grep<CR>"),
            button("SPC b m", "  Bookmarks  ", ":Telescope marks<CR>"),
            button("SPC a e", "  Quit Neovim  ", ":qa!<CR>")
        },
        opts = {
            spacing = 1,
        },
    },

    headerPaddingTop = { type = "padding", val = headerPadding },
    headerPaddingBottom = { type = "padding", val = 2 },
}

alpha.setup({
    layout = {
        options.headerPaddingTop,
        options.header,
        options.headerPaddingBottom,
        options.buttons,
    },
    opts = {}
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "alpha",
    callback = function()
        local old_laststatus = vim.opt.laststatus
        vim.api.nvim_create_autocmd("BufUnload", {
            buffer = 0,
            callback = function()
                vim.opt.laststatus = old_laststatus
            end,
        })
        vim.opt.laststatus = 0
    end,
})
