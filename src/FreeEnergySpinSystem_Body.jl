
function FreeEnergySpinSystem(temp)

    J = 1/temp
    array_Elements = []

    for iCount = 1:length(s_values)

        s = sqrt(z*J)*tanh(sqrt(z*J)*s_values[iCount])        #sqrt(z*J)*
        f_s = (-1/z)*(s^z) + log(cosh(s*((z*J)^(1/z)))) # -(1/2)*s^2 +

        """  Another method
        #f_s = exp(-(s^z)/z)*cosh(s*sqrt(2*J))
        #f_s = f_s - 1  """

        push!(array_Elements, f_s)
    end

    if temp < 2

        array_Elements = array_Elements*(-1)
        return array_Elements

    else

        return array_Elements
    end
end
