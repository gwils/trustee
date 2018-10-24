{ mkDerivation, aeson, aeson-compat, ansi-terminal, async, base
, base16-bytestring, binary, bytestring, Cabal, cabal-plan, clock
, concurrent-output, containers, cryptohash-sha512, deepseq
, directory, exceptions, filepath, Glob, lattices
, optparse-applicative, path, path-io, process, stdenv, stm, tar
, tdigest, text, time, transformers, unix
}:
mkDerivation {
  pname = "trustee";
  version = "0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson aeson-compat ansi-terminal async base base16-bytestring
    binary bytestring Cabal cabal-plan clock concurrent-output
    containers cryptohash-sha512 deepseq directory exceptions filepath
    Glob lattices optparse-applicative path path-io process stm tar
    tdigest text time transformers unix
  ];
  executableHaskellDepends = [ base ];
  homepage = "https://github.com/phadej/trustee";
  description = "A Hackage Trustees tool";
  license = stdenv.lib.licenses.gpl3;
}
