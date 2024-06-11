FROM archlinux:base-20231112.0.191179

ARG MAIN_USER_NAME=main
ARG MAIN_USER_UID=1000
ARG MAIN_USER_GID=1000

RUN groupadd -g "${MAIN_USER_GID}" "${MAIN_USER_NAME}" \
  && useradd --create-home --no-log-init -u "${MAIN_USER_UID}" -g "${MAIN_USER_GID}" "${MAIN_USER_NAME}"
COPY main.sh /var/docker/bin/main.sh

ENV SRC /code
RUN mkdir $SRC && chown ${MAIN_USER_NAME}:${MAIN_USER_NAME} $SRC
VOLUME $SRC

RUN mkdir /nix && chown ${MAIN_USER_NAME}:${MAIN_USER_NAME} /nix
VOLUME /nix

USER ${MAIN_USER_NAME}

RUN curl -L https://nixos.org/nix/install > /tmp/nix.sh && sh /tmp/nix.sh

COPY nix.conf  ~/.config/nix/nix.conf

COPY env.sh /tmp/env.sh
RUN nix-shell --impure -p envsubst --run "cat /tm/env.sh | envsubst > /home/${MAIN_USER_NAME}/.env.sh"
RUN echo "source ~/.env.sh" >> "~/.bashrc"

WORKDIR /home/${MAIN_USER_NAME}

CMD ["bash", "/var/docker/bin/main.sh"]
