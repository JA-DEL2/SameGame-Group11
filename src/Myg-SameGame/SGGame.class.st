Class {
	#name : 'SGGame',
	#superclass : 'Object',
	#instVars : [
		'board',
		'points',
		'killedTiles',
		'lastSelectionCount'
	],
	#category : 'Myg-SameGame-Model',
	#package : 'Myg-SameGame',
	#tag : 'Model'
}

{ #category : 'accessing' }
SGGame >> addPoints: numberOfPoints [

	points := points + numberOfPoints
]

{ #category : 'accessing' }
SGGame >> grid [

	^ board
]

{ #category : 'accessing' }
SGGame >> grid: aBoard [

	board := aBoard
]

{ #category : 'initialization' }
SGGame >> initialize [
    super initialize.
    points := 0.
    lastSelectionCount := 0.
    killedTiles := 0.

]

{ #category : 'accessing' }
SGGame >> killedTiles [
	^ killedTiles 
]

{ #category : 'accessing' }
SGGame >> killedTiles: aNumber [
	killedTiles := aNumber
]

{ #category : 'accessing' }
SGGame >> lastSelectionCount [
	^ lastSelectionCount
]

{ #category : 'accessing' }
SGGame >> lastSelectionCount: aNumber [
	lastSelectionCount := aNumber
]

{ #category : 'accessing' }
SGGame >> points [

	^ points
]

{ #category : 'accessing' }
SGGame >> points: numberOfPoints [

	points := numberOfPoints
]
