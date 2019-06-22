# Debian stretch is version 9 of the OS and is the current stable version
FROM ruby:2.6-stretch

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash && \
  rm -rf /var/lib/apt/lists/*
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  postgresql-client-11 \
  vim \
  htop \
  nodejs \
  yarn \
  && rm -rf /var/lib/apt/lists/*

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

# Where the app files will be mounted
WORKDIR /app

EXPOSE 3000

COPY docker-entry.sh .

ENTRYPOINT ["/app/docker-entry.sh"]
CMD ["bash"]
