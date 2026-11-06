{
 description = "My First Flakie :D"; # Random description

 inputs = {
   # Nixpkgs
   nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
   
   vscode-server.url = "github:nix-community/nixos-vscode-server";

   # Home manager
   home-manager.url = "github:nix-community/home-manager";
   home-manager.inputs.nixpkgs.follows = "nixpkgs";

   # Hardware
   hardware.url = "github:nixos/nixos-hardware";
   
   # GUI
   hyprland.url = "github:hyprwm/Hyprland";
 };

 outputs = { self, nixpkgs, home-manager, hyprland, vscode-server, ... }@inputs: {
   # NixOS configuration entrypoint
   # Available through 'nixos-rebuild --flake .#your-hostname'

   # One entry per machine; each machine's folder lives in ./hosts/<name>.
   nixosConfigurations = {
     bigwhoman = nixpkgs.lib.nixosSystem {
       specialArgs = { inherit inputs; }; # Pass flake inputs to our config
       modules = [
         ./hosts/bigwhoman
         hyprland.nixosModules.default
         vscode-server.nixosModules.default
       ];
     };
   };

   # home-manager configuration entrypoint
   # Available through 'home-manager --flake .#your-username@your-hostname'
   homeConfigurations = {
     "bigwhoman@nixos" = home-manager.lib.homeManagerConfiguration {
       pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
       extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
       modules = [
         ./home-manager/home.nix
         ./hosts/bigwhoman/home.nix
       ];
     };
   };
 };
}
