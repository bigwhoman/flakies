{
 description = "My First Flakie :D"; # Random description

 inputs = {
   # Nixpkgs
   nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

   # Home manager
   home-manager.url = "github:nix-community/home-manager";
   home-manager.inputs.nixpkgs.follows = "nixpkgs";

   # Hardware
   hardware.url = "github:nixos/nixos-hardware";
 };

 outputs = { self, nixpkgs, home-manager, ... }@inputs: {
   # NixOS configuration entrypoint
   # Available through 'nixos-rebuild --flake .#your-hostname'

   nixosConfigurations = {
    bigwhoman = nixpkgs.lib.nixosSystem {
       specialArgs = { inherit inputs; }; # Pass flake inputs to our config
       # > Our main nixos configuration file <
       modules = [ 
         ./nixos/configuration.nix
       ];
     };
   };

   # home-manager configuration entrypoint
   # Available through 'home-manager --flake .#your-username@your-hostname'
   homeConfigurations = {
     # FIXME replace with your username@hostname
     "bigwhoman@bigwhoman" = home-manager.lib.homeManagerConfiguration {
       pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
       extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
       # > Our main home-manager configuration file <
       modules = [ 
           ./home-manager/home.nix 
           ];
     };
   };
 };
}