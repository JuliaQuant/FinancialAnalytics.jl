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

    fstats = dlopen(Pkg.dir("FinanceStats//bin/swilk"))
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
