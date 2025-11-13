Class {
	#name : 'SGBoxWithCyclingColorTest',
	#superclass : 'TestCase',
	#instVars : [
		'board',
		'graphicBoard'
	],
	#category : 'Myg-SameGame-UI-Tests',
	#package : 'Myg-SameGame',
	#tag : 'UI-Tests'
}

{ #category : 'running' }
SGBoxWithCyclingColorTest >> setUp [

	super setUp.
	"Y: Yellow , B: Blue , G: Green , R: Red, N : Null
	C : reprensents a Box with cycle, W : reprensent a Box without cycle
	represents this grid:
	 | WB | WY | WG | 
	 | WB | CR | CG | 
	 | CY | WY |  N |

	"
	board := SGBoard new game: SGGame new.
	board configureGrid: ((CTNewArray2D width: 3 height: 3)
			 at: 1 @ 1 put: SGBox blue;
			 at: 2 @ 1 put: SGBox yellow;
			 at: 3 @ 1 put: SGBox green;
			 at: 1 @ 2 put: SGBox blue;
			 at: 2 @ 2 put: SGBoxWithCyclingColor red;
			 at: 3 @ 2 put: SGBoxWithCyclingColor green;
			 at: 1 @ 3 put: SGBoxWithCyclingColor yellow;
			 at: 2 @ 3 put: SGBox yellow;
			 at: 3 @ 3 put: SGBox null;
			 yourself).
			
	graphicBoard := SGBoardElement new.
	graphicBoard grid: board grid.

]

{ #category : 'tests' }
SGBoxWithCyclingColorTest >> testClickOn2BoxesWithSameColorsBoxWithCyclingChangeColor [

	"Vérifie que la box avec le cycle change bien de couleur lors d'un clic sur 2 box de la même couleur,
	incluant un réarrangement des colonnes"

	self
		assert: (graphicBoard grid at: 1 @ 3) background paint color
		equals: Color lightYellow .
		
	"Après avoir vérifié que la couleur de la case est bien rouge, on clique sur la case (1 1) qui
	est de la même couleur que celle d'en dessous, cela va donc enclencher le changement de couleur 
	de la case avec cycle et la faire remonter jusqu'en (1 1)"
		
	board hitBoxOnx: 1 y: 1.
	
	self
		assert: (graphicBoard grid at: 1 @ 3) background paint color
		equals: Color gray .
	
	self
		assert: (graphicBoard grid at: 1 @ 1) background paint color
		equals: Color lightGreen .
]

{ #category : 'tests' }
SGBoxWithCyclingColorTest >> testClickOnNullBoxWithCyclingChangeColor [

	"Vérifie que la box avec le cycle ne change pas de couleur lors d'un clic sur une box null"

	self
		assert: (graphicBoard grid at: 2 @ 2) background paint color
		equals: Color lightRed .

	self
		assert: (graphicBoard grid at: 3 @ 3) background paint color
		equals: Color gray .
		
	"Après avoir vérifié que la couleur de la case est bien rouge, on clique sur la case (3 3) qui
	est null, cela ne va donc pas enclencher le changement de couleur de la case avec cycle"
		
	board hitBoxOnx: 3 y: 3.
	
	self
		assert: (graphicBoard grid at: 2 @ 2) background paint color
		equals: Color lightRed .
]

{ #category : 'tests' }
SGBoxWithCyclingColorTest >> testClickOnSingleBoxWithCyclingChangeColor [

	"Vérifie que la box avec le cycle change bien de couleur lors d'un clic sur une box seule (n'ayant aucune
	couleur identique autour), n'incluant un réarrangement des colonnes"

	self
		assert: (graphicBoard grid at: 3 @ 2) background paint color
		equals: Color lightGreen .
		
	"Après avoir vérifié que la couleur de la case est bien verte, on clique sur la case (2 3) qui
	est dite seule, cela va donc enclencher le changement de couleur de la case avec cycle"
		
	board hitBoxOnx: 2 y: 3.
	
	self
		assert: (graphicBoard grid at: 3 @ 2) background paint color
		equals: Color lightRed .
]
