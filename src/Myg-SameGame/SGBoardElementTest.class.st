Class {
	#name : 'SGBoardElementTest',
	#superclass : 'TestCase',
	#instVars : [
		'board',
		'graphicBoard'
	],
	#category : 'Myg-SameGame-UI-Tests',
	#package : 'Myg-SameGame',
	#tag : 'UI-Tests'
}

{ #category : 'running' }
SGBoardElementTest >> setUp [

	super setUp.
	"Y: Yellow , B: Blue , G: Green , R: Red, N : Null
	represents this grid:
	 | B | Y | G | 
	 | B | Y | G | 
	 | R | Y | N | 

	"
	board := SGBoard new game: SGGame new.
	board configureGrid: ((CTNewArray2D width: 3 height: 3)
			 at: 1 @ 1 put: SGBox blue;
			 at: 2 @ 1 put: SGBox yellow;
			 at: 3 @ 1 put: SGBox green;
			 at: 1 @ 2 put: SGBox blue;
			 at: 2 @ 2 put: SGBox yellow;
			 at: 3 @ 2 put: SGBox green;
			 at: 1 @ 3 put: SGBox red;
			 at: 2 @ 3 put: SGBox yellow;
			 at: 3 @ 3 put: SGBox null;
			 yourself).
			
	graphicBoard := SGBoardElement new.
	graphicBoard grid: board grid.

]

{ #category : 'tests' }
SGBoardElementTest >> testClickOn2BlueBoxesColumnRearrange [
	
	board hitBoxOnx: 1 y: 1.

		self
		assert: (graphicBoard grid at: 1 @ 1) background paint color
		equals: Color lightRed.
	self
		assert: (graphicBoard grid at: 1 @ 2) background paint color
		equals: Color gray.
	self
		assert: (graphicBoard grid at: 1 @ 3) background paint color
		equals: Color gray.
]

{ #category : 'tests' }
SGBoardElementTest >> testClickOn3YellowBoxesSwitchEmptyColumn [

	board hitBoxOnx: 2 y: 1.
	
	self
		assert: (graphicBoard grid at: 2 @ 1) background paint color
		equals: Color lightGreen.
	self
		assert: (graphicBoard grid at: 2 @ 2) background paint color
		equals: Color lightGreen.
	self
		assert: (graphicBoard grid at: 2 @ 3) background paint color
		equals: Color gray.
		self
		assert: (graphicBoard grid at: 3 @ 1) background paint color
		equals: Color gray.
	self
		assert: (graphicBoard grid at: 3 @ 2) background paint color
		equals: Color gray.
	self
		assert: (graphicBoard grid at: 3 @ 3) background paint color
		equals: Color gray
]

{ #category : 'tests' }
SGBoardElementTest >> testClickOnIsolatedBoxNothingChanges [

		self
		assert: (graphicBoard grid at: 1 @ 3) background paint color
		equals: Color lightRed.

	board hitBoxOnx: 1 y: 3.
	
		self
		assert: (graphicBoard grid at: 1 @ 3) background paint color
		equals: Color lightRed.
]

{ #category : 'tests' }
SGBoardElementTest >> testClickOnNullNothingChanges [

		self
		assert: (graphicBoard grid at: 3 @ 3) background paint color
		equals: Color gray.

	board hitBoxOnx: 3 y: 3.
	
	self
		assert: (graphicBoard grid at: 3 @ 3) background paint color
		equals: Color gray
]

{ #category : 'tests' }
SGBoardElementTest >> testExchangeCase [

	self
		assert: (graphicBoard grid at: 1 @ 1) background paint color
		equals: Color lightBlue.
	
	self
		assert: (graphicBoard grid at: 2 @ 1) background paint color
		equals: Color lightYellow.
		
	board switchBox: 1 @ 1 with: 2 @ 1.
	
self
		assert: (graphicBoard grid at: 1 @ 1) background paint color
		equals: Color lightYellow.
		
	self
		assert: (graphicBoard grid at: 2 @ 1) background paint color
		equals: Color lightBlue.
]

{ #category : 'tests' }
SGBoardElementTest >> testGridSetUp [

	self
		assert: (graphicBoard grid at: 1 @ 1) background paint color
		equals: Color lightBlue.
	self
		assert: (graphicBoard grid at: 1 @ 2) background paint color
		equals: Color lightBlue.
	self
		assert: (graphicBoard grid at: 1 @ 3) background paint color
		equals: Color lightRed.
	self
		assert: (graphicBoard grid at: 2 @ 1) background paint color
		equals: Color lightYellow.
	self
		assert: (graphicBoard grid at: 2 @ 2) background paint color
		equals: Color lightYellow.
	self
		assert: (graphicBoard grid at: 2 @ 3) background paint color
		equals: Color lightYellow.
		self
		assert: (graphicBoard grid at: 3 @ 1) background paint color
		equals: Color lightGreen.
	self
		assert: (graphicBoard grid at: 3 @ 2) background paint color
		equals: Color lightGreen.
	self
		assert: (graphicBoard grid at: 3 @ 3) background paint color
		equals: Color gray.

]

{ #category : 'tests' }
SGBoardElementTest >> testUIStatsChanged [
    | game board ui |
    
    game := SGGame new.
    board := SGBoard new game: game.

    "IMPORTANT : créer la grille avant de créer l’UI"
    board generateGridWidth: 3 height: 3.

    ui := SGGameElement new.
    ui board: board.   "lie l'UI au board + abonnement aux annonces"

    "on simule une sélection"
    game lastSelectionCount: 5.
    board announcer announce: SGStatsChangedAnnouncement new.

    "on simule des tiles tuées"
    game killedTiles: 7.
    board announcer announce: SGStatsChangedAnnouncement new.

    ui updateStatsDisplay. "force un rafraîchissement UI pour le test"

    self assert: ui selectionLabel text equals: 'Selection: 5'.
    self assert: ui killedLabel text equals: 'Killed: 7'.

]
