vim.cmd.highlight('clear')
vim.g.colors_name = 'mine_l'

local hi = function(name, val)
  -- Force links
  val.force = true

  -- Make sure that `cterm` attribute is not populated from `gui`
  val.cterm = val.cterm or {} ---@type vim.api.keyset.highlight

  -- Define global highlight
  vim.api.nvim_set_hl(0, name, val)
end

local mirLightGray1   = 'NvimLightGray1'
local mirLightGray2   = 'NvimLightGray2'
local mirLightGray3   = 'NvimLightGray3'
local mirLightGray4   = 'NvimLightGray4'
local mirDarkGray1    = 'NvimDarkGray1'
local mirDarkGray2    = 'NvimDarkGray2'
local mirDarkGray3    = 'NvimDarkGray3'
local mirDarkGray4    = 'NvimDarkGray4'
local mirDarkGreen    = '#186F00'
local mirRed          = 'Red'
local mirOrange       = 'Orange'
local mirDarkRed      = '#D42E00'
local mirDarkYellow   = '#8F7700'
local mirDarkOrange   = '#905B2C'
local mirDarkCyan     = '#12917A'
local mirDarkMagenta  = '#8D00A3'
local mirLightRed     = 'NvimLightRed'
local mirLightBlue    = 'NvimLightBlue'
local mirLightGreen   = 'NvimLightGreen'
local mirLightYellow  = 'NvimLightYellow'
local mirLightCyan    = 'NvimLightCyan'
local mirLightMagenta = 'NvimLightMagenta'
local mirWhite        = 'White'
local mirBlack        = 'Black'
local mirLinkBlue     = 'SlateBlue'

--stylua: ignore start
-- General
-- hi('Normal', {})

