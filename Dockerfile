# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake clang autoconf automake

## Add source code to the build stage.
ADD . /lzbench
WORKDIR /lzbench
RUN CC=clang CXX=clang++ CFLAGS=fsanitize=address CXXFLAGS=fsanitize=address make -j7


# Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /lzbench/lzbench /lzbench
# 
