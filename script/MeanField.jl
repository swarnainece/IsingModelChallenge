
ENV["MPLBACKEND"]="tkagg"

using Pkg
using Calculus
#Pkg.add("DataFrames")
#Pkg.add("ImageMagick")
#Pkg.add("Statistics")
using PyCall
using PyPlot
using Random
using Statistics

pygui(true)
plt = pyimport("matplotlib.pyplot")
animation = pyimport("matplotlib.animation")
np = pyimport("numpy")
#plt.ion()
fig = plt.figure()
ax = fig.add_subplot(111)
fig.subplots_adjust(top=0.85)

props = Dict("facecolor"=>"white", "alpha"=>0.5)



arrayTemp = []
arrayOutput = []

"""
for x = 1:5

    y = derivative(sin, x)
    println(y)
end """


function test(temperature)

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
        output  =  Ans -  ( (Ans - tanh(4*Ans/temperature)) /  (1 - (derivative(tanh, (4*Ans/temperature))*(4/temperature)  )   ) )      # Ans - ( tanh(4*Ans/temperature)   /  derivative(tanh, (4*Ans/temperature))  )
        #println("output =",output)
        Ans = output
        push!(arrayOutput, output)
        push!(arrayTemp, temperature)
        temperature += 0.1
    end
end

temperature = 0
test(temperature)

#println(arrayOutput)
plot(arrayTemp, arrayOutput, "r-o")
ylim(-0.05, 1.1)
xlabel("Temperature")
ylabel("Magnetization")

props = Dict("facecolor"=>"white", "alpha"=>0.5)
#ax.text(3, 8, "boxed italics text in data coords", style="italic", transform=ax.transAxes, fontsize=7, bbox=props)
