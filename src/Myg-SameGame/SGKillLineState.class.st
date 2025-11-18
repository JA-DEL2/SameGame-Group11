Class {
	#name : 'SGKillLineState',
	#superclass : 'SGNullState',
	#category : 'Myg-SameGame',
	#package : 'Myg-SameGame'
}

{ #category : 'accessing' }
SGKillLineState >> backgroundRepresentation [
"Couleur distinctive pour la tuile Kill Line - orange foncé"
	^ Color orange darker

]

{ #category : 'accessing' }
SGKillLineState >> isNull [
		^ false
]

{ #category : 'testing' }
SGKillLineState >> isSpecialKillTile [
	^ true
]

{ #category : 'as yet unclassified' }
SGKillLineState >> killsColumn [
	^ false
]

{ #category : 'as yet unclassified' }
SGKillLineState >> killsLine [
	^ true
]

{ #category : 'accessing' }
SGKillLineState >> literal [
		^ 'KL'
]

{ #category : 'as yet unclassified' }
SGKillLineState >> nextStateInCycle [
	^ self
]
