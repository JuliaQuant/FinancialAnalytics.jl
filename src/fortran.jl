## _____ Shapiro Wilk fortran code___________________

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

    #init   = false  # 50% chance this is correct
    init   = true # 50% chance this is correct ~ changing this to 0 gets same ridiculous result
    n      = length(x)
    n1     = 1   # this is a w.a.g. ~ changing this to 0 gets same ridiculous result
    n2     = n/2
    w      = 0.0
    pw     = 1.0  # another w.a.g.
    ifault = 0
    a      = similar(x) # y.a.w.a.g.

    ccall(swilk_, 
          Float64, 
          (Ptr{Bool}, Ptr{Float64}, Ptr{Int32}, Ptr{Int32}, Ptr{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Int32}),
          &init, x, &n, &n1, &n2, a, &w, &pw, &ifault)
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
