################################################################
# Kaleidoscope - RISC-V LLVM Toolchain
################################################################
# Build
FROM kaleidoscope AS build
WORKDIR /build

USER root
RUN  apt update -qy \
  && apt install -qy --no-install-recommends cmake ninja-build zlib1g-dev libedit-dev libncurses-dev liblzma-dev libxml2-dev swig python3-dev \
  && rm -rf /var/lib/apt/lists/*
RUN  --mount=type=ssh git clone --depth 1 https://github.com/llvm/llvm-project.git
RUN  cmake -S llvm-project/llvm -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/kaleidoscope -DLLVM_ENABLE_PROJECTS="llvm;lldb;lld;clang;clang-tools-extra" -DLLVM_ENABLE_RUNTIMES="" -LLVM_ENABLE_LLD=On -LLVM_ENABLE_LIBCXX=On -DLLVM_BUILD_TOOLS=On -DLLVM_INSTALL_BINUTILS_SYMLINKS=On -DLLVM_INSTALL_CCTOOLS_SYMLINKS=On -DLLVM_INSTALL_TOOLCHAIN_ONLY=On -DLLVM_TARGETS_TO_BUILD=RISCV -DLLVM_DEFAULT_TARGET_TRIPLE=riscv64-kaleidoscope-none \
  && cmake --build build --target install

################################################################
# Runtime
FROM kaleidoscope

USER root
RUN  apt update -qy \
  && apt install -qy --no-install-recommends libncurses6 \
  && rm -rf /var/lib/apt/lists/*
COPY --from=build /opt/kaleidoscope /opt/kaleidoscope

USER kaleidoscope
