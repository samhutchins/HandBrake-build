FROM ubuntu:22.04

ENV PATH="/root/.cargo/bin:/toolchains/mingw-w64-x86_64/bin:$PATH"
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
       apt install -y wget bison flex m4 pax \
    && mkdir toolchains \
    && wget https://raw.githubusercontent.com/HandBrake/HandBrake/master/scripts/mingw-w64-build \
    && chmod +x mingw-w64-build \
    && ./mingw-w64-build x86_64 toolchains \
    && rm mingw-w64-build

# handbrake build
RUN apt install -y git python3 autoconf libtool-bin meson nasm cmake clang

COPY build-handbrake.sh .

ENTRYPOINT /build-handbrake.sh