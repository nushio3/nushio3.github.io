#include <Halide.h>
#include <stdio.h>

const int NX=4, NY=4;

int main(int argc, char **argv) {
  Halide::Var x, y;
  Halide::Func initial_condition;
  
  initial_condition(x,y) = x+4*y+97;
  

  Halide::Image<int32_t> input = initial_condition.realize(NX,NY);
  //Halide::Func extended = Halide::BoundaryConditions::repeat_image(input);
  Halide::Func extended = Halide::BoundaryConditions::mirror_image(input);
  //Halide::Func extended = Halide::BoundaryConditions::repeat_edge(input);
  Halide::Func extended_shifted;
  extended_shifted(x,y) = extended(x-2*NX,y-2*NY);
  Halide::Image<int32_t> output = extended_shifted.realize(5*NX,5*NY);

  for (int j=0;j<5*NY;++j) {
    for (int i=0;i<5*NX;++i) {
      printf("%c ",char(output(i,j)));
    }
    printf("\n");
  }
}
