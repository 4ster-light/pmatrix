{
	description = "pmatrix – Matrix digital rain terminal application";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils }:
		flake-utils.lib.eachDefaultSystem (system:
			let
				pkgs = import nixpkgs { inherit system; };
				lib = pkgs.lib;
				python = pkgs.python314;
				py = python.pkgs;

				pmatrix = py.buildPythonApplication rec {
					pname = "pmatrix";
					version = "1.0.1";
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
						description = "A Matrix digital rain effect terminal application, written in Python";
						homepage = "https://github.com/4ster-light/pmatrix";
						license = licenses.mit;
						mainProgram = "pmatrix";
					};
				};

			in {
				packages = {
					default = pmatrix;
					pmatrix = pmatrix;
				};

				apps.default = flake-utils.lib.mkApp {
					drv = pmatrix;
				};

				checks = {
					package = pmatrix;

					smoke = pkgs.runCommand "pmatrix-smoke-test" {
						buildInputs = [ pmatrix ];
					} ''
						pmatrix --help > "$out"
					'';
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
						echo "See all commands:  just help"
						echo ""
					'';
				};
			});
}