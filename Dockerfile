# syntax=docker/dockerfile:1
FROM julia:1.7.2
WORKDIR /root/build
COPY *.jl ./

# Install and build julia packages
RUN julia install_pkgs.jl

# Hack in the new jupyter kernel
RUN mkdir /root/.local/share/jupyter/kernels/julia-FNC
COPY julia-FNC/* /root/.local/share/jupyter/kernels/julia-FNC/
RUN julia install_kernel.jl

# install gcc to build sysimage
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y install g++

RUN julia make_image.jl

RUN julia -Jjulia_fast.so -e "using FundamentalsNumericalComputation"

# disable tokens
COPY jupyter_lab_config.py /root/.jupyter/jupyter_lab_config.py

RUN mkdir /FNC
VOLUME /FNC

WORKDIR /FNC
CMD ["/root/.julia/conda/3/bin/jupyter-lab","--port=8899","--ip=0.0.0.0","--no-browser","--allow-root"]
EXPOSE 8899