-- hi('Conceal',      { fg = 'LightGrey', bg = 'DarkGrey', ctermfg = 'LightGrey', ctermbg = 'DarkGrey' })
-- hi('Cursor',       {})
-- hi('lCursor',      {})
-- hi('DiffText',     { bg = 'Red', bold = true,           ctermbg = 'Red', cterm = { bold = true } })
-- hi('ErrorMsg',     { fg = 'White', bg = 'Red',          ctermfg = 'White', ctermbg = 'DarkRed' })
-- hi('IncSearch',    { reverse = true,                    cterm = { reverse = true } })
-- hi('IncSearch',    { fg = 'LightGrey', bg = 'Black', ctermfg = 'LightGrey', ctermbg = 'Black' })
-- hi('ModeMsg',      { bold = true,                       cterm = { bold = true } })
-- hi('NonText',      { fg = 'Blue', bold = true,          ctermfg = 'Blue' })
-- hi('PmenuSbar',    { bg = 'Grey',                       ctermbg = 'Grey' })
-- hi('StatusLine',   { reverse = true, bold = true,       cterm = { reverse = true, bold = true }})
-- hi('StatusLineNC', { reverse = true,                    cterm = { reverse = true } })
-- hi('TabLineFill',  { reverse = true,                    cterm = { reverse = true } })
-- hi('TabLineSel',   { bold = true,                       cterm = { bold = true } })
-- hi('TermCursor',   { reverse = true,                    cterm = { reverse = true } })
-- hi('WinBar',       { bold = true,                       cterm = { bold = true } })
-- hi('WildMenu',     { fg = 'Black', bg = 'Yellow',       ctermfg = 'Black', ctermbg = 'Yellow' })
--
hi('WinSeparator',   { link = 'VertSplit' })
-- hi('WinBarNC',       { link = 'WinBar' })
-- hi('DiffTextAdd',    { link = 'DiffText' })
-- hi('EndOfBuffer',    { link = 'NonText' })
-- hi('LineNrAbove',    { link = 'LineNr' })
-- hi('LineNrBelow',    { link = 'LineNr' })
-- hi('QuickFixLine',   { link = 'Search' })
-- hi('CursorLineSign', { link = 'SignColumn' })
-- hi('CursorLineFold', { link = 'FoldColumn' })
-- hi('CurSearch',      { link = 'Search' })
hi('PmenuKind',      { link = 'Pmenu' })
hi('PmenuKindSel',   { link = 'PmenuSel' })
hi('PmenuMatch',     { link = 'Pmenu' })
hi('PmenuMatchSel',  { link = 'PmenuSel' })
hi('PmenuExtra',     { link = 'Pmenu' })
hi('PmenuExtraSel',  { link = 'PmenuSel' })
-- hi('PreInsert',      { link = 'Added' })
-- hi('ComplMatchIns',  {})
-- hi('ComplHint',      { link = 'NonText' })
-- hi('ComplHintMore',  { link = 'MoreMsg' })
-- hi('Substitute',     { link = 'Search' })
-- hi('Whitespace',     { link = 'NonText' })
-- hi('MsgSeparator',   { link = 'StatusLine' })
-- hi('NormalFloat',    { link = 'Pmenu' })
-- hi('NormalFloat',    { link = 'Pmenu' })
hi('FloatBorder',    { link = 'WinSeparator' })
-- hi('FloatTitle',     { link = 'Title' })
-- hi('FloatFooter',    { link = 'Title' })
--
-- hi('FloatShadow',          { blend = 100})
-- hi('RedrawDebugNormal',    { reverse = true,             cterm = { reverse = true } })
-- hi('RedrawDebugClear',     { bg = 'Yellow',              ctermbg = 'Yellow' })
-- hi('RedrawDebugComposed',  { bg = 'Green',               ctermbg = 'Green' })
-- hi('RedrawDebugRecompose', { bg = 'Red',                 ctermbg = 'Red' })
-- hi('Error',                { fg = 'White', bg = 'Red',   ctermfg = 'White', ctermbg = 'Red' })
-- hi('Todo',                 { fg = 'Blue', bg = 'Yellow', ctermfg = 'Black', ctermbg = 'Yellow' })
-- hi('MatchParen',     { link = 'Visual' })
--
hi('String',         { link = 'Constant' })
hi('Character',      { link = 'Constant' })
hi('Number',         { link = 'Constant' })
hi('Boolean',        { link = 'Constant' })
hi('Float',          { link = 'Number' })
-- hi('Function',       { link = 'Function' })
-- hi('Function',       { link = 'Identifier' })
hi('Conditional',    { link = 'Statement' })
hi('Repeat',         { link = 'Statement' })
hi('Label',          { link = 'Statement' })
hi('Operator',       { link = 'Statement' })
hi('Keyword',        { link = 'Statement' })
hi('Exception',      { link = 'Statement' })
hi('Include',        { link = 'PreProc' })
hi('Define',         { link = 'PreProc' })
-- hi('Macro',          { link = 'PreProc' })
-- hi('PreProc',          { link = 'Statement' })
hi('PreCondit',      { link = 'PreProc' })
hi('StorageClass',   { link = 'Statement' })
hi('Structure',      { link = 'Statement' })
hi('Typedef',        { link = 'Statement' })
hi('Tag',            { link = 'Special' })
hi('SpecialChar',    { link = 'Constant' })
-- hi('Delimiter',      { link = 'Special' })
hi('SpecialComment', { link = 'Special' })
hi('Debug',          { link = 'Special' })
--
hi('DiagnosticError',            { fg = mirRed,                          ctermfg = 1 })
hi('DiagnosticWarn',             { fg = mirOrange,                       ctermfg = 3 })
hi('DiagnosticInfo',             { fg = mirLightBlue,                    ctermfg = 4 })
hi('DiagnosticHint',             { fg = mirLightGray3,                    ctermfg = 7 })
hi('DiagnosticOk',               { fg = mirLightGreen,                   ctermfg = 10 })
hi('DiagnosticUnderlineError',   { sp = mirRed, undercurl = true,        cterm = { underline = true } })
hi('DiagnosticUnderlineWarn',    { sp = mirOrange, undercurl = true,     cterm = { underline = true } })
hi('DiagnosticUnderlineInfo',    { sp = mirLightBlue, undercurl = true,  cterm = { underline = true } })
hi('DiagnosticUnderlineHint',    { sp = mirLightGray3, undercurl = true,  cterm = { underline = true } })
hi('DiagnosticUnderlineOk',      { sp = mirLightGreen, undercurl = true, cterm = { underline = true } })
-- hi('DiagnosticVirtualTextError', { link = 'DiagnosticError' })
-- hi('DiagnosticVirtualTextWarn',  { link = 'DiagnosticWarn' })
-- hi('DiagnosticVirtualTextInfo',  { link = 'DiagnosticInfo' })
-- hi('DiagnosticVirtualTextHint',  { link = 'DiagnosticHint' })
-- hi('DiagnosticVirtualTextOk',    { link = 'DiagnosticOk' })
-- hi('DiagnosticFloatingError',    { link = 'DiagnosticError' })
-- hi('DiagnosticFloatingWarn',     { link = 'DiagnosticWarn' })
-- hi('DiagnosticFloatingInfo',     { link = 'DiagnosticInfo' })
-- hi('DiagnosticFloatingHint',     { link = 'DiagnosticHint' })
-- hi('DiagnosticFloatingOk',       { link = 'DiagnosticOk' })
-- hi('DiagnosticSignError',        { link = 'DiagnosticError' })
-- hi('DiagnosticSignWarn',         { link = 'DiagnosticWarn' })
-- hi('DiagnosticSignInfo',         { link = 'DiagnosticInfo' })
-- hi('DiagnosticSignHint',         { link = 'DiagnosticHint' })
-- hi('DiagnosticSignOk',           { link = 'DiagnosticOk' })
-- hi('DiagnosticDeprecated',       { sp = 'Red', strikethrough = true,    cterm = { strikethrough = true } })
--
-- hi('DiagnosticUnnecessary', { link = 'Comment' })
-- hi('LspInlayHint',          { link = 'NonText' })
-- hi('SnippetTabstop',        { link = 'Visual' })
-- hi('SnippetTabstopActive',  { link = 'SnippetTabstop' })
--
-- -- Text
hi('@markup.raw',       { link = 'Constant' })
hi('@markup.link',      { link = 'Identifier' })
hi('@markup.heading',   { link = 'Title' })
hi('@markup.link.url',  { link = 'Underlined' })
hi('@markup.underline', { link = 'Underlined' })
hi('@comment.todo',     { link = 'Todo' })
--
-- -- Miscs
hi('@comment',     { link = 'Comment' })
hi('@punctuation', { link = 'Delimiter' })
--
-- -- Constants
hi('@constant',          { link = 'Constant' })
hi('@constant.builtin',  { link = 'Special' })
-- hi('@constant.macro',    { link = 'Define' })
-- hi('@keyword.directive', { link = 'Define' })
hi('@string',            { link = 'String' })
hi('@string.escape',     { link = 'SpecialChar' })
hi('@string.special',    { link = 'SpecialChar' })
hi('@character',         { link = 'Character' })
hi('@character.special', { link = 'SpecialChar' })
hi('@number',            { link = 'Number' })
hi('@boolean',           { link = 'Boolean' })
hi('@number.float',      { link = 'Float' })
--
-- -- Functions
hi('@function',                   { link = 'Function' })
-- hi('@function.builtin',           { link = 'Special' })
hi('@function.builtin',           { link = 'Macro' })
hi('@function.macro',             { link = 'Macro' })
hi('@function.method',            { link = 'Function' })
hi('@variable.parameter',         { link = 'Identifier' })
hi('@variable.parameter.builtin', { link = 'Special' })
hi('@variable.member',            { link = 'Identifier' })
hi('@property',                   { link = 'Identifier' })
hi('@attribute',                  { link = 'Macro' })
hi('@attribute.builtin',          { link = 'Special' })
hi('@constructor',                { link = 'Special' })

