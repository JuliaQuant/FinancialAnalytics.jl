C   first to compile ... 
      gfortran hello.f -o hello.o - shared -fPIC 

C    and then to call from terminal
      julia> hola  = dlopen(Pkg.dir("FinanceStats/bin/hello.o"))
      Ptr{Void} @0x00007f9d57dd5aa0

      julia> hello_ = dlsym(hola,:hello_)
      Ptr{Void} @0x000000010e18ae00

      julia> ccall(hello_,Void,())
       Hello World!
       
C  the greet method puts two functions into one binary file called
C  "greetings", and not appending it with .o works fine


