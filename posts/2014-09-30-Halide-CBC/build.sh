ln -s /home/nushio/hub/Halide .
g++  cbc.cpp -O2 -I ./Halide/include -L ./Halide/bin -lHalide -o cbc.out
export LD_LIBRARY_PATH=./Halide/bin
