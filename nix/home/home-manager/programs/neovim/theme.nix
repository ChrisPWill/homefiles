{theme}: {
  themeConfig = ''
    " Color configuration
    highlight Normal guibg=${theme.background} guifg=${theme.foreground}
    highlight LineNr guifg=${theme.light.black}
    highlight NonText guifg=${theme.light.black}
    highlight CursorLine guibg=${theme.normal.black}
    highlight CursorLineNr guifg=${theme.light.blue} gui=bold
    highlight MatchParen guibg=${theme.normal.black} guifg=${theme.light.blue} gui=bold
    highlight Pmenu guibg=${theme.normal.black} guifg=${theme.light.white}
    highlight PmenuSel guibg=${theme.light.blue} guifg=${theme.normal.white} gui=bold
  '';
}
