C  the toy example code for helloworld is as follows:

      PRINT *, "Hello World!"
      END

C  from commandline then we get default a.out, which should be
C  executable
C   $ gfortran helloworld.f 

C  of course you can pass a name to replace a.out
C   $ gfortran helloworld.f -o hi

C   and now to pass to Julia, the greetings.f file includes two
C   subroutines that need to be called with an underscore after the
C   name, which appears to be a Fortran syntax

C   first to compile ... 
      gfortran hello.f -o hello - shared -fPIC 

C    and then to call from terminal
      julia> hola  = dlopen(Pkg.dir("FinanceStats/bin/hello"))
      Ptr{Void} @0x00007f9d57dd5aa0

      julia> hello_ = dlsym(hola,:hello_)
      Ptr{Void} @0x000000010e18ae00

      julia> ccall(hello_,Void,())
       Hello World!
       
C  the greet method puts two functions into one binary file called
C  "greetings"

       


