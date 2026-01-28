################################
# Kaleidoscope - Base image
################################
# Runtime
FROM monocle
WORKDIR /kaleidoscope

USER root
RUN  useradd -ms /bin/bash kaleidoscope
RUN  apt-get update -qy \
  && apt-get install -qy --no-install-recommends vim \
  && rm -rf /var/lib/apt/lists/*

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
# RUN  cat <<EOD | tee /etc/apt/sources.list.d/cmake.sources >/dev/null
# Types: deb
# URIs: http://apt.kitware.com/ubuntu
# Suites: $(lsb_release -sc)
# Components: main
# Architectures: $(dpkg --print-architecture)
# Signed-By:
# $(wget -qO- https://apt.kitware.com/keys/kitware-archive-latest.asc | sed 's/^/ /')
# EOD

# RUN  apt-get update -qy \
#   && apt-get install -qy --no-install-recommends libc6-dev libexpat1 libxml2 libmpc3 make python3 \
#   && rm -rf /var/lib/apt/lists/*
# COPY --from=build /opt/kaleidoscope /opt/kaleidoscope

# USER kaleidoscope
ENV  PATH="/opt/kaleidoscope/bin:${PATH}"
