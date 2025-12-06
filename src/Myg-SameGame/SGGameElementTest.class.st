Class {
	#name : 'SGGameElementTest',
	#superclass : 'TestCase',
	#category : 'Myg-SameGame-UI-Tests',
	#package : 'Myg-SameGame',
	#tag : 'UI-Tests'
}

{ #category : 'tests' }
SGGameElementTest >> testKillColumnUpdatesStats [
    "Vérifie que les stats sont mises à jour quand on tue une colonne complète"
    | game board |
    
    game := SGGame new.
    board := SGBoard new game: game.
    
    "Créer une grille 3x3 pleine"
    board configureGrid: ((CTNewArray2D width: 3 height: 3)
        at: 1 @ 1 put: SGBox blue;
        at: 2 @ 1 put: SGBox red;
        at: 3 @ 1 put: SGBox yellow;
        at: 1 @ 2 put: SGBox blue;
        at: 2 @ 2 put: SGBox red;
        at: 3 @ 2 put: SGBox yellow;
        at: 1 @ 3 put: SGBox blue;
        at: 2 @ 3 put: SGBox red;
        at: 3 @ 3 put: SGBox yellow;
        yourself).
    
    "Tuer la première colonne"
    board killColumnAt: 1.
    
    "Vérifier les stats"
    self assert: game lastSelectionCount equals: 3.
    self assert: game killedTiles equals: 3.
]

{ #category : 'tests' }
SGGameElementTest >> testKillLineUpdatesStats [
    "Vérifie que les stats sont mises à jour quand on tue une ligne complète"
    | game board |
    
    game := SGGame new.
    board := SGBoard new game: game.
    
    "Créer une grille 3x3 pleine (pas de null)"
    board configureGrid: ((CTNewArray2D width: 3 height: 3)
        at: 1 @ 1 put: SGBox blue;
        at: 2 @ 1 put: SGBox blue;
        at: 3 @ 1 put: SGBox blue;
        at: 1 @ 2 put: SGBox red;
        at: 2 @ 2 put: SGBox red;
        at: 3 @ 2 put: SGBox red;
        at: 1 @ 3 put: SGBox yellow;
        at: 2 @ 3 put: SGBox yellow;
        at: 3 @ 3 put: SGBox yellow;
        yourself).
    
    "Tuer la première ligne"
    board killLineAt: 1.
    
    "Vérifier les stats"
    self assert: game lastSelectionCount equals: 3.
    self assert: game killedTiles equals: 3.
]

{ #category : 'tests' }
SGGameElementTest >> testKillLineUpdatesStatsOnGeneratedBoard [

    | game board |

    game := SGGame new.
    board := SGBoard new game: game.

    "Générer une grille vide 20x20"
    board generateGridWidth: 20 height: 20.

   
    "Ligne 1 doit être pleine → killLineAt doit en tuer width"
    board killLineAt: 1.

    self assert: game lastSelectionCount equals: 20.
    self assert: game killedTiles equals: 20.

	 board killLineAt: 1.
	
	self assert: game lastSelectionCount equals: 20.
   self assert: game killedTiles equals: 40.

]

{ #category : 'tests' }
SGGameElementTest >> testKilledTilesNotUpdated [
    | game board boxElement ui |

    "Initialisation"
    game := SGGame new.
    board := SGBoard new game: game.

    "Créer une grille simple 2x2"
    board configureGrid: ((CTNewArray2D width: 2 height: 2)
        at: 1 @ 1 put: SGBox blue;
        at: 2 @ 1 put: SGBox null;
        at: 1 @ 2 put: SGBox red;
        at: 2 @ 2 put: SGBox red;
        yourself).

    ui := SGGameElement new.
    ui board: board.

    "Cas 1: box vide (SGNullState)"
    boxElement := board boxAt: 2 @ 1.
    board hitBox: boxElement.
    board updateKilledTiles.
    self assert: game killedTiles equals: 0.

    "Cas 2: box seule sélectionnée"
    boxElement := board boxAt: 1 @ 1.
    board hitBox: boxElement.
    board updateKilledTiles.
    self assert: game killedTiles equals: 0.

]

{ #category : 'tests' }
SGGameElementTest >> testUIStatsAccumulateOverMultipleMoves [
    "Vérifie que killedTiles s'accumule sur plusieurs coups"
    | game board ui |
    
    game := SGGame new.
    board := SGBoard new game: game.
    board configureGrid: ((CTNewArray2D width: 3 height: 3)
        at: 1 @ 1 put: SGBox blue;
        at: 2 @ 1 put: SGBox blue;
        at: 3 @ 1 put: SGBox red;
        at: 1 @ 2 put: SGBox yellow;
        at: 2 @ 2 put: SGBox yellow;
        at: 3 @ 2 put: SGBox red;
        at: 1 @ 3 put: SGBox null;
        at: 2 @ 3 put: SGBox null;
        at: 3 @ 3 put: SGBox null;
        yourself).
    
    ui := SGGameElement new.
    ui board: board.
    
    "Premier coup : 2 boxes bleues"
    board hitBox: (board boxAt: 1 @ 1).
	 self assert: ui selectionLabel text asString equals: 'Selection: 2'.
    self assert: ui killedLabel text asString equals: 'Killed: 2'.
    
    "Deuxième coup : 2 boxes jaunes"
    board hitBox: (board boxAt: 1 @ 1). "maintenant c'est une yellow après réorganisation"
    self assert: ui killedLabel text asString equals: 'Killed: 4'.
	 self assert: ui selectionLabel text asString equals: 'Selection: 2'.
]

{ #category : 'tests' }
SGGameElementTest >> testUIStatsInitializedToZero [
    "Vérifie que les stats sont initialisées à 0"
    | game board ui |
    
    game := SGGame new.
    board := SGBoard new game: game.
    board generateGridWidth: 20 height: 20.
    
    ui := SGGameElement new.
    ui board: board.
    
    "Les stats doivent être à 0 au départ"
    self assert: ui selectionLabel text asString equals: 'Selection: 0'.
    self assert: ui killedLabel text asString equals: 'Killed: 0'.
]

{ #category : 'tests' }
SGGameElementTest >> testUIStatsUpdateAfterNormalMove [
    "Vérifie que les stats se mettent à jour après un coup normal"
    | game board ui |
    
    "Créer une grille simple avec 3 boxes bleues adjacentes
     | B | B | R | 
     | B | R | R | 
     | N | N | N |"
    game := SGGame new.
    board := SGBoard new game: game.
    board configureGrid: ((CTNewArray2D width: 3 height: 3)
        at: 1 @ 1 put: SGBox blue;
        at: 2 @ 1 put: SGBox blue;
        at: 3 @ 1 put: SGBox red;
        at: 1 @ 2 put: SGBox blue;
        at: 2 @ 2 put: SGBox red;
        at: 3 @ 2 put: SGBox red;
        at: 1 @ 3 put: SGBox null;
        at: 2 @ 3 put: SGBox null;
        at: 3 @ 3 put: SGBox null;
        yourself).
    
    ui := SGGameElement new.
    ui board: board.
    
    "Cliquer sur une box bleue (devrait sélectionner 3 boxes)"
    board hitBox: (board boxAt: 1 @ 1).
    
    "Vérifier que les stats sont correctes"
    self assert: ui selectionLabel text asString equals: 'Selection: 3'.
    self assert: ui killedLabel text asString equals: 'Killed: 3'.
]
