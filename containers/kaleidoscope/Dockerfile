################################
# Kaleidoscope - Base image
################################
# Runtime
FROM monocle
WORKDIR /kaleidoscope

USER root
RUN  useradd -ms /bin/bash kaleidoscope

# LLVM toolchain support
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
  && apt install -qy --no-install-recommends vim make llvm clang lld \
  && rm -rf /var/lib/apt/lists/*

# USER kaleidoscope
ENV  PATH="/opt/kaleidoscope/bin:${PATH}"
