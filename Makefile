r:
	cabal build && cabal run

t:
	cabal clean & cabal build & cabal test

te:
	cabal test
