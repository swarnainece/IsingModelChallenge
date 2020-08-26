
ENV["MPLBACKEND"]="tkagg"
using Pkg
using Calculus
using PyCall
using PyPlot
using Random
using Statistics

pygui(true)
plt = pyimport("matplotlib.pyplot")
animation = pyimport("matplotlib.animation")
np = pyimport("numpy")
fig = plt.figure()
arrayTemp = []
arrayOutput = []

function Newto_Raphson(temperature)

    input = 1
    output = 0
    Ans = tanh(4*input/temperature)
    println("*************")
    println("Ans =", Ans)
    push!(arrayOutput , Ans)
    push!(arrayTemp, temperature)
    temperature = temperature + 0.1

    while  temperature <= 8

        #println("Ans =", Ans)
        # The below line is correct
        #output  =  Ans -  ( (Ans - tanh(4*Ans/temperature)) /  (1 - (derivative(tanh, (4*Ans/temperature))*(4/temperature)  )   ) )      # Ans - ( tanh(4*Ans/temperature)   /  derivative(tanh, (4*Ans/temperature))  )

        # The below line is correct   #As, d/dx (tanhx) = sech^{2}x
        sq_val =  sech(4*Ans/temperature)*sech(4*Ans/temperature)
        output  =  Ans -  ( (Ans - tanh(4*Ans/temperature)) /  ( 1 - sq_val*(4/temperature)))  #
        #println("output =",output)
        Ans = output
        push!(arrayOutput, output)
        push!(arrayTemp, temperature)
        temperature += 0.1
    end
end

#Function Call
temperature = 0
Newto_Raphson(temperature)

plot(arrayTemp, arrayOutput, "r-o")
ylim(-0.05, 1.1)
xlabel("Temperature")
ylabel("Magnetization")
