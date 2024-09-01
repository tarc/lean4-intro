{pkgs, ...}: {
  packages = [pkgs.elan];

  pre-commit = {
    hooks = {
      shellcheck.enable = true;
      alejandra.enable = true;
      shfmt.enable = false;
      deadnix = {
        enable = true;
        settings = {
          edit = true;
          noLambdaArg = true;
        };
      };
    };
  };
}
