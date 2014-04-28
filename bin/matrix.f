c matrix test file
       
      subroutine vec(n,vector)
      
      integer n
      real*8 vector(*)
      write(*,*) (vector(i), i=1,n)
            
      end
              
      subroutine mat(m,n, matrix)
                
      integer m,n
      real*8 matrix(m,n)
      write(*,*) ((matrix(i,j),j=1,n),i=1,m)
                      
      end
                        
      subroutine tten(m,n,o,matrix)
                          
      integer m,n,o
      real*8 matrix(m,n,o)
      write(*,*)  (((matrix(i,j,k),j=1,n),i=1,m),k=1,o)
                                 
      end
