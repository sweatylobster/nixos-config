function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
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