-- Keywords
hi('@keyword.conditional', { link = 'Conditional' })
hi('@keyword.repeat',      { link = 'Repeat' })
hi('@keyword.type',        { link = 'Structure' })
hi('@label',               { link = 'Label' })
hi('@operator',            { link = 'Operator' })
hi('@keyword',             { link = 'Keyword' })
hi('@keyword.exception',   { link = 'Exception' })

hi('@variable',          { link = 'Identifier' })
hi('@type',              { link = 'Type' })
hi('@type.builtin',      { link = 'Type' })
hi('@type.definition',   { link = 'Typedef' })
hi('@module',            { link = 'Identifier' })
hi('@keyword.import',    { link = 'Include' })
hi('@keyword.directive', { link = 'PreProc' })
hi('@keyword.debug',     { link = 'Debug' })
hi('@tag',               { link = 'Tag' })
hi('@tag.builtin',       { link = 'Special' })
--
-- -- LSP semantic tokens
hi('@lsp.type.class',         { link = 'Structure' })
hi('@lsp.type.comment',       { link = 'Comment' })
hi('@lsp.type.decorator',     { link = 'Function' })
hi('@lsp.type.enum',          { link = 'Structure' })
hi('@lsp.type.enumMember',    { link = 'Constant' })
hi('@lsp.type.function',      { link = 'Function' })
hi('@lsp.type.interface',     { link = 'Structure' })
hi('@lsp.type.macro',         { link = 'Macro' })
hi('@lsp.type.method',        { link = 'Function' })
hi('@lsp.type.namespace',     { link = 'Structure' })
hi('@lsp.type.parameter',     { link = 'Identifier' })
hi('@lsp.type.property',      { link = 'Identifier' })
hi('@lsp.type.struct',        { link = 'Structure' })
hi('@lsp.type.type',          { link = 'Type' })
hi('@lsp.type.typeParameter', { link = 'TypeDef' })
hi('@lsp.type.variable',      { link = 'Identifier' })


