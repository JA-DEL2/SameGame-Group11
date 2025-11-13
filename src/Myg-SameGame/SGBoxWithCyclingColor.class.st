Class {
	#name : 'SGBoxWithCyclingColor',
	#superclass : 'SGBox',
	#category : 'Myg-SameGame-Model',
	#package : 'Myg-SameGame',
	#tag : 'Model'
}

{ #category : 'clicking' }
SGBoxWithCyclingColor >> updateStateWithCycle [

	self state: state nextStateInCycle
]
