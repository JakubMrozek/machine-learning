# training set
set = [
	[ 0, 4 ]
	[ 1, 7 ]
	[ 2, 7 ]
	[ 3, 8 ] 
]


# learning rate
alpha = 0.39


# number of examples
m = set.length


# initial value of theta0
initialTheta0 = 3


# initial value of theta1
initialTheta1 = 5


# max iterations of algoritm
maxIterations = 2000





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
	theta0 - alpha * (1/m) * suma0(theta0, theta1)


costFn1 = (theta0, theta1) ->
	theta1 - alpha * (1/m) * suma1(theta0, theta1)	


calculate = (theta0, theta1, count = 1) ->
	if count is maxIterations
		return [theta0, theta1, false, count]
	t0 = costFn0 theta0, theta1
	t1 = costFn1 theta0, theta1
	++count
	if t0 is theta0 and t1 is theta1
		return [t0, t1, true, count]
	else 
		return calculate t0, t1, count




# find best result!
[theta0, theta1, found, totalCount] = calculate initialTheta0, initialTheta1


console.log theta0, theta1, found, totalCount