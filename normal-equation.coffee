###
Linear regression with normal equation

###

math = require('mathjs')()


# training set
set = [
	[[0, 1], 2]
	[[1, 5], 4]
	[[2, 6], 6]
	[[4, 9], 8] 
]


#  [ 1, 0, 4 ], [ 1, 1, 7 ], [ 1, 2, 7 ], [ 1, 3, 8 ]
createX = ->
	matrix = (ex[0] for ex in set) 
	# x0 = 1
	row.unshift 1 for row in matrix
	math.matrix matrix


# [2], [4], [6], [8]
createY = ->
	math.matrix ([ex[1]] for ex in set)





calculate = (debug = false)->
	x = createX()
	y = createY()
	xTransposed = math.transpose x

	a = math.multiply xTransposed, x
	b = math.inv a
	c = math.multiply b, xTransposed
	theta = math.multiply c, y
	theta.toArray()

	

theta = calculate()

console.log theta