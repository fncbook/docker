# syntax=docker/dockerfile:1
FROM julia:1.7.2
WORKDIR /root/build

COPY *.jl ./

# install gcc to build sysimage
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y install g++

# Install and build julia packages
RUN julia make_image.jl

# This causes MKL to be downloaded into the image.
RUN julia -Jjulia_fast.so -e "using FundamentalsNumericalComputation"

CMD julia -i --project=@. -J/root/build/julia_fast.so --color=yes /root/.julia/packages/IJulia/$(ls /root/.julia/packages/IJulia/)/src/kernel.jl $DOCKERNEL_CONNECTION_FILE
