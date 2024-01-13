# -------- Code Review --------
# Reviewed by Paul Choi

# -----------------------------
# Comments on Paul's Code/Updates to mine
# -----------------------------
# Paul and I had the same code for matrices.jl
# However, he used the push! function, and I did not know that
# existed. Instead of creating an empty matrix and push!, I 
# intiailized an array of the specific size because that is known,
# and set the values to undef. I also decided to change my
# loop variables to row, col vs i, j. Paul did that, and
# it made the code much easier to understand.
# -----------------------------


# dot product of two vectors: returns a number
# throws an exception if the vector are of different size
function dot_product(vec1::Array{<:Real, 1}, vec2::Array{<:Real, 1})
    # throws an exception if vector are different sizes
    @assert size(vec1) == size(vec2)
    product = 0
    
    # runs through vectors and adds products
    for row in 1:size(vec1)[1]
        product += vec1[row] * vec2[row]
    end
    return product
end

# matrix-vector product: returns a vector
# size of the returned vector equals the size of the matrix's first dimension
# throws an exception if the matrix's second dimension is a different size
# than the vector
function multiply(mat::Array{<:Real, 2}, vec::Array{<:Real, 1})
    # throws an exception if the matrix's second dimension is different size
    # than the vector
    @assert size(mat)[2] == size(vec)[1]
    
    # creates a vector of the size 
    product_vector = Array{Float64}(undef, size(mat)[1],)
    
    # runs through each row of matrix and uses dot product as helper function
    for row in 1:size(mat)[1]
        product_vector[row] = dot_product(mat[row, :], vec)
    end
    return product_vector
end

# matrix-matrix product: returns a matrix
# size of the returned matrix equals size(mat1,1) X size(mat2,2)
# throws an exception if the mat1's second dimension is a different size
# than mat2's first dimension
function multiply(mat1::Array{<:Real, 2}, mat2::Array{<:Real, 2})
    # throws an exception if the mat1's second dimension is a different size
    # than mat2's first dimension
    @assert size(mat1)[2] == size(mat2)[1]
    # creates a matrix of size of rows (mat1) and columns (mat2)
    product_matrix = Array{Float64}(undef, size(mat1)[1], size(mat2)[2])
    # iterates through the product matrix
    for col in 1:size(mat2)[2]
        # product_matrix[:,i] is the column of the matrix because multiply
        # returns a vector. Multiply the mat1 by the mat2 vectors
        product_matrix[:, col] = multiply(mat1, mat2[:,col])
    end
    return product_matrix
end

# p-norm of a vector: returns a number
# 1-norm of (a - b) is Manhattan distance
# 2-norm of (a - b) is Euclidean distance
function p_norm(vec::Array{<:Real}, p::Real=2) #don't need to specify p meaning: take absolute value always
    # finding the sum of the array
    sum = 0
    # each element of vector to the Pth power
    for num in vec
        sum += abs(num)^abs(p)
    end
 
    # norm formula to the pth root
    return sum^(1/abs(p))
end
