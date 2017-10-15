# Docker file to build and run the lightning code.
FROM ubuntu

RUN apt-get update && \
    apt-get upgrade -y 
    
# Install git so code can be cloned from github.
RUN apt-get install -y git-core
# Install the build tools so the code can be built.
RUN apt-get install -y  g++ cmake pkg-config
# Install the libcrypto library which the code relies on.
RUN apt-get install -y libssl-dev

RUN apt-get install -y libboost-all-dev

# Install GNU Multiple Precision Arithmetic Library (GMP).
RUN apt-get install -y libgmp10-dev

# Install library used for accessing process information. 
# My guess is that this is used for gathering entropy....
RUN apt-get install -y libprocps-dev


ADD . /lightening

# Get dependancies and build libsnark.
RUN cd /lightening && sh get-libsnark

# Build the lightening code.
RUN cd /lightening && make

# Run the tests!
CMD ["/lightening/test"]
