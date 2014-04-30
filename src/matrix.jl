function ∑matrix(x::Vector, y::Vector)
    z = x .* y
    z .* z'
end

function shapiro{T<:Float64}(x::Vector{T})
    sx = sort(x)
    # d = Truncated(Normal(mean(xs),1),minimum(xs), maximum(xs))
    # m = sort(rand(d, length(x)))

    V = ∑matrix(sx)
    # a = m' * inv(V) / sqrt(m' * inv(V) * inv(V) * m)

    # ∑ ai * xi and then ^ 2
    # so a cross product and then square it
    # a'x ^ 2

    num = a'x ^ 2

    # ∑ (xi - xbar)  ^ 2
    # so first get y = xi - xbar vector
    # y'y

    y - x.-mean(x)
    den = y'y

    num/den
end
