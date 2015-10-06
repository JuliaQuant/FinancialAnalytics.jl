function foo{T}(ta::TimeArray{T,1}; prices=false, log_transform=false) 
    #r = keyword_check(ta, prices=prices, log_transform=log_transform)
    r = keyword_check(ta, prices, log_transform)

    sum(r.values)
end

function bar(x)
    mean(x)
end

######## analyze ###################

function analyze(x;funcs=tradestats)
    for i in 1:length(funcs)
        @printf("The value for %s is %f", funcs[i], funcs[i](x)) 
        println("")
    end
end

######## annualized return ###################
### reference Bacon, Carl. Practical Portfolio Performance Measurement and Attribution. Wiley. 2004. p. 25

### @doc """
### # Annualized Returns
###  
### # Keyword Argument defaults
###       prices = false
###       log_transform = false
###       method = "arithmetic" ("geometric" supported) 
###       period = 252 (for daily)
### 
### # Details
### 
### # References
###   Bacon, Carl. Practical Portfolio Performance Measurement and Attribution. Wiley. 2004. p. 25
### """ ->

function annualized_return{T}(ta::TimeArray{T,1}; prices=false, log_transform=false, method="arithmetic", periods=252) 
    r = keyword_check(ta, prices, log_transform)
    n = length(r)
    method == "arithmetic" ? (periods/n) * sum(r.values) :
    method == "geometric" ? prod(1+r.values) ^ (periods/n) - 1 :
    error("only arithmetic and geometric methods supported")
end

######## equity curve ########################

function equity{T}(ta::TimeArray{T,1}; prices=false)
    prices ?
    TimeArray(ta.timestamp, [1.0, expm1(cumsum(diff(log(ta.values)))) + 1], ["equity"]) :
    TimeArray(ta.timestamp, [expm1(cumsum(ta.values)) + 1], ["equity"])
end

######## from the oldmatrix.jl

# I think this might be incorrect
# it claims to be correct by treating the µ vector as a scalar for single vector case
#function ∑matrix(x::Vector)
function sigma(x::Vector)
    y = x * mean(x)
    y * y'
end

function Shapiro_Wilks{T<:Float64}(x::Vector{T})
    sx = sort(x)
    d = Truncated(Normal(mean(xs),1),minimum(xs), maximum(xs))
    m = sort(rand(d, length(x)))
    #V = ∑matrix(sx)
    V = sigma(sx)
    a = m' * inv(V) / sqrt(m' * inv(V) * inv(V) * m)
    y - x.-mean(x)

    # ∑ ai * xi and then ^ 2
    # so a cross product and then square it
    # a'x ^ 2
    num = a'x ^ 2

    # ∑ (xi - xbar)  ^ 2
    # so first get y = xi - xbar vector
    # y'y
    den = y'y
    num/den
end

######## from the matrix.jl

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

## _____ Shapiro Wilk fortran code___________________

######===========     Perform the Shapiro-Wilk test for normality.
######=========== 
######===========     The Shapiro-Wilk test tests the null hypothesis that the
######===========     data was drawn from a normal distribution.
######=========== 
######===========     Parameters
######===========     ----------
######===========     x : array_like
######===========         Array of sample data.
######===========     a : array_like, optional
######===========         Array of internal parameters used in the calculation.  If these
######===========         are not given, they will be computed internally.  If x has length
######===========         n, then a must have length n/2.
######===========     reta : bool, optional
######===========         Whether or not to return the internally computed a values.  The
######===========         default is False.
######=========== 
######===========     Returns
######===========     -------
######===========     W : float
######===========         The test statistic.
######===========     p-value : float
######===========         The p-value for the hypothesis test.
######===========     a : array_like, optional
######===========         If `reta` is True, then these are the internally computed "a"
######===========         values that may be passed into this function on future calls.
######=========== 
######===========     """
######===========     N = len(x)
######===========     if N < 3:
######===========         raise ValueError("Data must be at least length 3.")
######===========     if a is None:
######===========         a = zeros(N,'f')
######===========         init = 0
######===========     else:
######===========         if len(a) != N//2:
######===========             raise ValueError("len(a) must equal len(x)/2")
######===========         init = 1
######===========     y = sort(x)
######===========     a, w, pw, ifault = statlib.swilk(y, a[:N//2], init)
######===========     if ifault not in [0,2]:
######===========         warnings.warn(str(ifault))
######===========     if N > 5000:
######===========         warnings.warn("p-value may not be accurate for N > 5000.")
######===========     if reta:
######===========         return w, pw, a
######===========     else:
######===========         return w, pw

function swilk(x::Vector{Float64})

    fstats = dlopen(Pkg.dir("FinanceAnalytics//bin/swilk"))
    swilk_ = dlsym(fstats, :swilk_)

        #     SUBROUTINE SWILK (INIT, X, N, N1 , N2, A, W, PW, IFAULT)
        #     .. Scalar Arguments ..
        #      REAL               W, PW
        #      INTEGER            N, N1, N2, IFAULT
        #      LOGIC              INIT
        #     .. Array Arguments ..
        #      REAL               X(*), A(*)

    y      = sort(x)
    init   = false  # scipy default
    n      = length(y)  # needs some error checking for bounds
    n1     = 1   # this is a w.a.g. ~ changing this to 0 gets same ridiculous result
    n2     = ifloor(n/2) # scipy uses n//2
    w      = 0.0
    pw     = 1.0  # another w.a.g.
    ifault = 0
    a      = zeros(Float64, n2)

    ccall(swilk_, 
          Float64, 
          (Ptr{Bool}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}),
          &init, y, &n, &n1, &n2, a, &w, &pw, &ifault)
end



## _____ toy example below ___________________

function greet(n::Int)
    #greets   = dlopen(Pkg.dir("FinanceStats/bin/greetings"))
    greets   = dlopen("../bin/greetings")
    hello_   = dlsym(greets,:hello_)
    goodbye_ = dlsym(greets,:goodbye_)
    iseven(n)?
    ccall(hello_,Void,()) :
    ccall(goodbye_,Void,())
end

# function greet(n::Int)

#     # greets   = dlopen("../bin/greetings")
#     greets   = dlopen(Pkg.dir("FinanceStats/bin/greetings"))
# #    greets   = Pkg.dir("FinanceStats/bin/greetings")
# #    const greets   = "../bin/greetings"
#     hello_   = dlsym(greets,:hello_)
#     goodbye_ = dlsym(greets,:goodbye_)
#     iseven(n)?
# #    ccall((:hello_, greets) ,Void,()) :
# #    ccall((:goodbye_, greets),Void,())
#     ccall((:hello, greets) ,Void,()) :
#     ccall((:goodbye, greets),Void,())
# #    ccall((:hello_, "../bin/greetings") ,Void,()) :
# #    ccall((:goodbye_, greets),Void,())
# end


## _____ this works ___________________

### function greet(n::Int)
###     greets   = dlopen(Pkg.dir("FinanceStats/bin/greetings"))
###     hello_   = dlsym(greets,:hello_)
###     goodbye_ = dlsym(greets,:goodbye_)
###     iseven(n)?
###     ccall(hello_,Void,()) :
###     ccall(goodbye_,Void,())
### end
