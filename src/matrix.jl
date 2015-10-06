using Distributions

# function ∑matrix(x::Vector, y::Vector)
#     z = x .* y
#     z .* z'
# end

function shapiro{T<:Float64}(x::Vector{T})
    s = sort(x)
    d = Truncated(Normal(mean(s),1),minimum(s), maximum(s))
    m = sort(rand(d, length(s)))

    V  = cov(m)
    a1 = m' * inv(V) 
    a2 = sqrt(m' * inv(V) * inv(V) * m)
    a  = a1 ./ a2

    # ∑ ai * si and then ^ 2
    # so a cross product and then square it
    # a's ^ 2
    # num = (a's) ^ 2

    n   = a .* s
    nu  = sum(n) 
    num = nu ^ 2

    # ∑ (xi - xbar)  ^ 2
    # so first get y = xi - xbar vector
    # y'y
    # y = s.-mean(s)
    # den = y'y

    d   = s .- mean(s)
    de  = d .^ 2
    den = sum(de)

    num/den
end
