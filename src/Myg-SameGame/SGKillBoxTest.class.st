Class {
	#name : 'SGKillBoxTest',
	#superclass : 'TestCase',
	#category : 'Myg-SameGame',
	#package : 'Myg-SameGame'
}

{ #category : 'tests' }
SGKillBoxTest >> testKillColumnRemovesAllBoxesInColumn [
	|board|
	 "Test que killColumn supprime toute une colonne"
    
    board := SGBoard new game: SGGame new.
    board configureGrid: ((CTNewArray2D width: 3 height: 3)
        at: 1 @ 1 put: SGBox blue;
        at: 2 @ 1 put: SGBox yellow;
        at: 3 @ 1 put: SGBox green;
        at: 1 @ 2 put: SGBox red;
        at: 2 @ 2 put: SGBoxWithKillAbility killColumn;
        at: 3 @ 2 put: SGBox blue;
        at: 1 @ 3 put: SGBox yellow;
        at: 2 @ 3 put: SGBox green;
        at: 3 @ 3 put: SGBox red;
        yourself).
    
    "Cliquer sur la tuile Kill Column en position (2,2)"
    board hitBox: (board boxAt: 2 @ 2).
    
    "Vérifier que la colonne 3 (à droite) est vide après réorganisation"
    self assert: (board boxAt: 3 @ 1) literal equals: 'N'.
    self assert: (board boxAt: 3 @ 2) literal equals: 'N'.
    self assert: (board boxAt: 3 @ 3) literal equals: 'N'.
]

{ #category : 'tests' }
SGKillBoxTest >> testKillLineRemovesAllBoxesInRow [
	|board|
	 "Test que killLine supprime toute une ligne"
    
    board := SGBoard new game: SGGame new.
    board configureGrid: ((CTNewArray2D width: 3 height: 3)
        at: 1 @ 1 put: SGBox blue;
        at: 2 @ 1 put: SGBox yellow;
        at: 3 @ 1 put: SGBox green;
        at: 1 @ 2 put: SGBoxWithKillAbility killLine;
        at: 2 @ 2 put: SGBox red;
        at: 3 @ 2 put: SGBox blue;
        at: 1 @ 3 put: SGBox yellow;
        at: 2 @ 3 put: SGBox green;
        at: 3 @ 3 put: SGBox red;
        yourself).
    
    "Cliquer sur la tuile Kill Line"
    board hitBox: (board boxAt: 1 @ 2).
    
    "Vérifier que la ligne 3 (en haut) est maintenant vide après réorganisation"
    self assert: (board boxAt: 1 @ 3) literal equals: 'N'.
    self assert: (board boxAt: 2 @ 3) literal equals: 'N'.
    self assert: (board boxAt: 3 @ 3) literal equals: 'N'.
]
