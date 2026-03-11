################################################################
# Kaleidoscope - RISC-V QEMU
################################################################
# Build
FROM kaleidoscope AS build
WORKDIR /build

USER root
RUN  apt update -qy \
  && apt install -qy --no-install-recommends python3-venv ninja-build bzip2 pkg-config libglib2.0-dev libpixman-1-dev libslirp-dev \
  && rm -rf /var/lib/apt/lists/*
RUN  --mount=type=ssh git clone https://github.com/qemu/qemu --branch v10.2.1
RUN  mkdir build && cd build \
  && AR=llvm-ar CC=clang CXX=clang++ ../qemu/configure --extra-ldflags="-fuse-ld=lld" --prefix=/opt/kaleidoscope --target-list=riscv32-softmmu,riscv64-softmmu,riscv32-linux-user,riscv64-linux-user \
  && ninja install

################################################################
# Runtime
FROM kaleidoscope

USER root
RUN  apt update -qy \
  && apt install -qy --no-install-recommends libglib2.0-0 libpixman-1-0 libslirp0 \
  && rm -rf /var/lib/apt/lists/*
COPY --from=build /opt/kaleidoscope /opt/kaleidoscope

USER kaleidoscope
