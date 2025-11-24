Class {
	#name : 'SGGameTest',
	#superclass : 'TestCase',
	#category : 'Myg-SameGame-Model-Tests',
	#package : 'Myg-SameGame',
	#tag : 'Model-Tests'
}

{ #category : 'tests' }
SGGameTest >> testKilledTilesAreAccumulated [
	| game board |
	game := SGGame new.
	board := SGBoard new game: game.
   "2 tiles/boxes deleted"
	board hitList addAll: { SGBox new. SGBox new }.
	board updateKilledTiles.
	"1 tile/box deleted"
	board hitList add: SGBox new.
	board updateKilledTiles.

	self assert: game killedTiles equals: 3.
]
