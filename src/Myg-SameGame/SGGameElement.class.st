Class {
	#name : 'SGGameElement',
	#superclass : 'BlElement',
	#instVars : [
		'selectionLabel',
		'killedLabel',
		'board',
		'gridElement',
		'boardContainer',
		'header'
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
    board := aBoard.
    board announcer
        when: SGStatsChangedAnnouncement
        send: #updateStatsDisplay
        to: self.
    
    gridElement := SGBoardElement new.
    gridElement grid: board grid.
    
    "Ajoute la grille directement au SGGameElement"
    self addChild: gridElement.
    
    "Contraintes pour que la grille remplisse l'espace"
    gridElement constraintsDo: [:c |
        c horizontal matchParent.
        c vertical matchParent ].
]

{ #category : 'accessing' }
SGGameElement >> boardContainer [
	^ boardContainer
]

{ #category : 'accessing' }
SGGameElement >> gridElement [
    ^ gridElement
]

{ #category : 'initialization' }
SGGameElement >> initialize [
    super initialize.
    self layout: (BlLinearLayout vertical).
    
    "HEADER"
    header := BlElement new.
    header layout: (BlLinearLayout horizontal).
    header layout cellSpacing: 20.
    header padding: (BlInsets all: 10).
    header background: Color white.
    
    "Le header doit prendre toute la largeur mais une hauteur fixe"
    header constraintsDo: [:c |
        c horizontal matchParent.
        c vertical fitContent ].
    
    selectionLabel := BlTextElement new.
    selectionLabel text: ('Selection: 0' asRopedText fontSize: 16; foreground: Color black).
    header addChild: selectionLabel.
    
    killedLabel := BlTextElement new.
    killedLabel text: ('Killed: 0' asRopedText fontSize: 16; foreground: Color black).
    header addChild: killedLabel.
    
    self addChild: header.
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
    selectionLabel text: ('Selection: ', board game lastSelectionCount asString) asRopedText.
    killedLabel text: ('Killed: ', board game killedTiles asString) asRopedText.
]
