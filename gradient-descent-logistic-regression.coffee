###
Linear regression with gradient descent - matrix implementation.

###

math = require('mathjs')()


# training set
set = [
	[[0, 3], 0]
	[[1, 6], 0]
	[[2, 9], 0]
	[[4, 13], 1]
	[[5, 17], 1]
	[[6, 19], 0]
	[[7, 24], 0]
	[[8, 56], 0]
]


# learning rate
alpha = 0.0647144081


# number of examples
m = set.length


# max iterations of algoritm
maxIterations = 100000



sigmoid = (z) ->
	pow = math.pow math.E, -z
	1 / (1 + pow)


g = (matrix) ->
	result = []
	for val in matrix.toArray()
		result.push [sigmoid val[0]]
	result



#  [ 1, 0, 4 ], [ 1, 1, 7 ], [ 1, 2, 7 ], [ 1, 3, 8 ]
createX = ->
	matrix = (ex[0] for ex in set) 
	# x0 = 1
	row.unshift 1 for row in matrix
	matrix


# [2], [4], [6], [8]
createY = ->
	matrix = ([ex[1]] for ex in set)



# [1], [1], [1]
createTheta = ->
	length = set[0][0].length + 1
	math.ones [length, 1]



calculate = (debug = false)->
	theta = math.matrix createTheta()
	x = createX()
	y = createY()
	xTransposed = math.transpose x


	for i in [0...maxIterations]
		if debug then console.log theta.toArray().join ' | '

		a = math.multiply x, theta
		b = math.subtract (g a), y
		c = math.multiply xTransposed, b
		d = math.multiply (alpha/m), c

		t = math.subtract theta, d

		test = math.equal theta, t
		found = true
		found = r for r in test.toArray()[0] when not r
		if found
			return [t, true, i + 1]

		#m1 = math.subtract(theta, t).toArray()[0][0]
		#m2 = math.subtract(theta, t).toArray()[1][0]
		#console.log m1, m2

		theta = t

	[theta.toArray(), false, maxIterations]

	

[theta, found, totalCount] = calculate true

console.log theta, found, totalCount


