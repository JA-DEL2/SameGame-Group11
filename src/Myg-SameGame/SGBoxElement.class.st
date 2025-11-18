Class {
	#name : 'SGBoxElement',
	#superclass : 'BlElement',
	#instVars : [
		'gridPosition',
		'board',
		'box'
	],
	#category : 'Myg-SameGame-UI',
	#package : 'Myg-SameGame',
	#tag : 'UI'
}

{ #category : 'accessing' }
SGBoxElement class >> createWithBox: aSGBox [

	^ self new
		  box: aSGBox;
		  background: aSGBox backgroundRepresentation;
		yourself
]

{ #category : 'accessing' }
SGBoxElement >> board [

	^ board
]

{ #category : 'accessing' }
SGBoxElement >> board: aSGBoardElement [

	board := aSGBoardElement
]

{ #category : 'accessing' }
SGBoxElement >> box [ 
	
	^ box
]

{ #category : 'accessing' }
SGBoxElement >> box: aSGBox [ 

	box := aSGBox.
	
	self initializeAnnouncements.
	self initializeSpecialIndicator
]

{ #category : 'public' }
SGBoxElement >> click [

	self box click
]

{ #category : 'accessing' }
SGBoxElement >> gridPosition [

	^ gridPosition
]

{ #category : 'accessing' }
SGBoxElement >> gridPosition: aPosition [

	gridPosition := aPosition
]

{ #category : 'initialization' }
SGBoxElement >> initialize [

	super initialize.

	self geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	self constraintsDo: [ :aLayoutConstraints |
		aLayoutConstraints horizontal matchParent.
		aLayoutConstraints vertical matchParent ].

	self addEventHandlerOn: BlClickEvent do: [ :anEvent | self click ]
]

{ #category : 'initialization' }
SGBoxElement >> initializeAnnouncements [ 

	self box announcer when: SGStateChangedAnnouncement send: #updateBackgroundColor to: self
]

{ #category : 'initialization' }
SGBoxElement >> initializeSpecialIndicator [
	| label |
	"Ajoute un indicateur visuel si c'est une tuile spéciale"
	
	self box ifNil: [ ^ self ].
	
	(self box state isSpecialKillTile) ifFalse: [ ^ self ].
	
	"Ajouter une bordure épaisse pour les tuiles spéciales"
	self border: (BlBorder paint: Color white width: 3).
	
	"Ajouter un texte indicateur"
	self layout: BlFrameLayout new.
	

	label := BlTextElement new.
	label text: (self box state killsLine 
		ifTrue: [ ('—' asRopedText fontSize: 30; foreground: Color white) ]
		ifFalse: [ ('|' asRopedText fontSize: 30; foreground: Color white) ]).
	
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	
	self addChild: label
]

{ #category : 'change reporting' }
SGBoxElement >> updateBackgroundColor [

	"Mise à jour avec gestion des tuiles spéciales"
	
	self removeChildren.
	self background: self box backgroundRepresentation.
	self initializeSpecialIndicator.
	^ self
]
