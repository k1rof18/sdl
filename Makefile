r:
	cabal v2-build --jobs=4 && cabal run

t:
	cabal clean & cabal v2-build --jobs=4 & cabal test

te:
	cabal test
