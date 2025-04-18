
let
  # Import the Nixpkgs repository
  # You can change the URL to point to a specific commit or branch
  pkgs = import (fetchTarball("https://github.com/NixOS/nixpkgs/archive/refs/tags/24.05.tar.gz")) {};

in pkgs.mkShell {
  buildInputs = [ pkgs.zola pkgs.nodejs ];
}

