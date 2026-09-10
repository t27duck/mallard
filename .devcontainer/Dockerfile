# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=4.0.6
FROM ghcr.io/rails/devcontainer/images/ruby:$RUBY_VERSION

# Claude Code's config directory is backed by a named volume (see compose.yaml).
# Creating it here means Docker initializes that volume with vscode's ownership
# instead of handing back a root-owned directory.
RUN mkdir -p /home/vscode/.claude && chown vscode:vscode /home/vscode/.claude
