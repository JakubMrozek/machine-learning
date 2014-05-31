###
Based on http://freedelta.free.fr/r/php-code-samples/artificial-intelligence-neural-network-backpropagation/
###



class BackPropagation


    constructor: (@numLayers, @layersSize, @beta, @alpha) ->
        @weight = {}
        @prevDwt = {}
        @output = {}
        @delta = {}

        @output[l] = {} for l in [0...@layersSize.length]
        @delta[l] = {} for l in [1...@layersSize.length]

        @initWeights()
        @initPrevWeights()



    initWeights: ->
        for i in [1...@layersSize.length]
            @weight[i] = {}
            for j in [0...@layersSize[i]]
                @weight[i][j] = {}
                for k in [0..@layersSize[i-1]]
                    @weight[i][j][k] = Math.random()
                @weight[i][j][@layersSize[i-1]] = -1



    initPrevWeights: ->
        for i in [1...@layersSize.length]
            @prevDwt[i] = {}
            for j in [0...@layersSize[i]]
                @prevDwt[i][j] = {}
                for k in [0..@layersSize[i-1]]
                    @prevDwt[i][j][k] = 0




    sigmoid: (inputSource) ->
        1/(1 + Math.exp(-inputSource))



    ###
        Propocet rozdilu mezi nami vypocitanou hodnotou hypotezy a skutecnou hodnotou (y)
    ###
    mse: (target) ->
        mse = 0
        for key, result of @output[@numLayers-1]
            mse += (target - result) * (target - result) 
        mse / 2



    ffwd: (inputSource) ->

        # assign content to input layer
        for i in [0...@layersSize[0]]
            @output[0][i] = inputSource[i]


        # assign output (activation) value to each neuron usng sigmoid func
        for i in [1...@layersSize.length]
            for j in [0...@layersSize[i]]
                sum = 0
                for k in [0...@layersSize[i-1]]
                    sum += @output[i-1][k] * @weight[i][j][k]
                sum += @weight[i][j][@layersSize[i - 1]]
                @output[i][j] = @sigmoid sum




    bpgt: (inputSource, target) ->
        @ffwd inputSource

        # delta for output value
        for i in [0...@layersSize[@numLayers - 1]]
            a = @output[@numLayers - 1][i]
            @delta[@numLayers - 1][i] = a * (1 - a) * (target - a)
            # @delta[@numLayers - 1][i] = a-target


        # delta for hidden layers
        for i in [(@numLayers - 2)...0]
            for j in [0...@layersSize[i]]
                sum = 0
                for k in [0...@layersSize[i+1]]
                    sum += @delta[i+1][k] * @weight[i+1][k][j]
                @delta[i][j] = @output[i][j] * (1 - @output[i][j]) * sum


        # monumentum
        for i in [1...@numLayers]
            for j in [0...@layersSize[i]] 
                for k in [0...@layersSize[i-1]]
                    @weight[i][j][k] += @alpha * @prevDwt[i][j][k]
                @weight[i][j][@layersSize[i-1]] += @alpha * @prevDwt[i][j][@layersSize[i-1]]



        # gradient descent
        for i in [1...@layersSize.length]
            for j in [0...@layersSize[i]]
                for k in [0...@layersSize[i-1]]
                    @prevDwt[i][j][k] = @beta * @delta[i][j] * @output[i-1][k]
                    @weight[i][j][k] += @prevDwt[i][j][k] 

                @prevDwt[i][j][@layersSize[i-1]] = @beta * @delta[i][j] 
                @weight[i][j][@layersSize[i-1]] += @prevDwt[i][j][@layersSize[i-1]]
            



    run: (data) ->
        thresh =  0.0001
        numEpoch = 1
        numPattern = Object.keys(data).length
        numInput = data[0].length
        mse = 0

        for e in [0...numEpoch]
            key = e % numPattern
            @bpgt data[key], data[key][numInput-1]

            mse = @mse data[key][numInput-1]

            if mse < thresh
                console.log "Network Trained. Threshold value achieved in #{e} iterations."
                console.log "MSE: #{MSE}."




trainingSet = 
    0: [0, 0, 0, 0]
    1: [0, 0, 1, 1]
    2: [0, 1, 0, 1]
    3: [0, 1, 1, 0]
    4: [1, 0, 0, 1]
    5: [1, 0, 1, 0]
    6: [1, 1, 0, 0]
    7: [1, 1, 1, 1]




bp = new BackPropagation 4, [3, 3, 3, 1], 0.3, 0.1
bp.run trainingSet

