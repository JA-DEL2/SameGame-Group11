Class {
	#name : 'SGGameTest',
	#superclass : 'TestCase',
	#category : 'Myg-SameGame-Model-Tests',
	#package : 'Myg-SameGame',
	#tag : 'Model-Tests'
}

{ #category : 'tests' }
SGGameTest >> testKilledTilesAreAccumulated [ [

    | game board |
    game := SGGame new.
    board := SGBoard new game: game.

    board hitList: { SGBox new. SGBox new }.
    board updateKilledTiles.

    board hitList: { SGBox new }.
    board updateKilledTiles.

    self assert: game killedTiles equals: 3.
]

]

{ #category : 'tests' }
SGGameTest >> testSelectionCountIsUpdated [ [

    | game board |
    game := SGGame new.
    board := SGBoard new game: game.

    "Simule une hitList de 3 tuiles"
    board hitList: { SGBox new. SGBox new. SGBox new }.

    board updateSelectionCount.

    self assert: game lastSelectionCount equals: 3.
]

]