if vim.o.background == 'light' then
  hi('Normal',              {bg = mirWhite})
  hi('VertSplit',           { fg = mirLightGray3 })
  hi('ColorColumn',         { bg = mirLightGray1, ctermbg = 'Grey' })
  -- hi('CursorColumn',     { bg = 'Grey90',                               ctermbg = 'LightGrey' })
  -- hi('CursorLine',       { bg = 'Grey90',                               cterm = { underline = true } })
  -- hi('CursorLineNr',     { fg = 'Brown', bold = true,                   ctermfg = 'Brown', cterm = { underline = true } })
  -- hi('DiffAdd',          { bg = 'LightBlue',                            ctermbg = 'LightBlue' })
  -- hi('DiffChange',       { bg = 'LightMagenta',                         ctermbg = 'LightMagenta' })
  -- hi('DiffDelete',       { fg = 'Blue', bg = 'LightCyan', bold = true,  ctermfg = 'Blue', ctermbg = 'LightCyan' })
  -- hi('Directory',        { fg = 'Blue',                                 ctermfg = 'DarkBlue' })
  -- hi('FoldColumn',       { fg = 'DarkBlue', bg = 'Grey',                ctermfg = 'DarkBlue', ctermbg = 'Grey' })
  -- hi('Folded',           { fg = 'DarkBlue', bg = 'LightGrey',           ctermfg = 'DarkBlue', ctermbg = 'Grey' })
  -- hi('LineNr',           { fg = 'Brown',                                ctermfg = 'Brown' })
  hi('MatchParen',          { bg = mirLightGray3,                                 ctermbg = 'Gray' })
  -- hi('MoreMsg',          { fg = 'SeaGreen', bold = true,                ctermfg = 'DarkGreen' })
  -- pmenu not really used  sinde we use nvimcmp, which draws from NormalFloat
  hi('Pmenu',               { bg = mirLightGray1, fg = mirBlack,                  ctermfg = 'Black', ctermbg = 'LightGrey' })
  hi('PmenuSel',            { bg = mirLightGreen,                                 ctermfg = 'Black', ctermbg = 'LightGrey' })
  hi('NormalFloat',         { bg = mirWhite, fg = mirBlack,                         ctermfg = 'Black', ctermbg = 'LightGrey' })
  -- hi('PmenuThumb',       { bg = 'Black',                                ctermbg = 'Black' })
  -- hi('Question',         { fg = 'SeaGreen', bold = true,                ctermfg = 'DarkGreen' })
  -- hi('Search',           { bg = 'Yellow',                               ctermbg = 'Yellow' })
  -- hi('SignColumn',       { fg = 'DarkBlue', bg = 'Grey',                ctermfg = 'DarkBlue', ctermbg = 'Grey' })
  -- hi('SpecialKey',       { fg = 'Blue',                                 ctermfg = 'DarkBlue' })
  -- hi('SpellBad',         { sp = 'Red', undercurl = true,                ctermbg = 'LightRed' })
  -- hi('SpellCap',         { sp = 'Blue', undercurl = true,               ctermbg = 'LightBlue' })
  -- hi('SpellLocal',       { sp = 'DarkCyan', undercurl = true,           ctermbg = 'Cyan' })
  -- hi('SpellRare',        { sp = 'Magenta', undercurl = true,            ctermbg = 'LightMagenta' })
  hi('StatusLine',          { fg = mirBlack, bg = mirLightGreen, bold = true, ctermfg = 'White', ctermbg = 'DarkGreen', cterm = { bold = true } })
  hi('StatusLineNC',        { fg = mirLightGray4, bg = mirLightGray1, bold = false, ctermfg = 'White', ctermbg = 'DarkGreen', cterm = { bold = true } })
  hi('StatusLineTerm',      { fg = mirBlack, bg = mirLightGreen, bold = true, ctermfg = 'White', ctermbg = 'DarkGreen', cterm = { bold = true } })
  hi('StatusLineTermNC',    { fg = mirLightGray4, bg = mirLightGray1,              ctermfg = 'White', ctermbg = 'DarkGreen' })
  -- hi('TabLine',          { bg = 'LightGrey', underline = true,          ctermfg = 'Black', ctermbg = 'LightGrey', cterm = { underline = true } })
  -- hi('Title',            { fg = 'Magenta', bold = true,                 ctermfg = 'DarkMagenta' })
  hi('Visual',              { bg = mirLightGray2,              ctermfg = 'Black', ctermbg = 'Grey' })
  -- hi('Visual',           { reverse = true })
  -- hi('WarningMsg',       { fg = 'Red',                                  ctermfg = 'DarkRed' })
  hi('Comment',             { fg = mirLightGray4,                                 ctermfg = 'LightGrey' })
  hi('Constant',            { fg = mirDarkOrange,                              ctermfg = 'DarkRed' })
  hi('Special',             { fg = mirBlack, bold = true,                              ctermfg = 'DarkMagenta' })
  hi('Identifier',          { fg = mirDarkRed,                             ctermfg = 'DarkCyan' })
  hi('Function',            { fg = mirDarkCyan,                             ctermfg = 'DarkGreen' })
  hi('Statement',           { fg = mirBlack,                   ctermfg = 'Brown' })
  hi('Macro',               { fg = mirDarkCyan, bold=true,                              ctermfg = 'DarkMagenta' })
  hi('PreProc',             { fg = mirDarkGray4, bold = true,                              ctermfg = 'DarkMagenta' })
  hi('Type',                { fg = mirBlack, bold = true,                ctermfg = 'Black' })
  hi('Delimiter',           { fg = mirBlack, bold = false,                ctermfg = 'Black' })
  hi('Underlined',          { fg = mirLinkBlue, underline = true,          ctermfg = 'DarkMagenta', cterm = { underline = true } })
  -- hi('Ignore',           {                                              ctermfg = 'White' })
  -- hi('Added',            { fg = 'SeaGreen',                             ctermfg = 'DarkGreen' })
  -- hi('Changed',          { fg = 'DodgerBlue',                           ctermfg = 'Blue' })
  -- hi('Removed',          { fg = 'Red',                                  ctermfg = 'Red' })
