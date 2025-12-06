Class {
	#name : 'SameGame',
	#superclass : 'Object',
	#category : 'Myg-SameGame-Model',
	#package : 'Myg-SameGame',
	#tag : 'Model'
}

{ #category : 'instance creation' }
SameGame class >> open [

	<script>
	| board graphicBoard space |
	board := SGBoard new game: SGGame new.
	board generateGridWidth: 20 height: 20.
	graphicBoard := SGBoardElement new.
	graphicBoard grid: board grid.

	space := BlSpace new.
	space title: 'SameGame'.
	space root addChild: graphicBoard.
	space extent: 1000 @ 1000.

	space show
]

{ #category : 'as yet unclassified' }
SameGame class >> openwithstat [

	<script>
	| board sgElement space |
	board := SGBoard new game: SGGame new.
	board generateGridWidth: 20 height: 20.

	sgElement := SGGameElement new.
	sgElement constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	sgElement board: board.

	space := BlSpace new.
	space title: 'SameGame'.
	space root addChild: sgElement.
	space extent: 1000 @ 1000.
	space show
]

{ #category : 'see class side' }
SameGame >> seeClassSide [ 
]
