Class {
	#name : 'SGMulticolorState',
	#superclass : 'SGNullState',
	#instVars : [
		'currentColorIndex',
		'colors'
	],
	#classVars : [
		'Colors'
	],
	#category : 'Myg-SameGame-Model',
	#package : 'Myg-SameGame',
	#tag : 'Model'
}

{ #category : 'accessing' }
SGMulticolorState >> backgroundRepresentation [
    ^ colors at: currentColorIndex.
]

{ #category : 'initialization' }
SGMulticolorState >> initialize [
    super initialize.
    colors := { 
        Color red. 
        Color orange. 
        Color yellow. 
        Color green. 
        Color cyan. 
        Color blue. 
        Color purple 
    }.
    currentColorIndex := 1.
]

{ #category : 'accessing' }
SGMulticolorState >> isNull [
    ^ false.
]

{ #category : 'accessing' }
SGMulticolorState >> literal [
    ^ 'M'.
]

{ #category : 'testing' }
SGMulticolorState >> matchesWithState: aState [
    "Le MultiColor matche avec n'importe quelle couleur non-nulle ou une couleur spécifique"
    ^ aState isNull not.
]

{ #category : 'accessing' }
SGMulticolorState >> nextColor [
    "Passer à la couleur suivante"
    currentColorIndex := currentColorIndex + 1.
    currentColorIndex > colors size ifTrue: [ currentColorIndex := 1 ].
    ^ self backgroundRepresentation.
]