else
  hi('Normal',              {bg = mirBlack})
  hi('VertSplit',           { fg = mirDarkGray4 })
  hi('ColorColumn',         { bg = mirDarkGray2,                               ctermbg = 'DarkGrey' })
  hi('MatchParen',          { bg = mirDarkGray4,                                 ctermbg = 'Gray' })
  -- hi('Pmenu',            { bg = 'NvimDarkGray2',                               ctermfg = 'Black', ctermbg = 'Magenta' })
  hi('Pmenu',               { bg = mirDarkGray1, fg = mirWhite,                        ctermfg = 'LightGray', ctermbg = 'Black' })
  hi('PmenuSel',            { bg = mirDarkGreen,                              ctermfg = 'DarkGrey', ctermbg = 'Black' })
  hi('NormalFloat',         { bg = mirBlack, fg = mirWhite,                         ctermfg = 'LightGrey', ctermbg = 'Black' })
  hi('StatusLine',          { fg = mirWhite, bg = mirDarkGreen, bold = true, ctermfg = 'White', ctermbg = 'DarkGreen', cterm = { bold = true } })
  hi('StatusLineNC',        { fg = mirDarkGray4, bg = mirDarkGray1, bold = false, ctermfg = 'White', ctermbg = 'DarkGreen', cterm = { bold = true } })
  hi('StatusLineTerm',      { fg = mirWhite, bg = mirDarkGreen, bold = true, ctermfg = 'White', ctermbg = 'DarkGreen', cterm = { bold = true } })
  hi('StatusLineTermNC',    { fg = mirDarkGray4, bg = mirDarkGray1,              ctermfg = 'White', ctermbg = 'DarkGreen' })
  hi('Visual',              { bg = mirDarkGray3,             ctermfg = 'Black', ctermbg = 'Grey' })
  hi('Comment',             { fg = mirDarkGray4,                               ctermfg = 'DarkGrey' })
  hi('Constant',            { fg = mirLightYellow,                               ctermfg = 'Magenta' })
  hi('Special',             { fg = mirWhite, bold = true,                              ctermfg = 'DarkMagenta' })
  hi('Identifier',          { fg = mirLightRed,                               ctermfg = 'Cyan', cterm = { bold = true } })
  hi('Function',            { fg = mirLightCyan,                               ctermfg = 'Cyan', cterm = { bold = true } })
  hi('Statement',           { fg = mirWhite,                   ctermfg = 'Brown' })
  hi('Macro',               { fg = mirLightMagenta,                               ctermfg = 'LightBlue' })
  hi('PreProc',             { fg = mirLightGray4, bold = true,                              ctermfg = 'DarkMagenta' })
  hi('Type',                { fg = mirWhite, bold = true,                ctermfg = 'Black' })
  hi('Delimiter',           { fg = mirWhite, bold = false,                ctermfg = 'Black' })
  hi('Underlined',          { fg = mirLinkBlue, underline = true,          ctermfg = 'DarkMagenta', cterm = { underline = true } })
end
--stylua: ignore end
