flake-update:
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
      darwin-rebuild switch --flake ~/nixos-config;

    linux)
      sudo nixos-rebuild switch --flake ~/nixos-config;

    *)
      echo "Unsupported operating system"
      exit 1;;
  esac

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