{
  description = "nix system configurations";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    # package repos
    stable.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv/latest";

    # system management
    nixos-hardware.url = "github:nixos/nixos-hardware";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # shell stuff
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = {
    self,
    darwin,
    devenv,
    flake-utils,
    home-manager,
    ...
  } @ inputs: let
    inherit (flake-utils.lib) eachSystemMap;

    isDarwin = system: (builtins.elem system inputs.nixpkgs.lib.platforms.darwin);
    homePrefix = system:
      if isDarwin system
      then "/Users"
      else "/home";
    defaultSystems = [
      "aarch64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
      "x86_64-linux"
    ];

    # generate a base darwin configuration with the
    # specified hostname, overlays, and any extraModules applied
    mkDarwinConfig = {
      system ? "aarch64-darwin",
      nixpkgs ? inputs.nixpkgs,
      baseModules ? [
        home-manager.darwinModule
        ./modules/darwin
      ],
      extraModules ? [],
    }:
      inputs.darwin.lib.darwinSystem {
        inherit system;
        modules = baseModules ++ extraModules;
        specialArgs = {inherit self inputs nixpkgs;};
      };

    # generate a base nixos configuration with the
    # specified overlays, hardware modules, and any extraModules applied
    mkNixosConfig = {
      system ? "x86_64-linux",
      nixpkgs ? inputs.nixos-unstable,
      hardwareModules,
      baseModules ? [
        home-manager.nixosModule
        ./modules/nixos
      ],
      extraModules ? [],
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = baseModules ++ hardwareModules ++ extraModules;
        specialArgs = {inherit self inputs nixpkgs;};
      };

    # generate a home-manager configuration usable on any unix system
    # with overlays and any extraModules applied
    mkHomeConfig = {
      username,
      system ? "x86_64-linux",
      nixpkgs ? inputs.nixpkgs,
      baseModules ? [
        ./modules/home-manager
        {
          home = {
            inherit username;
            homeDirectory = "${homePrefix system}/${username}";
            sessionVariables = {
              NIX_PATH = "nixpkgs=${nixpkgs}:stable=${inputs.stable}\${NIX_PATH:+:}$NIX_PATH";
            };
          };
        }
      ],
      extraModules ? [],
    }:
      inputs.home-manager.lib.homeManagerConfiguration rec {
        pkgs = import nixpkgs {
          inherit system;
          overlays = builtins.attrValues self.overlays;
        };
        extraSpecialArgs = {inherit self inputs nixpkgs;};
        modules = baseModules ++ extraModules;
      };

    mkChecks = {
      arch,
      os,
      username ? "eric",
    }: {
      "${arch}-${os}" = {
        "${username}_${os}" =
          (
            if os == "darwin"
            then self.darwinConfigurations
            else self.nixosConfigurations
          )
          ."${username}@${arch}-${os}"
          .config
          .system
          .build
          .toplevel;
        "${username}_home" =
          self.homeConfigurations."${username}@${arch}-${os}".activationPackage;
        devShell = self.devShells."${arch}-${os}".default;
      };
    };
  in {
    checks =
      {}
      // (mkChecks {
        arch = "aarch64";
        os = "darwin";
      })
      // (mkChecks {
        arch = "x86_64";
        os = "darwin";
      })
      // (mkChecks {
        arch = "aarch64";
        os = "linux";
      })
      // (mkChecks {
        arch = "x86_64";
        os = "linux";
      });

    darwinConfigurations = {
      "hinata" = mkDarwinConfig {
        system = "aarch64-darwin";
        extraModules = [
          ./hosts/darwin/hinata.nix
          ./profiles/personal.nix
          ./modules/darwin/apps.nix
        ];
      };
      "hinata-vm" = mkDarwinConfig {
        system = "aarch64-darwin";
        extraModules = [
          ./hosts/darwin/hinata-vm.nix
          ./profiles/personal.nix
          ./modules/darwin/apps.nix
        ];
      };
      "air11" = mkDarwinConfig {
        system = "x86_64-darwin";
        extraModules = [./profiles/personal.nix ./modules/darwin/apps.nix];
      };
      "eir" = mkDarwinConfig {
        system = "aarch64-darwin";
        nixpkgs = inputs.nixos-unstable;
        extraModules = [
          ./hosts/darwin/eir.nix
          ./profiles/work.nix
          ./modules/darwin/apps.nix
        ];
      };
    };

    nixosConfigurations = {
      "lnv01" = mkNixosConfig {
        system = "x86_64-linux";
        hardwareModules = [
          ./modules/hardware/lnv01.nix
        ];
        extraModules = [
          ./hosts/nixos/lnv01.nix
          ./profiles/personal.nix
        ];
      };
      "eleven" = mkNixosConfig {
        system = "x86_64-linux";
        hardwareModules = [
          ./modules/hardware/eleven.nix
        ];
        extraModules = [
          ./hosts/nixos/eleven.nix
          ./profiles/personal.nix
        ];
      };
    };

    homeConfigurations = {
      "lnv01" = mkHomeConfig {
        username = "eric";
        system = "x86_64-linux";
        extraModules = [
          ./profiles/home-manager/personal.nix
          ./modules/home-manager/nixos-only.nix
        ];
      };
      "air11" = mkHomeConfig {
        username = "eric";
        system = "x86_64-darwin";
        extraModules = [./profiles/home-manager/personal.nix];
      };
      "hinata" = mkHomeConfig {
        username = "eric";
        system = "aarch64-darwin";
        extraModules = [./profiles/home-manager/personal.nix];
      };
      "hinata-vm" = mkHomeConfig {
        username = "eric";
        system = "aarch64-darwin";
        extraModules = [./profiles/home-manager/personal.nix];
      };
      "eir" = mkHomeConfig {
        username = "eripa";
        system = "aarch64-darwin";
        extraModules = [./profiles/home-manager/personal.nix];
      };
    };

    devShells = eachSystemMap defaultSystems (system: let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = builtins.attrValues self.overlays;
      };
    in {
      default = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          (import ./devenv.nix)
        ];
      };
    });

    packages = eachSystemMap defaultSystems (system: let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = builtins.attrValues self.overlays;
      };
    in rec {
      pyEnv =
        pkgs.python3.withPackages
        (ps: with ps; [black typer colorama shellingham]);
      sysdo = pkgs.writeScriptBin "sysdo" ''
        #! ${pyEnv}/bin/python3
        ${builtins.readFile ./bin/do.py}
      '';
      cb = pkgs.writeShellScriptBin "cb" ''
        #! ${pkgs.lib.getExe pkgs.bash}
        # universal clipboard, stephen@niedzielski.com

        shopt -s expand_aliases

        # ------------------------------------------------------------------------------
        # os utils

        case "$OSTYPE$(uname)" in
          [lL]inux*) TUX_OS=1 ;;
         [dD]arwin*) MAC_OS=1 ;;
          [cC]ygwin) WIN_OS=1 ;;
                  *) echo "unknown os=\"$OSTYPE$(uname)\"" >&2 ;;
        esac

        is_tux() { [ ''${TUX_OS-0} -ne 0 ]; }
        is_mac() { [ ''${MAC_OS-0} -ne 0 ]; }
        is_win() { [ ''${WIN_OS-0} -ne 0 ]; }

        # ------------------------------------------------------------------------------
        # copy and paste

        if is_mac; then
          alias cbcopy=pbcopy
          alias cbpaste=pbpaste
        elif is_win; then
          alias cbcopy=putclip
          alias cbpaste=getclip
        else
          alias cbcopy='${pkgs.xclip} -sel c'
          alias cbpaste='${pkgs.xclip} -sel c -o'
        fi

        # ------------------------------------------------------------------------------
        cb() {
          if [ ! -t 0 ] && [ $# -eq 0 ]; then
            # no stdin and no call for --help, blow away the current clipboard and copy
            cbcopy
          else
            cbpaste ''${@:+"$@"}
          fi
        }

        # ------------------------------------------------------------------------------
        if ! return 2>/dev/null; then
          cb ''${@:+"$@"}
        fi
      '';
    });

    apps = eachSystemMap defaultSystems (system: rec {
      sysdo = {
        type = "app";
        program = "${self.packages.${system}.sysdo}/bin/sysdo";
      };
      cb = {
        type = "app";
        program = "${self.packages.${system}.cb}/bin/cb";
      };
      default = sysdo;
    });

    overlays = {
      channels = final: prev: {
        # expose other channels via overlays
        stable = import inputs.stable {system = prev.system;};
      };
      extraPackages = final: prev: {
        sysdo = self.packages.${prev.system}.sysdo;
        pyEnv = self.packages.${prev.system}.pyEnv;
        cb = self.packages.${prev.system}.cb;
        devenv = self.packages.${prev.system}.devenv;
      };
    };
  };
}
