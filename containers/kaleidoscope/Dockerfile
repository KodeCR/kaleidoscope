################################################################
# Kaleidoscope - Base image
################################################################
# Runtime
FROM monocle

USER root
RUN  useradd -ms /bin/bash kaleidoscope

# LLVM host toolchain
RUN  cat <<EOD | tee /etc/apt/sources.list.d/llvm-toolchain.sources >/dev/null
Types: deb
URIs: http://apt.llvm.org/$(lsb_release -sc)
Suites: llvm-toolchain-$(lsb_release -sc)
Components: main
Architectures: $(dpkg --print-architecture)
Signed-By:
$(wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | sed 's/^/ /')
EOD
RUN  apt update -qy \
  && apt install -qy --no-install-recommends vim llvm clang lld libc++-dev \
  && rm -rf /var/lib/apt/lists/*

USER kaleidoscope
WORKDIR /kaleidoscope
ENV  PATH="/opt/kaleidoscope/bin:${PATH}"
