{
  description = "PMatrix – Matrix digital rain terminal application";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        lib = pkgs.lib;
        python = pkgs.python311;
        py = python.pkgs;

        appDescription = "A Matrix digital rain effect terminal application";

        pmatrix = py.buildPythonApplication {
          pname = "pmatrix";
          version = "1.0.2";
          format = "pyproject";
          src = ./.;

          nativeBuildInputs = [
            py.hatchling
          ];

          pythonImportsCheck = [
            "pmatrix"
          ];

          doCheck = false;

          meta = with lib; {
            description = appDescription;
            homepage = "https://github.com/4ster-light/pmatrix";
            license = licenses.mit;
            mainProgram = "pmatrix";
          };
        };

        containerImage = pkgs.dockerTools.buildLayeredImage {
          name = "pmatrix";
          tag = "latest";
          contents = [ pmatrix ];
          config = {
            Entrypoint = [ "${pmatrix}/bin/pmatrix" ];
          };
        };

      in
      {
        packages = {
          default = pmatrix;
          pmatrix = pmatrix;
          container = containerImage;
        };

        apps.default = {
          type = "app";
          program = "${pmatrix}/bin/pmatrix";
          meta.description = appDescription;
        };

        checks = {
          package = pmatrix;
        };

        devShells.default = pkgs.mkShell {
          packages = [
            python
            pkgs.uv
            pkgs.ruff
            pkgs.ty
            pkgs.git
          ];

          UV_PROJECT_ENVIRONMENT = ".venv";

          shellHook = ''
            if [ ! -d .venv ]; then
            	echo "→ Creating project venv..."
            	uv venv
            fi

            echo ""
            echo "PMatrix Nix dev shell — $(python --version)"
            echo ""
          '';
        };
      }
    );
}
