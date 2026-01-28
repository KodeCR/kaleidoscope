################################
# Kaleidoscope - RISC-V LLVM Toolchain
################################
# Build
FROM kaleidoscope AS build
WORKDIR /build

USER root
# RUN  apt-get update \
#   && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential cmake ccache libedit-dev libncurses-dev liblzma-dev libxml2-dev python3-dev \
#   && rm -rf /var/lib/apt/lists/*


# # LLVM toolchain
# RUN  apt-get update \
#   && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends wget lsb-release \
#   && rm -rf /var/lib/apt/lists/*
# RUN  cat <<EOD | tee /etc/apt/sources.list.d/llvm-toolchain.sources >/dev/null
# Types: deb
# URIs: http://apt.llvm.org/$(lsb_release -sc)
# Suites: llvm-toolchain-$(lsb_release -sc)
# Components: main
# Architectures: $(dpkg --print-architecture)
# Signed-By:
# $(wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | sed 's/^/ /')
# EOD

RUN  apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends llvm lld clang make zlib1g-dev libedit-dev libncurses-dev liblzma-dev libxml2-dev swig python3-dev \
  && rm -rf /var/lib/apt/lists/*
# RUN unlink /usr/bin/ld && ln -s ldd /usr/bin/ld
# RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 800 --slave /usr/bin/c++ c++ /usr/bin/clang++

RUN wget -q -O cmake-linux.sh https://github.com/Kitware/CMake/releases/download/v4.2.1/cmake-4.2.1-linux-$(uname -m).sh \
  && sh cmake-linux.sh --skip-license --prefix=/usr/local \
  && rm cmake-linux.sh
# RUN  apt-get update \
#   && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libssl-dev \
#   && rm -rf /var/lib/apt/lists/*
# RUN  --mount=type=ssh git clone https://github.com/Kitware/CMake.git
# RUN cd CMake && ./bootstrap && make && make install



RUN  --mount=type=ssh git clone https://github.com/llvm/llvm-project.git

# RUN unlink /usr/bin/ld && ln -s x86_64-linux-gnu-ld ld
RUN  mkdir build && cd build \
  && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/kaleidoscope -DLLVM_ENABLE_PROJECTS="llvm;lldb;lld;clang;clang-tools-extra" -DLLVM_ENABLE_RUNTIMES="" -DLLVM_BUILD_TOOLS=On -DLLVM_INSTALL_TOOLCHAIN_ONLY=On -DLLVM_TARGETS_TO_BUILD=RISCV -DLLVM_DEFAULT_TARGET_TRIPLE=riscv64-kaleidoscope-linux-gnu -DLLVM_USE_LINKER=lld ../llvm-project/llvm/ \
# # -DCMAKE_PREFIX_PATH=/opt/kaleidoscope 
# # -DLLVM_ENABLE_BACKTRACES=Off -DLLVM_OPTIMIZED_TABLEGEN=On -DLLVM_ENABLE_ZLIB=Off -DLLVM_ENABLE_TERMINFO=Off -DLLVM_ENABLE_LIBEDIT=Off -DLLVM_ENABLE_Z3_SOLVER=Off -DLLVM_ENABLE_BINDINGS=Off -DCLANG_ENABLE_OBJC_REWRITER=Off -DCLANG_ENABLE_ARCMT=Off -DCLANG_PLUGIN_SUPPORT=Off -DCLANG_ENABLE_STATIC_ANALYZER=Off -DCMAKE_EXPORT_COMPILE_COMMANDS=True -DLLVM_CCACHE_BUILD=On -DLLVM_ENABLE_ASSERTIONS=Off 
#   && make -j2 install

# # RUN  cmake -DLLVM_ENABLE_PROJECTS="llvm;lldb;lld;clang;clang-tools-extra" -DLLVM_TARGETS_TO_BUILD=RISCV -DLLVM_DEFAULT_TARGET_TRIPLE=riscv64-kaleidoscope-linux-gnu -DLLVM_BUILD_RUNTIME=Off -DLLVM_ENABLE_BACKTRACES=Off -DLLVM_OPTIMIZED_TABLEGEN=On -DLLVM_ENABLE_ZLIB=Off -DLLVM_ENABLE_TERMINFO=Off -DLLVM_ENABLE_LIBEDIT=Off -DLLVM_BUILD_RUNTIMES=Off -DLLVM_ENABLE_Z3_SOLVER=Off -DLLVM_PARALLEL_LINK_JOBS=1 -DLLVM_ENABLE_BINDINGS=Off -DCLANG_ENABLE_OBJC_REWRITER=Off -DCLANG_ENABLE_ARCMT=Off -DCLANG_PLUGIN_SUPPORT=Off -DCLANG_ENABLE_STATIC_ANALYZER=Off -DCMAKE_EXPORT_COMPILE_COMMANDS=True -DLLVM_BUILD_TOOLS=On -DLLVM_BUILD_UTILS=On -DLLVM_INSTALL_TOOLCHAIN_ONLY=On -DLLVM_CCACHE_BUILD=On -DLLVM_ENABLE_ASSERTIONS=Off -DCMAKE_INSTALL_PREFIX=/opt/kaleidoscope -DCMAKE_PREFIX_PATH=/opt/kaleidoscope -DCMAKE_BUILD_TYPE=Release llvm-project/llvm/ \
# #   && make -j2 install
# RUN cd /opt/kaleidoscope/bin \
#   && ln -s llvm-ar ar && ln -s lld ld && ln -s llvm-nm nm && ln -s llvm-objcopy objcopy && ln -s llvm-objdump objdump && ln -s llvm-ranlib ranlib && ln -s llvm-readobj readelf && ln -s llvm-strings strings && ln -s llvm-strip strip

# # Runtime
# FROM kaleidoscope
# WORKDIR /kaleidoscope

# USER root
# RUN  apt-get update \
#   && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libc6-dev libexpat1 libxml2 libmpc3 make python3 \
#   && rm -rf /var/lib/apt/lists/*
# COPY --from=build /opt/kaleidoscope /opt/kaleidoscope

# USER kaleidoscope
# ENV  PATH="/opt/kaleidoscope/bin:${PATH}"
# CMD  ["bash"]
