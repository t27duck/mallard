# Debian stretch is version 9 of the OS and is the current stable version
FROM ruby:2.6-stretch

EXPOSE 8080

RUN \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  postgresql-client-9.6 \
  vim \
  htop \
  && rm -rf /var/lib/apt/lists/*

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

# Where the app files will be mounted
WORKDIR /app

CMD ["bash"]
