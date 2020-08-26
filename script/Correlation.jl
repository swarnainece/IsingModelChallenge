"""
Just Change the temperature value
Temp = 5 # 1.5 , 2, 2.25, 3, 5
And plot in the same figure
"""

path = pwd()

include(path*"\\IsingModelChallenge\\src\\createArray.jl")
include(path*"\\IsingModelChallenge\\src\\IterateEnergyArray.jl")
include(path*"\\IsingModelChallenge\\src\\Correlation_Body.jl")

global imageArray = []
global arrayCorrelation_MC = []
global max_Dist
global avgMCSweep = []
global normalizedConsortedArray = []

arrayType = "positive" # positive, negative, both
ENV["MPLBACKEND"]="tkagg"

using Pkg
using PyCall
using PyPlot
using Random
using Statistics

pygui(true)
plt = pyimport("matplotlib.pyplot")
animation = pyimport("matplotlib.animation")
np = pyimport("numpy")

global rows = 10
global columns = 10
Energy = 0
Temp = 1.5 # 1.5 , 2, 3, 4, 5
#FinalTemp = 1.5
MonteCarloSweeps = 2

imageArray = []

global EnergyArray = fill(0, rows, columns)
global arrayMeanEnergyVsTemp = []


x = createArray(arrayType)

max_Distance = Correlation_Body(x, Temp)
#println("**************************")
#println(length(arrayCorrelation_MC))
#println(arrayCorrelation_MC)
avgOfMonteCarloSweeps(max_Distance)
normalizedArray = normalization()

#*******************Create Graph*************************************
xAxis = np.linspace(1, max_Distance, max_Distance)
plt.plot(xAxis, normalizedArray, "o-", label= "T="*string(Temp))
plt.xlabel("i = Distance")
plt.ylabel("\$ f(i) = <s_{0}*s_{1}> \$")
plt.xlim(0, (rows/2))
plt.ylim(-0.1, 1.1)
plt.title("Ising Model Correlations")
plt.legend()
plt.show()
#*******************Create Graph*************************************
