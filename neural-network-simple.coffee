###
  http://www.jens.cz/neuronova-sit-backpropagation-v-php/
###

class BackPropagation


    constructor: (@alpha) ->
        @reset()



    reset: ->
        @weight = {}
        @deltaBig = {}
        @initWeights()
        @initDeltaBig()



    initWeights: ->
        for i in [1..3]
            @weight[i] = {}
            for j in [1..3]
                @weight[i][j] = Math.random()



    initDeltaBig: ->
        for i in [1..3]
            @deltaBig[i] = {}
            for j in [1..3]
                @deltaBig[i][j] = 0



    sigmoid: (z) ->
        1/(1 + Math.exp(-z))



    ffwd: (x1, x2) ->
        a11 = @sigmoid( 1 * @weight[1][1] + x1  * @weight[2][1] + x2  * @weight[3][1] )
        a12 = @sigmoid( 1 * @weight[1][2] + x1  * @weight[2][2] + x2  * @weight[3][2] )
        a21 = @sigmoid( 1 * @weight[1][3] + a11 * @weight[2][3] + a12 * @weight[3][3] )
        [a11, a12, a21]



    gradientDescent: ->
        for i in [1..3]
            for j in [1..3]
                @weight[j][i] += @alpha * 1/4 * (@deltaBig[j][i])



    calculateDeltaBig: (x1, x2, a11, a12, delta) ->
        @deltaBig[1][1] += 1 * delta[1]
        @deltaBig[2][1] += x1 * delta[1]
        @deltaBig[3][1] += x2 * delta[1]

        @deltaBig[1][2] += 1 * delta[2]
        @deltaBig[2][2] += x1 * delta[2]
        @deltaBig[3][2] += x2 * delta[2]

        @deltaBig[1][3] += 1 * delta[3]
        @deltaBig[2][3] += a11 * delta[3]
        @deltaBig[3][3] += a12 * delta[3]




    train: (x1, x2, y) ->
        [a11, a12, a21] = @ffwd x1, x2

        delta = {}
        delta[3] = a21 * (1 - a21) * (y - a21)
        delta[2] = a12 * (1 - a12) * @weight[3][3] * delta[3]
        delta[1] = a11 * (1 - a11) * @weight[2][3] * delta[3]

        @calculateDeltaBig x1, x2, a11, a12, delta



    run:  (numIteration, acceptableError)->
        A = 1
        B = 0
        C = 0
        D = 1

        for iteration in [1..numIteration]

            @initDeltaBig()

            @train 0, 0, A
            @train 0, 1, B
            @train 1, 0, C
            @train 1, 1, D

            @gradientDescent()

            # realne vystupy
            [i1, i2, a] = @ffwd 0, 0
            [i1, i2, b] = @ffwd 0, 1
            [i1, i2, c] = @ffwd 1, 0
            [i1, i2, d] = @ffwd 1, 1 

            error = ((A-a)*(A-a) + (B-b)*(B-b) + (C-c)*(C-c) + (D-d)*(D-d))

            console.log "#{error} (#{iteration})"


            ###
              Bylo nalezeno lokalni minumum a nikoliv globalni.
              Hodnota error se limitne blizi 0.5
              a globalniho minima nedosahne. 
              Spustime tedy celou funkci znova.
            ###
            if iteration > 20000 and error > 0.5
                @reset()
                return @run numIteration - iteration, acceptableError


            if error < acceptableError
                console.log "\n\nFound in iteration no. #{iteration}.\nWeight: "
                console.log @weight
                console.log "\n"
                console.log "0 XNOR 0 = #{Math.round(a)}, (#{a})"
                console.log "1 XNOR 0 = #{Math.round(b)}, (#{b})"
                console.log "0 XNOR 1 = #{Math.round(c)}, (#{c})"
                console.log "1 XNOR 1 = #{Math.round(d)}, (#{d})"
                console.log "\n\n"
                return



bp = new BackPropagation 0.9
bp.run 100000, 0.01


###
Sample result:

{ '1': 
   { '1': -5.805647805379718,
     '2': -2.470799941068385,
     '3': 3.464946399483564 },
  '2': 
   { '1': 3.788455867878737,
     '2': 5.865349459014997,
     '3': 8.347209454400609 },
  '3': 
   { '1': 3.7882887302874124,
     '2': 5.864539011798432,
     '3': -7.683857183738648 } }
###