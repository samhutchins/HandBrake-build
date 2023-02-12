FROM ubuntu:22.04

ENV PATH="/root/.cargo/bin:/toolchains/mingw-w64-toolchain-9.2.0-linux-x86_64/mingw-w64-x86_64/bin:$PATH"
WORKDIR /

# rust
RUN \
       apt update \
    && apt install -y curl build-essential pkg-config libssl-dev \
    && curl https://sh.rustup.rs -sSf | sh -s -- -y \
    && rustup target add x86_64-pc-windows-gnu \
    && cargo install cargo-c

# mingw toolchain
RUN \
       apt install -y wget \
    && mkdir toolchains \
    && wget https://github.com/bradleysepos/mingw-w64-build/releases/download/9.2.0/mingw-w64-toolchain-9.2.0-linux-x86_64.tar.gz \
    && tar xzf mingw-w64-toolchain-9.2.0-linux-x86_64.tar.gz -C toolchains \
    && rm mingw-w64-toolchain-9.2.0-linux-x86_64.tar.gz

# handbrake build
RUN apt install -y git python3 m4 autoconf libtool-bin meson nasm cmake clang

COPY build-handbrake.sh .

ENTRYPOINT /build-handbrake.sh