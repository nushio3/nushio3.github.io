---
title: Boundary conditions in Halide
author: Takayuki Muranushi
tags: Halide, Programming Tips, Stencil Computations, HPC, Automated Tuning
---

Zalman Stern has been working on boundary-condition, and the support has been in Halide main branch for a while. 

- [Zalman's post](https://lists.csail.mit.edu/pipermail/halide-dev/2014-June/000887.html)
- [My response](https://lists.csail.mit.edu/pipermail/halide-dev/2014-June/000902.html)

Now is the time for testing! The following code

``` cpp
#include <Halide.h>
#include <stdio.h>

const int NX=4, NY=4;

int main(int argc, char **argv) {
  Halide::Var x, y;
  Halide::Func initial_condition;
  
  initial_condition(x,y) = x+4*y+97;
  

  Halide::Image<int32_t> input = initial_condition.realize(NX,NY);
  Halide::Func extended = Halide::BoundaryConditions::mirror_image(input);
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
```

produces the following output.

```
a b c d d c b a a b c d d c b a a b c d 
e f g h h g f e e f g h h g f e e f g h 
i j k l l k j i i j k l l k j i i j k l 
m n o p p o n m m n o p p o n m m n o p 
m n o p p o n m m n o p p o n m m n o p 
i j k l l k j i i j k l l k j i i j k l 
e f g h h g f e e f g h h g f e e f g h 
a b c d d c b a a b c d d c b a a b c d 
a b c d d c b a a b c d d c b a a b c d 
e f g h h g f e e f g h h g f e e f g h 
i j k l l k j i i j k l l k j i i j k l 
m n o p p o n m m n o p p o n m m n o p 
m n o p p o n m m n o p p o n m m n o p 
i j k l l k j i i j k l l k j i i j k l 
e f g h h g f e e f g h h g f e e f g h 
a b c d d c b a a b c d d c b a a b c d 
a b c d d c b a a b c d d c b a a b c d 
e f g h h g f e e f g h h g f e e f g h 
i j k l l k j i i j k l l k j i i j k l 
m n o p p o n m m n o p p o n m m n o p 
```

According to [the documentation on Halide's boundary condition](http://halide-lang.org/docs/_boundary_conditions_8h.html),
Halide supports following boundary conditions at the moment of writing: `constant_exterior`, `repeat_edge`, `repeat_image`, `mirror_image`, `mirror_interior`. We can guess what they do from the names.



