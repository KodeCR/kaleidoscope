################################
# Kaleidoscope - SysRoot Linux
################################
# Build
FROM riscv-llvm-toolchain AS build
WORKDIR /build

USER root
RUN  apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends vim \
  # build-essential cmake ccache libedit-dev libncurses-dev liblzma-dev libxml2-dev python3-dev \
  && rm -rf /var/lib/apt/lists/*

RUN  --mount=type=ssh git clone https://github.com/bminor/glibc.git
RUN  apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends gawk bison \
  # build-essential cmake ccache libedit-dev libncurses-dev liblzma-dev libxml2-dev python3-dev \
  && rm -rf /var/lib/apt/lists/*
COPY linux-headers/include /opt/kaleidoscope/include

CC="clang --target=riscv32-kaleidoscope-linux-gnu -march=rv32imac -mabi=ilp32" glibc/configure --host=riscv-kaleidoscope-linux-gnu --prefix=/opt/kaleidoscope --enable-shared --enable-multilib --with-headers=/opt/kaleidoscope/include

CC="$(GLIBC_CC_FOR_TARGET)" $</configure \
		--host=$(LINUX_TUPLE) \
		--prefix=$(SYSROOT)/usr \
		--enable-shared \
		--with-headers=$(LINUX_HEADERS_SRCDIR) \
		--disable-multilib \
		--enable-kernel=3.0.0
$(MAKE) -C $(notdir $@) install-headers


CC="clang --target=riscv64-unknown-linux-gnu -march=rv64imac -mabi=lp64" glibc/configure --host=riscv64-unknown-linux-gnu --prefix=/opt/kaleidoscope/usr --enable-shared --with-headers=/opt/kaleidoscope/include --disable-multilib --enable-kernel=3.0.0

CC="clang --target=riscv64-unknown-linux-gnu -march=rv64imac -mabi=lp64" glibc/configure --host=riscv64-unknown-linux-gnu --prefix=/opt/kaleidoscope/usr --enable-shared --with-headers=/opt/kaleidoscope/include --enable-multilib --enable-kernel=3.0.0


	cd $(notdir $@) && \
		CC="$(GLIBC_CC_FOR_TARGET) $($@_CFLAGS)" \
		CXX="this-is-not-the-compiler-youre-looking-for" \
		CFLAGS="$(CFLAGS_FOR_TARGET) -O2 $($@_CFLAGS)" \
		CXXFLAGS="$(CXXFLAGS_FOR_TARGET) -O2 $($@_CFLAGS)" \
		ASFLAGS="$(ASFLAGS_FOR_TARGET) $($@_CFLAGS)" \
		$</configure \
		--host=$(call make_tuple,$($@_XLEN),linux-gnu) \
		--prefix=/usr \
		--disable-werror \
		--enable-shared \
		--enable-obsolete-rpc \
		--with-headers=$(LINUX_HEADERS_SRCDIR) \
		$(MULTILIB_FLAGS) \
		--enable-kernel=3.0.0 \
		$(GLIBC_TARGET_FLAGS) \
		$($@_LIBDIROPTS)
	$(MAKE) -C $(notdir $@)


# CC="clang --target=riscv32-kaleidoscope-linux-gnu -march=rv32imac -mabi=ilp32" glibc/configure --host=riscv-kaleidoscope-linux-gnu --prefix=/opt/kaleidoscope --enable-shared --enable-multilib
# CC="clang -march=rv32imac -mabi=ilp32" glibc/configure --host=riscv-kaleidoscope-linux-gnu --prefix=/opt/kaleidoscope --enable-shared --enable-multilib
# CC="clang --target=riscv32-kaleidoscope-linux-gnu -march=rv32imac -mabi=ilp32" LD=ld.lld glibc/configure --host=riscv-kaleidoscope-linux-gnu --prefix=/opt/kaleidoscope --enable-shared --enable-multilib
# CC='gcc'
# CFLAGS='-g -O2'
# WITH_ABI='--with-abi=lp64d'
# WITH_ARCH='--with-arch=rv64gc'
# cmodel='-mcmodel=medlow'
# glibc_multilib_names='rv32imac-ilp32 rv32gc-ilp32d rv64imac-lp64 rv64gc-lp64d rv64gcv-lp64d'
# 
# configure --host=riscv64-unknown-linux-gnu --prefix=/usr --disable-werror --enable-shared --enable-obsolete-rpc --with-headers=/build/riscv-gnu-toolchain/build/../linux-headers/include --enable-multilib --enable-kernel=3.0.0 --libdir=/usr/lib64/lp64d libc_cv_slibdir=/lib64/lp64d libc_cv_rtlddir=/lib
# glibc/configure --host=riscv64-kaleidoscope-linux-gnu --prefix=/opt/kaleidoscope --enable-shared --enable-multilib

# RUN  cmake -DLLVM_ENABLE_PROJECTS="lldb;lld;clang;clang-tools-extra" -DLLVM_TARGETS_TO_BUILD=RISCV -DLLVM_BUILD_RUNTIME=Off -DLLVM_ENABLE_BACKTRACES=Off -DLLVM_OPTIMIZED_TABLEGEN=On -DLLVM_ENABLE_ZLIB=Off -DLLVM_ENABLE_TERMINFO=Off -DLLVM_ENABLE_LIBEDIT=Off -DLLVM_BUILD_RUNTIMES=Off -DLLVM_ENABLE_Z3_SOLVER=Off -DLLVM_PARALLEL_LINK_JOBS=1 -DLLVM_ENABLE_BINDINGS=Off -DCLANG_ENABLE_OBJC_REWRITER=Off -DCLANG_ENABLE_ARCMT=Off -DCLANG_PLUGIN_SUPPORT=Off -DCLANG_ENABLE_STATIC_ANALYZER=Off -DCMAKE_EXPORT_COMPILE_COMMANDS=True -DLLVM_BUILD_TOOLS=On -DLLVM_BUILD_UTILS=On -DLLVM_INSTALL_TOOLCHAIN_ONLY=On -DLLVM_CCACHE_BUILD=On -DLLVM_ENABLE_ASSERTIONS=Off -DCMAKE_INSTALL_PREFIX=/opt/kaleidoscope -DCMAKE_PREFIX_PATH=/opt/kaleidoscope -DCMAKE_BUILD_TYPE=Release llvm-project/llvm/ \
#   && make -j2 install

# # Runtime
# FROM monocle
# WORKDIR /kaleidoscope

# USER root
# RUN  useradd -ms /bin/bash kaleidoscope
# # RUN  apt-get update \
# #   && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libc6-dev libexpat1 libxml2 libmpc3 make python3 \
# #   && rm -rf /var/lib/apt/lists/*
# # COPY --from=build /opt/kaleidoscope /opt/kaleidoscope

# USER kaleidoscope
# # USER monocle
# # ENV  PATH="/opt/kaleidoscope/bin:${PATH}"
# # CMD  ["bash"]
