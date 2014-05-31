###
@weight = 
    1:
        1: -30
        2: 10
        3: -10
    2: 
        1: 20
        2: -20
        3: 20
    3:
        1: 20
        2: -20
        3: 20
###



class BackPropagation


    constructor: (@alpha) ->
        # w [ sloupec ] [ vrstva ]
        @weight = {}
        @initWeights()



    initWeights: ->
        for i in [1..3]
            @weight[i] = {}
            for j in [1..3]
                @weight[i][j] = Math.random()



    sigmoid: (z) ->
        1/(1 + Math.exp(-z))



    ffwd: (x1, x2) ->
        a11 = @sigmoid( 1 * @weight[1][1] + x1  * @weight[2][1] + x2  * @weight[3][1] )
        a12 = @sigmoid( 1 * @weight[1][2] + x1  * @weight[2][2] + x2  * @weight[3][2] )
        a21 = @sigmoid( 1 * @weight[1][3] + a11 * @weight[2][3] + a12 * @weight[3][3] )
        [a11, a12, a21]



    train: (x1, x2, y) ->
        [a11, a12, a21] = @ffwd x1, x2

        delta = {}

        delta[3] = a21 * (1 - a21) * (y - a21)
        delta[2] = a12 * (1 - a12) * @weight[3][3] * delta[3]
        delta[1] = a11 * (1 - a11) * @weight[2][3] * delta[3]


        for i in [1..3]
            if i is 3
                v1 = a11
                v2 = a12
            else
                v1 = x1
                v2 = x2

            @weight[1][i] += @alpha * 1 * delta[i]
            @weight[2][i] += @alpha * v1 * delta[i]
            @weight[3][i] += @alpha * v2 * delta[i]
        


    run:  (numIteration, acceptableError)->
        A = 1
        B = 0
        C = 0
        D = 1

        for iteration in [1..numIteration]
            @train 0, 0, A
            @train 0, 1, B
            @train 1, 0, C
            @train 1, 1, D

            # realne vystupy
            [i1, i2, a] = @ffwd 0, 0
            [i1, i2, b] = @ffwd 0, 1
            [i1, i2, c] = @ffwd 1, 0
            [i1, i2, d] = @ffwd 1, 1 

            error = ((A-a)*(A-a) + (B-b)*(B-b) + (C-c)*(C-c) + (D-d)*(D-d))

            console.log error

            if error < acceptableError
                console.log "Found in iteration no. #{iteration}."
                console.log @weight
                return


bp = new BackPropagation 0.08
bp.run 100000, 0.001


console.log 