local M = {}

-- @brief Returns the number of processing cores for clangd to use, default is 4
local nproc = function()
    local procn = tonumber(vim.fn.system('nproc'))
    if procn == nil then
        return 4
    else
        return procn
    end
end

-- TODO: find a way to use gcc for c files and g++ for cpp files, as otherwise the diagnostics are not correct
M.server = {
    cmd = {
        "clangd",
        -- '--query-driver=*',
        "--background-index",
        "--header-insertion=iwyu", -- never
        "--clang-tidy",
        "-j=" .. nproc(),
        "--header-insertion-decorators",
        "--all-scopes-completion",
        "--pch-storage=memory",
        '--offset-encoding=utf-16'
    },
}

M.extensions = {
    -- defaults:
    -- Automatically set inlay hints (type hints)
    autoSetHints = true,
    -- These apply to the default ClangdSetInlayHints command
    inlay_hints = {
        -- Only show inlay hints for the current line
        only_current_line = false,
        -- Event which triggers a refersh of the inlay hints.
        -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
        -- not that this may cause  higher CPU usage.
        -- This option is only respected when only_current_line and
        -- autoSetHints both are true.
        only_current_line_autocmd = "CursorHold",
        -- whether to show parameter hints with the inlay hints or not
        show_parameter_hints = true,
        -- prefix for parameter hints
        parameter_hints_prefix = " ",
        -- prefix for all the other hints (type, chaining)
        other_hints_prefix = " ",
        -- whether to align to the length of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 7,
        -- The color of the hints
        highlight = "LspInlayHint", -- "GruvboxBlue",
        -- The highlight group priority for extmark
        priority = 100,
    },
    ast = {
        role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
        },
        kind_icons = {
            Compound = "",
            Recovery = "",
            TranslationUnit = "",
            PackExpansion = "",
            TemplateTypeParm = "",
            TemplateTemplateParm = "",
            TemplateParamObject = "",
        },
        highlights = {
            detail = "Comment",
        },
        memory_usage = {
            border = "none",
        },
        symbol_info = {
            border = "none",
        },
    },
}

return M
