{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    git-lfs
  ];
  home.file.".ssh/allowed_signers".text = "* ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILRsgh/gBYgSmvb0wDKSflWna2J+nATtgfbBj4Lv95K9";
  programs.git = {
    enable = true;
    delta.enable = true;
    userName = "Max de Hoyos";
    userEmail = "max.dehoyos@gmail.com";
    aliases = {
      co = "checkout";
      count = "shortlong -sn";
      g = "grep --break --heading --line-number";
      gi = "grep --break --heading --line-number -i";
      changed = ''show --pretty="format:" --name-only'';
      fm = "fetch-merge";
      please = "push --force-with-lease";
      commit = "commit -s"; # -s for signoff, make sure you can sign!
      commend = "commit -s --amend --no-edit";
      lt = "log --tags --decorate --simplify-by-decoration --oneline";
      unshallow = "fetch --prune --tags --unshallow";
    };
    extraConfig = {
      commit.gpgSign = true;
      gpg.format = "ssh";
      gpg.allowedSignersFile = "~/.ssh/allowed_signers";
      user.signingKey = "~/.ssh/id_ed25519.pub";
      lfs = { enable = true; };
      core = {
        editor = "nvim";
        compression = -1;
        autocrlf = "input";
        whitespace = "trailing-space,space-before-tab";
        precomposeunicode = true;
      };
      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        ui = true;
      };
      advice = { addEmptyPathspec = false; };
      apply = { whitespace = "nowarn"; };
      help = { autocorrect = -1; };
      grep = {
        extendRegexp = true;
        default = "simple";
      };
      push = {
        autoSetupRemote = true;
        default = "simple";
      };
      submodule = { fetchJobs = 4; };
      log = { showSignature = false; };
      format = { signOff = true; };
      rerere = { enabled = true; };
      pull = { ff = "only"; };
      init = { defaultBranch = "main"; };
    };
    ignores = lib.splitString "\n" (builtins.readFile ./gitignore_global);
  };
}
