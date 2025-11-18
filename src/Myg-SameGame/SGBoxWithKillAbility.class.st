Class {
	#name : 'SGBoxWithKillAbility',
	#superclass : 'SGBox',
	#category : 'Myg-SameGame',
	#package : 'Myg-SameGame'
}

{ #category : 'as yet unclassified' }
SGBoxWithKillAbility class >> killColumn [
	^ self withState: SGKillColumnState uniqueInstance
]

{ #category : 'as yet unclassified' }
SGBoxWithKillAbility class >> killLine [
	^ self withState: SGKillLineState uniqueInstance
]

{ #category : 'clicking' }
SGBoxWithKillAbility >> propagateClick [
	"Les tuiles spéciales ne propagent pas - elles ont un comportement spécial"
	self board hitList add: self
]
