# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=4.0.10
FROM docker.io/library/ruby:$RUBY_VERSION-trixie

# The Docker Hub ruby image only has root. Create the vscode user the dev container
# runs as and hand it the gem directory (GEM_HOME is /usr/local/bundle), so bundle
# install works without sudo. The common-utils feature in devcontainer.json then
# gives this user sudo, zsh and oh-my-zsh.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID --create-home --shell /bin/bash $USERNAME && \
    chown -R $USERNAME:$USERNAME /usr/local/bundle

# User-installed tools (e.g. Claude Code) land in ~/.local/bin.
ENV PATH="/home/vscode/.local/bin:$PATH"

# Claude Code's config directory is backed by a named volume (see compose.yaml).
# Creating it here means Docker initializes that volume with vscode's ownership
# instead of handing back a root-owned directory.
RUN mkdir -p /home/vscode/.claude && chown vscode:vscode /home/vscode/.claude

USER vscode
