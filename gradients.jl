using TypedPolynomials

# -------- Code Review --------
# Reviewed by Paul Choi

# -----------------------------
# Comments on Paul's Code/Updates to mine
# -----------------------------
# Paul did a great job when writing the gradients.jl file
# his use of a temp variable to use for each term was useful.
# I forgot that one does not always need to create global variables, but can have
# smaller scope variables.
# I made changes based on that and the newly learned ~zip(a, b)~ function.
# The ability to iterate through two vectors at once was useful for the 
# ~partial_derivative~ function. Instead of doing extremely tedious code that
# I had before I could shrink the code down to a few and being one line.
# -----------------------------


# value of the polynomial at a point: returns a number
function evaluate(polynomial, point)
    # total sum of polynomial intialization
    sum = 0
    
    # iterate through the terms
    for i in 1:length(polynomial.terms)
        temp = polynomial.terms[i].coefficient
        # iterate through each point of the input
        # multiplying the temp coefficient by the point to the whatever power
        for j in 1:length(point)
            temp *= point[j]^(polynomial.terms[i].monomial.exponents[j])
        end
        
        # add to total of polynomial
        sum += temp
        
    end
    return sum
end

function partial_derivative(polynomial, variable)
    # create a new polynomial
    new_polynomial = 0
    
    # iterate through the terms of polynomial
    for i in 1:length(polynomial.terms)
        # reset
        temp = polynomial.terms[i].coefficient
        
        # goes through the variables and the exponent arrays
        # checks to see if the variables matches the variables of polynomial
        # this is done to perform the derivative with respect to
        for (v,e) in zip(variables(polynomial), polynomial.terms[i].monomial.exponents)
            if v == variable
                temp *= e              # derivative step - multiply coefficient by exponent (e)
                temp *= (v)^(e-1)      # subtract one from exponent
            else
                temp *= (v)^(e)        # maintain term when variable not present that is being derived
            end
        end
        
        # add the term to the polynomial
        new_polynomial += temp
        
    end
    return new_polynomial
end

# symbolic gradient of a polynomial: returns a vector of polynomials
function symbolic_gradient(polynomial)
    # create an array of undefined polynomials the size of the variables
    vector_polynomials = Array{Polynomial}(undef, length(variables(polynomial)),)
    
    # iterate through all the variables, find the partial derivative, and update the vector
    for i in 1:length(variables(polynomial))
        vector_polynomials[i] = partial_derivative(polynomial, variables(polynomial)[i])
    end
    return vector_polynomials
end