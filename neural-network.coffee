math = require('mathjs')()

###

[ +1 ]  ---> [ +1 ]

[ x1 ]  ---> [ a1 ]  ---> [ a1 ]  ---> h()

[ x2 ]  ---> [ a2 ]

###



# training set
set = [
	[ [0, 0], 1 ]
	[ [0, 1], 0 ]
	[ [1, 0], 0 ]
	[ [1, 1], 1 ] 
]


testTheta = [ 
	[ 
		[]
	],
  	[ 
  		[ -30, 20, 20 ],
    	[ 10, -20, -20 ] 
    ],
  	[ 
  		[ -10, 20, 20 ] 
  	] 
]



###
[ 
	[ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ],
  	[ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ],
  	[ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ] 

  	layers cislovany od 0, tj. 0 = input, 1 = hidden, 2 = output 
]
###
initDeltaBig = ->
	outArray = []
	for l in [0..2]
		inArray = []
		for j in [0..2]
			inArray.push (0 for num in [0..2])
		outArray.push inArray
	outArray



randomValues = ->
	(Math.random() for i in [0..2])



initRandomTheta = ->
	theta = []
	theta.push [[]]
	theta.push [randomValues(), randomValues()]
	theta.push [randomValues()]
	theta



g = (z) ->
	pow = math.pow math.E, -z
	1 / (1 + pow)



###
	Vypocet pro hidden a theta vrstvu
###
forwardPropagation = (t, theta) ->
	layer0 = t[0]
	layer1 = []
	layer2 = []

	layer1.push g( theta[1][0][0] + layer0[0] * theta[1][0][1] + layer0[1] * theta[1][0][2] )
	layer1.push g( theta[1][1][0] + layer0[0] * theta[1][1][1] + layer0[1] * theta[1][1][2] )

	layer2.push g( theta[2][0][0] + layer1[0] * theta[2][0][1] + layer1[1] * theta[2][0][2] )

	[layer0, layer1, layer2]






calculate = (theta) ->
	deltaBig = initDeltaBig()

	for t in set
		a = forwardPropagation t, theta
		console.log a[2]


calculate testTheta







###


numLayers = 3
numActivations  = 3 
numCalculations = 3


# l = layer
# j = node j in layer l (rows)
# i = calculation i in node j


initDeltaBig = ->
	delta = {}
	for l in [1..numLayers]
		delta[l] = {}
		for j in [1..numActivations]
			delta[l][j] = {}
			for i in [0..numCalculations]
				delta[l][j][i] = 0
	delta



initTheta = ->
	1: 
		1:
			0: Math.random()
			1: Math.random()
			2: Math.random()
		2: 
			0: Math.random()
			1: Math.random()
			2: Math.random()
	2: 
		1:
			0: Math.random()
			1: Math.random()
			2: Math.random()




g = (z) ->
	pow = math.pow math.E, -z
	1 / (1 + pow)



forwardPropagation = (t, theta) ->
	a = {}

	# 1. (input) layer
	a[1] =
		'1': t[0][0]
		'2': t[0][1]

	# 2 (hidden) layer
	a[2] = 
		'1': g(theta[1][1][0] + a[1][1] * theta[1][1][1] + a[1][2] * theta[1][1][2])
		'2': g(theta[1][2][0] + a[1][1] * theta[1][2][1] + a[1][2] * theta[1][2][2])

	# 3. (output) layer (hypotesis)
	a[3] =
		'1': g(theta[2][1][0] + a[2][1] * theta[2][1][1] + a[2][2] * theta[2][1][2])

	a


deltaSmall3 = (t, a) ->
	[t[1] - a[3][1]]



deltaSmall2 = (t, a, nextDeltaSmall, theta) ->
	output = []
	for i in [1, 2]
		output.push (theta[2][1][i] * nextDeltaSmall[0]) * a[2][i] * (1 - a[2][1])
	output



calculate = (theta) ->
	deltaBig = initDeltaBig()
	deltaSmall = {}

	for t in set
		a = forwardPropagation t, theta

		deltaSmall[3] = deltaSmall3 t, a
		deltaSmall[2] = deltaSmall2 t, a, deltaSmall[3], theta

		# l = 1, j = 1, i 
		deltaBig[1][1][1] = deltaBig[1][1][1] + a[1][1] * deltaSmall[2][0] 
		deltaBig[1][1][2] = deltaBig[1][1][2] + a[1][1] * deltaSmall[2][1] 

		# l = 1, j = 2, i
		deltaBig[1][2][1] = deltaBig[1][2][1] + a[1][2] * deltaSmall[2][0] 
		deltaBig[1][2][2] = deltaBig[1][2][2] + a[1][2] * deltaSmall[2][1] 

		# l = 2, j = 1, i
		deltaBig[2][1][1] = deltaBig[2][1][1] + a[2][1] * deltaSmall[3][0]
		deltaBig[2][1][2] = deltaBig[2][1][2] + a[2][1] * deltaSmall[3][0]

		# l = 2, j = 2, i
		deltaBig[2][2][1] = deltaBig[2][2][1] + a[2][2] * deltaSmall[3][0]
		deltaBig[2][2][2] = deltaBig[2][2][2] + a[2][2] * deltaSmall[3][0]

	deltaBig
		


delta = calculate initTheta()

console.log delta

###