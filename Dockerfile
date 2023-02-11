FROM ubuntu:22.04

WORKDIR /
RUN apt update
RUN apt upgrade -y
RUN apt install -y wget curl automake autoconf autopoint build-essential cmake gcc git intltool libtool libtool-bin m4 make meson nasm ninja-build patch pkg-config tar zlib1g-dev clang libssl-dev
RUN mkdir toolchains
WORKDIR toolchains
RUN wget https://github.com/bradleysepos/mingw-w64-build/releases/download/9.2.0/mingw-w64-toolchain-9.2.0-linux-x86_64.tar.gz
RUN tar xzf mingw-w64-toolchain-9.2.0-linux-x86_64.tar.gz
WORKDIR /
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:/toolchains/mingw-w64-toolchain-9.2.0-linux-x86_64/mingw-w64-x86_64/bin:$PATH"
RUN rustup target add x86_64-pc-windows-gnu
RUN cargo install cargo-c

COPY build-handbrake.sh .

ENTRYPOINT /build-handbrake.sh