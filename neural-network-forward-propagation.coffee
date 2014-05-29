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



# format: layer -> row -> column
theta =
	2: 
		1:
			0: -30
			1: 20
			2: 20
		2: 
			0: 10
			1: -20
			2: -20
	3: 
		1:
			0: -10
			1: 20
			2: 20



g = (z) ->
	pow = math.pow math.E, -z
	1 / (1 + pow)



forwardPropagation = (t) ->
	a = {}

	# 1. (input) layer
	a[1] =
		'1': t[0][0]
		'2': t[0][1]

	# 2 (hidden) layer
	a[2] = 
		'1': g(theta[2][1][0] + a[1][1] * theta[2][1][1] + a[1][2] * theta[2][1][2])
		'2': g(theta[2][2][0] + a[1][1] * theta[2][2][1] + a[1][2] * theta[2][2][2])

	# 3. (output) layer (hypotesis)
	a[3] =
		'1': g(theta[3][1][0] + a[2][1] * theta[3][1][1] + a[2][2] * theta[3][1][2])

	a



calculate = ->
	results = []
	for t in set
		a = forwardPropagation t
		results.push
			x1: t[0][0]
			x2: t[0][1]
			result: a[3][1]
			round: Math.round a[3][1]
	results






console.log "#{result.x1} XNOR #{result.x2} = #{result.round}" for result in calculate()