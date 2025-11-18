"
I represent a Case of the SameGame

I have the responsabilities of my coordinates

I am part of a Board of a Same Game
"
Class {
	#name : 'SGNullState',
	#superclass : 'Object',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Myg-SameGame-Model',
	#package : 'Myg-SameGame',
	#tag : 'Model'
}

{ #category : 'accessing' }
SGNullState class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'accessing' }
SGNullState >> backgroundRepresentation [

	^ Color gray
]

{ #category : 'accessing' }
SGNullState >> isNull [

	^ true
]

{ #category : 'testing' }
SGNullState >> isSpecialKillTile [
	"Par défaut, les états ne sont pas des tuiles spéciales"
	^ false
]

{ #category : 'as yet unclassified' }
SGNullState >> killsColumn [
	"Par défaut, les états ne tuent pas de colonne"
	^ false
]

{ #category : 'as yet unclassified' }
SGNullState >> killsLine [
	"Par défaut, les états ne tuent pas de ligne"
	^ false
]

{ #category : 'accessing' }
SGNullState >> literal [

	^ 'N'
]

{ #category : 'accessing' }
SGNullState >> nextStateInCycle [
	^ self
]
