Class {
	#name : 'SGKillColumnState',
	#superclass : 'SGNullState',
	#category : 'Myg-SameGame',
	#package : 'Myg-SameGame'
}

{ #category : 'accessing' }
SGKillColumnState >> backgroundRepresentation [
	"Couleur distinctive pour la tuile Kill Column - violet foncé"
	^ Color purple darker
]

{ #category : 'accessing' }
SGKillColumnState >> isNull [
	^ false
]

{ #category : 'testing' }
SGKillColumnState >> isSpecialKillTile [
	^ true
]

{ #category : 'as yet unclassified' }
SGKillColumnState >> killsColumn [
	^ true
]

{ #category : 'as yet unclassified' }
SGKillColumnState >> killsLine [
	^ false
]

{ #category : 'accessing' }
SGKillColumnState >> literal [
		^ 'KC'
]

{ #category : 'as yet unclassified' }
SGKillColumnState >> nextStateInCycle [
	^ self
]
