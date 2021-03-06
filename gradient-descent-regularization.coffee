###
Linear regression with gradient descent - simple implementation.

###


# training set
set = [
	[ 0, 4 ]
	[ 1, 7 ]
	[ 2, 7 ]
	[ 3, 8 ] 
]


# learning rate
alpha = 0.01


# number of examples
m = set.length


# initial value of theta0
initialTheta0 = 3


# initial value of theta1
initialTheta1 = 50


# max iterations of algoritm
maxIterations = 20000


lambda = 100


hypothesis = (x, theta0, theta1) ->
	theta0 + theta1 * x


suma0 = (theta0, theta1) ->
	result = 0
	for [x, y] in set
		result += hypothesis(x, theta0, theta1) - y
	result


suma1 = (theta0, theta1) ->
	result = 0
	for [x, y] in set
		result += (hypothesis(x, theta0, theta1) - y) * x
	result



costFn0 = (theta0, theta1) ->
	theta0 - alpha * ( (1/m) * suma0(theta0, theta1) + lambda/m * theta1 )


costFn1 = (theta0, theta1) ->
	theta0 - alpha * ( (1/m) * suma1(theta0, theta1) + lambda/m * theta1 )


calculate = (debug = false)->
	theta0 = initialTheta0
	theta1 = initialTheta1

	for i in [0...maxIterations]
		if debug then console.log theta0, theta1
		t0 = costFn0 theta0, theta1
		t1 = costFn1 theta0, theta1
		if t0 is theta0 and t1 is theta1
			return [t0, t1, true, i + 1]
		theta0 = t0
		theta1 = t1

	[theta0, theta1, false, maxIterations]




# find best result!
[theta0, theta1, found, totalCount] = calculate true


console.log theta0, theta1, found, totalCount