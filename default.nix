{ nixpkgs ? import <nixpkgs-unstable> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  haskellPackages = if compiler == "default"
                       then pkgs.haskell.packages.ghc844
                       else pkgs.haskell.packages.${compiler};

  dontCheck = pkgs.haskell.lib.dontCheck;
  doJailbreak = pkgs.haskell.lib.doJailbreak;

  sources = {
    base-compat = pkgs.fetchFromGitHub {
      owner  = "haskell-compat";
      repo   = "base-compat";
      rev    = "0.10.4";
      sha256 = "1lv2s5bpmy7dfp51gl2xgjfc4a94if6a7rzcj5wzwc6fkkkl1iap";
    };
    #cabal-plan = pkgs.fetchFromGitHub {
    #  owner = "haskell-hvr";
    #  repo = "cabal-plan";
    #  rev    = "67d6b9b3f15fde3f3fc38d4bccc589d2e1a5420c";
    #  sha256 = "1rl4xaln0akcx8n7vai6ajyp16v5bg7x23f1g0ly7cvi5mvi945w";
    #};
  };

  modifiedHaskellPackages = haskellPackages.override {
    overrides = self: super: {
      aeson = dontCheck (self.callHackage "aeson" "1.4.1.0" {});
      aeson-compat = dontCheck (self.callHackage "aeson-compat" "0.3.8" {});
      ansi-terminal = dontCheck (self.callHackage "ansi-terminal" "0.8.0.2" {});
      attoparsec-iso8601 = doJailbreak (dontCheck (self.callHackage "attoparsec-iso8601" "1.0.0.0" {}));
      base-compat = dontCheck (self.callCabal2nix "base-compat" "${sources.base-compat}/base-compat" {});
      #cabal-plan = doJailbreak (dontCheck super.cabal-plan);
      #cabal-plan = dontCheck (self.callCabal2nix "cabal-plan" sources.cabal-plan {});
      cabal-plan = dontCheck (self.callHackage "cabal-plan" "0.4.0.0" {});
      cryptohash-sha512 = dontCheck (self.callHackage "cryptohash-sha512" "0.11.100.1" {});
      lattices = dontCheck (self.callHackage "lattices" "1.7.1" {});
      tasty = dontCheck (self.callHackage "tasty" "1.1" {});
      tasty-quickcheck = dontCheck (self.callHackage "tasty-quickcheck" "0.10" {});
      tdigest = dontCheck (self.callHackage "tdigest" "0.2" {});
    };
  };

  trustee = modifiedHaskellPackages.callPackage ./trustee.nix {};

in
  trustee
