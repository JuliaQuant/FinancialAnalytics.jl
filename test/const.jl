facts("Trivial things are checkable") do

  context("Numbers can be floats") do
      @fact typeof(1.)    => Float64
      @pending typeof(1.) => Float32 
  end

  context("Numbers can be ints") do
      @fact typeof(1) => Int   
  end
end
