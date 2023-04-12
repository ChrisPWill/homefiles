{
  enable = true;

  history = {
    size = 10000;
    save = 10000;
    path = "~/.zshinfo";
    share = true;

    ignoreSpace = true;
    ignoreDups = true;
    extended = true;
    expireDuplicatesFirst = true;
  };

  shellAliases = {
    home-update = "home-manager switch";

    # Disable autocorrection for these
    ln = "nocorrect ln";
    mv = "nocorrect mv";
    mkdir = "nocorrect mkdir";
    sudo = "nocorrect sudo";

    # Directory navigation
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "-- -" = "cd -";
    "-- --" = "cd -2";
    "-- ---" = "cd -3";
  };

  initExtraFirst = ''
#
# General Settings {{{
# -----------------------------------------------------------------------------

setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt multios
setopt cdablevarS
setopt autocd
setopt extendedglob
setopt interactivecomments
setopt nobeep
setopt nocheckjobs
setopt correct
  '';

  initExtraBeforeCompInit = ''
CACHEDIR="$HOME/.cache/zsh-cache"
fasd_cache="$HOME/.cache/.fasd-init-cache"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
fpath+=~/.zfunc
  '';
  completionInit = ''
autoload -U compinit && compinit -d $CACHEDIR/zcompdump 2>/dev/null

# Use cache to speed completion up and set cache folder path.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $CACHEDIR

# Auto-insert first suggestion.
setopt menu_complete

# If the <tab> key is pressed with multiple possible options, print the
# options. If the options are printed, begin cycling through them.
zstyle ':completion:*' menu select

# Set format for warnings.
zstyle ':completion:*:warnings' format 'Sorry, no matches for: %d%b'

# Use colors when outputting file names for completion options.
zstyle ':completion:*' list-colors ''\''

# Do not prompt to cd into current directory.
# For example, cd ../<tab> should not prompt current directory.
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Completion for kill.
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,cputime,cmd'

# Show completion for hidden files also.
zstyle ':completion:*' file-patterns '*(D)'

# Red dots!
expand-or-complete-with-dots() {
    echo -n "\e[31m......\e[0m"
    zle expand-or-complete
    zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots
'';

  initExtra = ''
# }}}
# The Vim setup {{{
# -----------------------------------------------------------------------------

bindkey -v

# Disable flow control. Specifically, ensure that ctrl-s does not stop
# terminal flow so that it can be used in other programs (such as Vim).
setopt noflowcontrol
stty -ixon

# Disable use of ^D.
stty eof undef

# 1 sec <Esc> time delay? zsh pls.
# Set to 10ms for key sequences. (Note "bindkey -rp '^['" removes the
# availability of any '^[...' mappings, so use this instead.)
KEYTIMEOUT=1

###############################################################################
# Insert mode
###############################################################################

bindkey -M viins "^?" backward-delete-char      # i_Backspace
bindkey -M viins '^[[3~' delete-char            # i_Delete
bindkey -M viins '^[[Z' reverse-menu-complete   # i_SHIFT-Tab

# Non-Vim default mappings I use everywhere.
bindkey -M viins "^N" vim-down-line-or-history  # i_CTRL-N
bindkey -M viins "^E" vim-up-line-or-history    # i_CTRL-E
bindkey -M viins '^V' append-x-selection        # i_CTRL-V

# Vim defaults
bindkey -M viins "^A" beginning-of-line         # i_CTRL-A
bindkey -M viins "^E" end-of-line               # i_CTRL-E
bindkey -M viins "^K" down-line-or-history      # i_CTRL-N
bindkey -M viins "^P" up-line-or-history        # i_CTRL-P
bindkey -M viins "^H" backward-delete-char      # i_CTRL-H
bindkey -M viins "^B" _history-complete-newer   # i_CTRL-B
bindkey -M viins "^F" _history-complete-older   # i_CTRL-F
bindkey -M viins "^U" backward-kill-line        # i_CTRL-U
bindkey -M viins "^W" backward-kill-word        # i_CTRL-W
bindkey -M viins "^[[7~" vi-beginning-of-line   # i_Home
bindkey -M viins "^[[8~" vi-end-of-line         # i_End

# Edit current line in veritable Vim.
bindkey -M viins "^H" edit-command-line         # i_CTRL-I

# set up for insert mode too
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward

###############################################################################
# Normal mode
###############################################################################

bindkey -M vicmd "ca" change-around             # ca
bindkey -M vicmd "ci" change-in                 # ci
bindkey -M vicmd "cc" vi-change-whole-line      # cc
bindkey -M vicmd "da" delete-around             # da
bindkey -M vicmd "di" delete-in                 # di
bindkey -M vicmd "dd" kill-whole-line           # dd
bindkey -M vicmd "gg" beginning-of-buffer-or-history # gg
bindkey -M vicmd "G" end-of-buffer-or-history   # G
bindkey -M vicmd "^R" redo                      # CTRL-R

# Non-Vim default mappings I use everywhere.
bindkey -M vicmd 'p' append-x-selection         # p
bindkey -M vicmd 'P' prepend-x-selection        # P
bindkey -M vicmd 'y' yank-x-selection           # y
#bindkey -M vicmd 'Y' yank-to-end-x-selection    # Y
bindkey -M vicmd "z" vi-substitute              # z

# Vim defaults I don't use but I may as well keep.
bindkey -M vicmd "^H" vi-add-eol                # CTRL-E
bindkey -M vicmd "g~" vi-oper-swap-case         # g~
bindkey -M vicmd "ga" what-cursor-position      # ga

# Search backwards and forwards with a pattern
bindkey -M vicmd '/' history-incremental-pattern-search-backward
bindkey -M vicmd '?' history-incremental-pattern-search-forward

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  '';

  profileExtra = ''
# Defaults
EDITOR='nvim'

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# fzf
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
export FZF_ALT_V_COMMAND="fd -t d ."

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
VISUAL='nvim'
  '';
}
