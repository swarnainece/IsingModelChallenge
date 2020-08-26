
include("F:\\Julia\\Project\\src\\createArray.jl")
include("F:\\Julia\\Project\\src\\Solution_by_Intersection_Body.jl")


#MonteCarloSweeps = 1
global imageArray = []
arrayType = "positive" # positive, negative, both
#global plt
#ENV["PYTHON"] = "C:\\Users\\swarn\\Anaconda3\\python.exe"
ENV["MPLBACKEND"]="tkagg"

using Pkg
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
#fig = plt.figure()
global rows = 10
global columns = 10
Energy = 0
#temperature = 0 # initialize temperature
#global FinalTemp = 3
MonteCarloSweeps = 1000
global z = 4 #Nearest Neighbour

#global EnergyArray = fill(0, rows, columns)

global arrayCriticalTemp = []
global arrayTemp = []
global arrayMeanEnergy = []
global arrayMeanMagnetizationVsTemp = []
global arrayMeanMagnetization = []
global imageArrayMatrixOriginal = []
global arraySum = []
global arrayThermalAvg = []
global array_tanh = []


global s_values = np.linspace(-1.2, 1.2, 30)

value = "T<Tc" # Possible values "T<Tc", "T>Tc"

# Calling function below
Solution_by_Intersection(value)

plt.axhline(0, color="black")
plt.axvline(0, color="black")
plt.plot(s_values, s_values ,"-.", color="tab:blue", label= "<s>" )
plt.plot(s_values, array_tanh ,"-.", color="tab:orange", label= " \$ tanh(z*J*<s> / K_{B}*T) \$" )
plt.xlabel("<s>")
plt.ylabel("\$ tanh(z*J*<s>/K_{B}*T) \$")
plt.legend()
plt.show()
