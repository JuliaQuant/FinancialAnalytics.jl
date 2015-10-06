function keyword_check{T}(ta::TimeArray{T,1}, prices::Bool, log_transform::Bool) 
    if prices == false && log_transform == false # simple returns
        return ta
    elseif prices == false && log_transform == true # log returns
        return basecall(ta,expm1)
    elseif prices == true && log_transform == false # regular prices
        return percentchange(ta)
    elseif prices == true && log_transform == true # log prices
        return percentchange(basecall(ta,exp))
    else
        error("invalid keyword argument")
    end
end

