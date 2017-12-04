{}:
with import <nixpkgs> {}; rec {
  words = builtins.fetchurl "http://downloads.sourceforge.net/wordlist/scowl-2017.08.24.tar.gz";

  testCpp = clangStdenv.mkDerivation
  {
    src = ./.;
    outputs = ["out"];
    name = "acronyms_cpp";

    buildInputs = [(haskellPackages.ghc.withPackages(pkgs:[pkgs.unordered-containers pkgs.hashtables])) python3 ];

    buildPhase = ''
      mkdir -p $out
      c++ -std=c++14 -Wall -O3 acronyms.cpp -o acronyms_cpp

      ghc -O2 -Wall acronyms.hs -o acronyms_hs
      ghc -O2 -Wall acronym_mutable.hs -o acronym_mutable_hs
      tar xf ${words}
    '';
    installPhase = ''
      cp acronyms_cpp $out/
      cp acronyms_hs $out/
      cp acronym_mutable_hs $out/
      cp acronyms.py $out/acronyms_python

      cp runBench.sh $out/

      chmod +x $out/runBench.sh
      chmod +x $out/acronyms_python
      cat scowl-2017.08.24/final/* > $out/words.txt
    '';
  };
}
