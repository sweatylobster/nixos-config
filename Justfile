update:
  #!/usr/bin/env bash
  set -euxo pipefail
  nix flake update
  if git diff --exit-code flake.lock > /dev/null 2>&1; then
    echo "no changes to flake.lock"
  else
    echo "committing flake.lock"
    git add flake.lock
    git commit -m "nix: update flake.lock"
  fi

rebuild:
  #!/usr/bin/env bash
  set -euxo pipefail
  case "{{ os() }}" in
    macos)
      sudo darwin-rebuild switch --flake ~/nixos-config --show-trace;;

    linux)
      sudo nixos-rebuild switch --flake ~/nixos-config --show-trace;;

    *)
      echo "Unsupported operating system"
      exit 1;;
  esac

artifacts:
  #!/usr/bin/env bash
  set -euo pipefail
  # Get the user's hm-backup extension
  ext=$(rg 'backupFileExtension = "(.+)";' -o -r '$1' | uniq)
  if test $(echo $ext | wc -l) -eq 1; then
    fd --unrestricted --type file --extension hm-backup --search-path $HOME --execute rm
    echo "Removed instances of $ext in $HOME. Try rebuilding now."
  else
    echo 'More than one result found, try removing artifacts manually.' && exit 1
  fi

brew:
  #!/usr/bin/env bash
  set -euxo pipefail
  case "{{ os() }}" in
    macos)
      brew update && brew upgrade;;
    *)
      echo "Unsupported operating system"
      exit 1;;
  esac

fix-shell-files:
  #!/usr/bin/env bash
  set -euxo pipefail

  sudo mv /etc/zshenv /etc/zshenv.before-nix-darwin
  sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin
  sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin
