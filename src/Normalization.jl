
function Normalization(arrayTotalMagnetization)

    for i in arrayTotalMagnetization

        z = (i - minimum(arrayTotalMagnetization))/(maximum(arrayTotalMagnetization) - minimum(arrayTotalMagnetization))
        push!(arrayNormalized, z)
    end
end
