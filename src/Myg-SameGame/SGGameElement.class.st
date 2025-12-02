Class {
	#name : 'SGGameElement',
	#superclass : 'BlElement',
	#instVars : [
		'selectionLabel',
		'killedLabel',
		'board'
	],
	#category : 'Myg-SameGame-UI',
	#package : 'Myg-SameGame',
	#tag : 'UI'
}

{ #category : 'accessing' }
SGGameElement >> board [ 
	^ board
]

{ #category : 'accessing' }
SGGameElement >> board: aBoard [
    | gridElement |
	 board := aBoard.

    board announcer
        when: SGStatsChangedAnnouncement
        send: #updateStatsDisplay
        to: self.

    gridElement := SGBoardElement new.
    gridElement grid: board grid.
    self addChild: gridElement.

    self updateStatsDisplay.

]

{ #category : 'initialization' }
SGGameElement >> initialize [
    super initialize.
    self layout: (BlLinearLayout vertical).

    selectionLabel := BlTextElement new.
    selectionLabel text: 'Selection: 0'.
    self addChild: selectionLabel.

    killedLabel := BlTextElement new.
    killedLabel text: 'Killed: 0'.
    self addChild: killedLabel.

]

{ #category : 'accessing' }
SGGameElement >> killedLabel [
	^ killedLabel
]

{ #category : 'accessing' }
SGGameElement >> selectionLabel [
	^ selectionLabel 
]

{ #category : 'as yet unclassified' }
SGGameElement >> updateStatsDisplay [
    board ifNil: [ ^ self ].
    selectionLabel text: 'Selection: ', board game lastSelectionCount asString.
    killedLabel text: 'Killed: ', board game killedTiles asString.

]
