function generateData(x)

    println(x)
    println("***************************")
    for iCount = 1:1
        # Calculate energy and flip the spin
        for row in 1:rows
            for col in 1:columns

                if (row-1) == 0

                    if (col-1) == 0

                        #1,1
                        println(row, "," , col)
                        println(x)

                        Energy = (x[row, columns]*x[row, col] + x[rows, col]*x[row, col] +  x[row, col+1]*x[row, col] + x[row+1, col]*x[row, col] )
                    elseif (col+1) == columns + 1

                        # 1,5
                        println(row, "," , col)
                        println(x)
                        Energy = (x[row, (col-1) ]*x[row, col] + x[rows, col]*x[row, col] + x[row, 1]*x[row, col] + x[row+1, col]*x[row, col] )
                    else

                        # 1,2  ;   1,3   ;   1,4


                        println(row, "," , col)
                        println(x)

                        #Energy1 = (x[row, columns] , "*" , x[row, col] , "+",  x[row-1, col], "*"  ,x[row, col],  "+" , x[row, col+1], "*" , x[row, col], "+" , x[row+1, col],  "*",  x[row, col] )
                        #println(x[row, col] , "::" , x[row, columns],  "::" ,  x[row-1, col],   )
                        #println("swarna:::", Energy1)

                        Energy = (x[row, columns]*x[row, col] + x[rows, col]*x[row, col] + x[row, col+1]*x[row, col] + x[row+1, col]*x[row, col] )
                    end

                elseif (col - 1)  == 0    &&    (row-1) != 0

                    if (row+1) == rows + 1

                        # 5,1
                        println(row, "," , col)
                        println(x)

                        Energy = (x[row, columns]*x[row, col] + x[row-1, col]*x[row, col]  + x[row, col+1]*x[row, col] + x[1, col]*x[row, col] )
                    else

                        # 2,1  ;   3,1    ;    4,1

                        println(row, "," , col)
                        println(x)
                        Energy = (x[row, columns]*x[row, col] + x[row-1, col]*x[row, col]  + x[row, col+1]*x[row, col] + x[row+1, col]*x[row, col] )

                    end

                elseif (row + 1)   == rows + 1  &&    (col - 1) != 0

                    if (col + 1) == columns + 1
                        # 5,5

                        println(row, "," , col)
                        println(x)
                        Energy = (x[row, col-1]*x[row, col] + x[row-1, col]*x[row, col]  + x[row, 1]*x[row, col] + x[1, col]*x[row, col] )
                    else
                        # 5,2  ; 5,3  ;   5,4

                        println(row, "," , col)
                        println(x)
                        Energy = (x[row, col-1]*x[row, col] + x[row-1, col]*x[row, col]  + x[row, col+1]*x[row, col] + x[1, col]*x[row, col] )
                    end

                elseif (col+1)   == columns + 1    &&   (row - 1) != 0   &&   (row + 1) != rows + 1

                    # 2,5 ,   3,5 , 4,5
                    println(row, "," , col)
                    println(x)

                    Energy = (x[row, col-1]*x[row, col] + x[row-1, col]*x[row, col]  + x[row, 1]*x[row, col] + x[row+1, col]*x[row, col] )

                else

                    println(row, "," , col)
                    println(x)
                    Energy = (x[row, col-1]*x[row, col] + x[row-1, col]*x[row, col]  + x[row, col+1]*x[row, col] + x[row+1, col]*x[row, col] )
                end

                println("::")
                EnergyArray[row, col] = Energy
                println(EnergyArray[row, col])

            end
        end
        print(EnergyArray)

        print(":::")
        print(iCount)
        print(":::")
        print("\n")

        image = plt.imshow(x, animated=true)
        push!(imageArray, [image])

    end
    #plt.matshow(x)
    #plt.show()
end
