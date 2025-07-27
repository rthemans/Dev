FROM alpine:3.20

# Dépendances de base
RUN apk add --no-cache bash curl sudo shadow git

# create user
RUN useradd -m dev && echo "dev:dev" | chpasswd && adduser dev sudo
USER dev
CMD /bin/bash

# Installation de Nix
ENV NIX_INSTALL_URL https://nixos.org/nix/install
ENV NIX_CONFIG "experimental-features = nix-command flakes"

RUN curl -L $NIX_INSTALL_URL | sh

# Copy envs
COPY --chown=dev:dev env dev-env

# Copy configs
COPY config .config

# Charge nix develop comme shell de démarrage
ENTRYPOINT ["bash"]

