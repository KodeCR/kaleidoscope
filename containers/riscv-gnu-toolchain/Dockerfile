################################
# Build
################################
FROM kaleidoscope AS build
WORKDIR /build

USER root
RUN  apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential gawk texinfo bison flex libexpat-dev libgmp-dev zlib1g-dev libglib2.0-dev libmpc-dev libmpfr-dev autoconf automake autotools-dev curl python3 python3-pip gperf libtool patchutils bc ninja-build cmake \
  && rm -rf /var/lib/apt/lists/*

RUN  --mount=type=ssh git clone https://github.com/riscv/riscv-gnu-toolchain --branch 2025.11.27
RUN  mkdir riscv-gnu-toolchain/build && cd riscv-gnu-toolchain/build \
    # && rm -r /usr/local && \
    # sed -i 's/unknown/img/g' ../Makefile.in && sed -i 's/XLEN := \($(shell echo .*)\|64\)/XLEN := /g' ../Makefile.in && \
    # sed -i 's|stamps/build-binutils-newlib: $(BINUTILS_SRCDIR) $(BINUTILS_SRC_GIT) $(PREPARATION_STAMP)|stamps/build-binutils-newlib: $(BINUTILS_SRCDIR) $(BINUTILS_SRC_GIT) $(PREPARATION_STAMP)\n	sed -i '\''s/riscv-\\*-\\*/riscv32-\\*-\\*/'\'' $</ld/configure.tgt\n	sed -i '\''s/riscv64\\*-\\*-\\(linux\\)\\{0,1\\}\\*/riscv\\*-\\*-\\1\\*/'\'' $</ld/configure.tgt|' ../Makefile.in && \
    # sed -i 's|stamps/build-binutils-linux: $(BINUTILS_SRCDIR) $(BINUTILS_SRC_GIT) $(PREPARATION_STAMP)|stamps/build-binutils-linux: $(BINUTILS_SRCDIR) $(BINUTILS_SRC_GIT) $(PREPARATION_STAMP)\n	sed -i '\''s/riscv-\\*-\\*/riscv32-\\*-\\*/'\'' $</ld/configure.tgt\n	sed -i '\''s/riscv64\\*-\\*-\\(linux\\)\\{0,1\\}\\*/riscv\\*-\\*-\\1\\*/'\'' $</ld/configure.tgt|' ../Makefile.in && \
  && ../configure --enable-multilib \
  && make linux
    # make && \

# COPY riscv* /usr/local/bin

# # ################
# # # Install
# # ################
# FROM hhdocrepo.hh.imgtec.org/kaleidoscope/ubuntu-img:22.04
# WORKDIR /work

# RUN apt-get update && \
#     DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libexpat-dev libmpc-dev make
# COPY --from=build /usr/local /usr/local
