function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# better-vi-mode creates so many problems
function zvm_after_init() {
  for mode in viins vicmd visual; do
    for o in files branches tags remotes hashes stashes lreflogs each_ref; do
      eval "zvm_bindkey ${mode} '^g^${o[1]}' fzf-git-$o-widget"
      eval "zvm_bindkey ${mode} '^g${o[1]}' fzf-git-$o-widget"
    done
  done
  eval "source <(fzf --zsh)"
  eval "source ${}"
}

# Dispatchers for common extensions
alias -s .pdf sioyek

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line

# bindkey '^v' edit-command-line
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward
# bindkey '^e' end-of-line
# bindkey '^a' beginning-of-line
# bindkey '^f' forward-char
# bindkey '^b' backward-char
# bindkey ';5C' forward-word
# bindkey ';5D' backward-word
