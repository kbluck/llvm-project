# Temporary: lld 18.1.6 is currently only on the edge repo.
# latest 3.20 only has lld 17.0.6
FROM alpine:edge AS alpine-base

# Install build dependency packages. Do everything all at once
# to bust Docker caching, so you actually get the latest.
RUN apk update                 \
 && apk upgrade --no-cache --no-interactive --no-progress --latest \
 && apk add --no-cache --no-interactive --no-progress --latest     \
        ccache                 \
        clang18                \
        clang18-extra-tools    \
        cmake                  \
        git                    \
        libedit-dev            \
        libffi-dev             \
        libxml2-dev            \
        linux-headers          \
        lld                    \
        llvm18                 \
        llvm18-test-utils      \
        openssh-client-default \
        perl                   \
        procps-ng              \
        python3                \
        py3-pygments           \
        py3-yaml               \
        samurai                \
        sudo                   \
        z3-dev                 \
        zip                    \
        zlib-dev               \
;
#        ocaml-findlib          \
#        ocaml-ctypes           \ package currently broken

# Replace GNU linker with LLVM's ld.lld
RUN rm /usr/bin/ld && ln -s /usr/bin/ld.lld /usr/bin/ld

# CMake can't find FileCheck unless it's in the bin path
RUN ln -s /usr/lib/llvm18/bin/FileCheck /usr/bin/FileCheck

# Set compiler envvars to LLVM tools
ENV ASM=clang-18
ENV CC=clang-18
ENV CXX=clang++-18
ENV NINJA_STATUS="[%f/%t] "

# Create the user 'coder' with sudo access
ARG USERNAME=coder
ARG USER_UID=1001
ARG USER_GID=$USER_UID
RUN addgroup -g $USER_GID $USERNAME \
 && adduser -u $USER_UID -G $USERNAME -D $USERNAME \
 && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
 && chmod 0440 /etc/sudoers.d/$USERNAME \
;


# cd ~/code/llvm-builder
# docker build -t llvm-builder .
# docker run -it --mount type=bind,source=/Users/kbluck/code/llvm-project,target=/llvm-project llvm-builder:latest
# rm -rf /llvm-project/build && mkdir -p /llvm-project/build
# cmake -S /llvm-project/llvm -B /llvm-project/build --preset=debug
# cmake --build /llvm-project/build

# Projects
# bolt Post-link optimizer. Only works on x86_64 and AArch64
# flang Fortran, no thanks.
# libclc For the OpenCL language
# mlir A different IR representation
# openmp
# polly Some kind of polyhedral optimization scheme
# pstl

# Runtimes
# openmp mostly deals with thread parallelism optimizations
# pstl is a parallelized version of libStdC++, again requiring threads
# llvm-libgcc is really for package managers to resolve dependencies on libgcc to libunwind instead
