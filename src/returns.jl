######## annualized return ###################

# returns a single value in simple terms
function annualized_return{T}(ta::TimeArray{T,1})
    exp(sum(diff(log(ta.values)))) ^ (252/length(ta)) - 1 
end

function annualized_return(fa::Array{Float64, 1})
    exp(sum(diff(log(fa)))) ^ (252/size(fa,1)) - 1 
end

######## equity curve ########################

function equity{T}(ta::TimeArray{T,1}; prices=false)
    prices ?
    TimeArray(ta.timestamp, [1.0, expm1(cumsum(diff(log(ta.values)))) + 1], ["equity"]) :
    TimeArray(ta.timestamp, [expm1(cumsum(ta.values)) + 1], ["equity"])
end
