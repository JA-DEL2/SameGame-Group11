Class {
	#name : 'SGBoard',
	#superclass : 'MygBoard',
	#instVars : [
		'game',
		'hitList',
		'announcer'
	],
	#category : 'Myg-SameGame-Model',
	#package : 'Myg-SameGame',
	#tag : 'Model'
}

{ #category : 'accessing' }
SGBoard >> announcer [

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : 'compute' }
SGBoard >> boxAt: aPoint [

	^ self grid at: aPoint x @ aPoint y
]

{ #category : 'compute' }
SGBoard >> calculePoint [

	^ hitList size * hitList size
]

{ #category : 'accessing' }
SGBoard >> game [

	^ game
]

{ #category : 'accessing' }
SGBoard >> game: aGame [

	game := aGame
]

{ #category : 'reorganize' }
SGBoard >> generateGridWidth: width height: height [

	| array2D |
	array2D := CTNewArray2D
		           width: width
		           height: height
		           tabulate: [ :col :row | self randomBox ].
	self configureGrid: array2D
]

{ #category : 'as yet unclassified' }
SGBoard >> handleSpecialKillBox: aBox [

	"Gère le clic sur une tuile spéciale Kill Line ou Kill Column"
	
	aBox state killsLine ifTrue: [ 
		self killLineAt: aBox y.
		^ self ].
	
	aBox state killsColumn ifTrue: [ 
		self killColumnAt: aBox x.
		^ self ]
]

{ #category : 'hit' }
SGBoard >> hitBox: aBox [

	"Version améliorée qui gère les tuiles spéciales"
	
	aBox hasNullState ifTrue: [ ^ self ].
	
	"Vérifier si c'est une tuile spéciale de type Kill"
	(aBox state isSpecialKillTile) ifTrue: [
		^ self handleSpecialKillBox: aBox ].
	
	"Comportement normal pour les tuiles classiques"
	aBox propagateClick.
	
	self hitList size > 1 ifTrue: [
		self hitList do: [ :each | each state: SGNullState uniqueInstance ] ].

	self game addPoints: self calculePoint.
	
	self updateBoxWithColorCycling.

	self hitList do: [ :each | self reorganizeColumn: each x ].

	self hitList removeAll.

	self reorganizeForEmptyColumn
]

{ #category : 'hit' }
SGBoard >> hitBoxOnx: x y: y [

	(self grid at: x @ y) hasNullState ifTrue: [ ^ self ].
	(self grid at: x @ y) propagateClick.
	self hitList size > 1 ifTrue: [
		self hitList do: [ :each | each state: SGNullState uniqueInstance  ] ].

	self game addPoints: self calculePoint.
	
	self updateBoxWithColorCycling .

	self hitList do: [ :each | self reorganizeColumn: each x ].
	self updateKilledTiles.
	self updateSelectionCount.
	self hitList removeAll.
	self reorganizeForEmptyColumn
]

{ #category : 'accessing' }
SGBoard >> hitList [ 

	^ hitList 
]

{ #category : 'initialization' }
SGBoard >> initialize [

	super initialize.
	hitList := OrderedCollection new.
	announcer := Announcer new.
	"stackHit := Stack new -> has no reference"
	"stock les cases touchées"
]

{ #category : 'accessing' }
SGBoard >> isColumnEmpty: x [

	1 to: self grid height do: [ :i |
	(self boxAt: x @ i) hasNullState ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'accessing' }
SGBoard >> killColumnAt: columnNumber [
	"Élimine toute la colonne verticale à la position donnée"
	
	| killedBoxes |
	killedBoxes := OrderedCollection new.
	
	"Collecter toutes les boxes de la colonne"
	1 to: self grid height do: [ :row |
		| box |
		box := self boxAt: columnNumber @ row.
		box hasNullState ifFalse: [ 
			killedBoxes add: box.
			box state: SGNullState uniqueInstance ] ].
	
	"Ajouter des points : nombre de cases * 2 (bonus pour tuile spéciale)"
	self game addPoints: (killedBoxes size * 2).
	
	"Réorganiser la colonne affectée et les colonnes vides"
	self reorganizeColumn: columnNumber.
	self reorganizeForEmptyColumn
]

{ #category : 'accessing' }
SGBoard >> killLineAt: rowNumber [
	"Élimine toute la ligne horizontale à la position donnée"
	
	| killedBoxes |
	killedBoxes := OrderedCollection new.
	
	"Collecter toutes les boxes de la ligne"
	1 to: self grid width do: [ :col |
		| box |
		box := self boxAt: col @ rowNumber.
		box hasNullState ifFalse: [ 
			killedBoxes add: box.
			box state: SGNullState uniqueInstance ] ].
	
	"Ajouter des points : nombre de cases * 2 (bonus pour tuile spéciale)"
	self game addPoints: (killedBoxes size * 2).
	
	"Réorganiser les colonnes"
	1 to: self grid width do: [ :col |
		self reorganizeColumn: col ].
	
	self reorganizeForEmptyColumn
]

{ #category : 'random subclass instance creation' }
SGBoard >> randomBox [

	"Version améliorée avec tuiles spéciales rares"
	
	| boxes states random |
	
	boxes := Array new: 100.
	
	"90 boxes normales"
	1 to: 90 do: [:i | boxes at: i put: SGBox].
	
	"5 boxes Kill Line (rares)"
	91 to: 95 do: [:i | boxes at: i put: SGBoxWithKillAbility].
	
	"5 boxes Kill Column (rares)"
	96 to: 100 do: [:i | boxes at: i put: SGBoxWithKillAbility].
	
	"10 boxes with color cycle"
	81 to: 90 do: [:i | boxes at: i put: SGBoxWithCyclingColor].
	
	random := boxes atRandom.
	
	"Si c'est une box spéciale Kill, retourner avec le bon état"
	(random = SGBoxWithKillAbility) ifTrue: [
		"50% chance pour Kill Line, 50% pour Kill Column"
		^ (Random new next < 0.5)
			ifTrue: [ SGBoxWithKillAbility killLine ]
			ifFalse: [ SGBoxWithKillAbility killColumn ] ].
	
	"Sinon, comportement normal"
	states := {
		SGBlueState.
		SGRedState.
		SGGreenState.
		SGYellowState }.
	^ random withState: states atRandom uniqueInstance
]

{ #category : 'reorganize' }
SGBoard >> reorganizeColumn: x [

	| col newCol |
	col := self grid atColumn: x.
	newCol := col reject: [ :each | each hasNullState ].
	1 to: newCol size do: [ :i | (col at: i) state: (newCol at: i) state ].
	newCol size + 1 to: col size do: [ :j |
	(col at: j) state: SGNullState uniqueInstance ]
]

{ #category : 'reorganize' }
SGBoard >> reorganizeForEmptyColumn [

	| cpt |
	cpt := 0.
	1 to: self grid width do: [ :i |
		(self isColumnEmpty: i - cpt) ifTrue: [
			i - cpt to: self grid width - 1 - cpt do: [ :j |
				self switchColumn: j withColumn: j + 1 ].
			cpt := cpt + 1 ] ] .
]

{ #category : 'compute' }
SGBoard >> switchBox: aPoint1 with: aPoint2 [

	| box1 box2 tmpState |
	box1 := self boxAt: aPoint1.
	box2 := self boxAt: aPoint2.
	box1 state = box2 state ifTrue: [ ^ self ].
	"This will avoid calling announcements later"
	tmpState := box1 state.
	box1 state: box2 state.
	box2 state: tmpState 
]

{ #category : 'compute' }
SGBoard >> switchColumn: firstColumn withColumn: secondColumn [

	1 to: self grid height do: [ :i |
	self switchBox: firstColumn @ i with: secondColumn @ i ]
]

{ #category : 'reorganize' }
SGBoard >> updateBoxWithColorCycling [

	"Met à jour l'état des boxes avec cycle de couleur après chaque coup"

	1 to: self grid width do: [:x |
   		1 to: self grid height do: [:y |
        	(self boxAt: x @ y) updateStateWithCycle.
   		].
	].
]

{ #category : 'accessing' }
SGBoard >> updateKilledTiles [
	"Accumulate number of removed tiles"
	self game killedTiles: (self game killedTiles + self hitList size).
	announcer announce: SGStatsChangedAnnouncement new.
]

{ #category : 'accessing' }
SGBoard >> updateSelectionCount [
	"Store number of tiles selected in the last move"
	self game lastSelectionCount: self hitList size.
	announcer announce: SGStatsChangedAnnouncement new.
]
