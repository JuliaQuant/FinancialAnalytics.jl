function greet(n::Int)
    # greets   = dlopen("../bin/greetings")
    greets   = dlopen(Pkg.dir("FinanceStats/bin/greetings"))
    hello_   = dlsym(greets,:hello_)
    goodbye_ = dlsym(greets,:goodbye_)
    iseven(n)?
    ccall(hello_,Void,()) :
    ccall(goodbye_,Void,())
end
