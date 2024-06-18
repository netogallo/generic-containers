FROM archlinux:base-20231112.0.191179

ARG MAIN_USER_NAME=main
ARG MAIN_USER_UID=1000
ARG MAIN_USER_GID=1000
ARG ROOT_PASSWORD=6666

ENV MAIN_USER_HOME /home/$MAIN_USER_NAME/
ENV NIX_BIN /nix/var/nix/profiles/default/bin/
ENV NIX_SHELL $NIX_BIN/nix-shell 
ENV NIX_DAEMON $NIX_BIN/nix-daemon

RUN pacman -Sy sudo git gettext --noconfirm
RUN curl -L https://nixos.org/nix/install > /tmp/nix.sh
RUN sh /tmp/nix.sh --daemon

RUN groupadd -g "${MAIN_USER_GID}" "${MAIN_USER_NAME}"
RUN useradd --create-home --no-log-init -u "${MAIN_USER_UID}" -g "${MAIN_USER_GID}" "${MAIN_USER_NAME}"
COPY main.sh /var/docker/bin/main.sh
COPY sudoers /tmp/sudoers
RUN cat /tmp/sudoers | envsubst > /etc/sudoers
RUN chmod -c 0440 /etc/sudoers

ENV SRC /workspace
RUN mkdir $SRC && chown ${MAIN_USER_NAME}:${MAIN_USER_NAME} $SRC
VOLUME $SRC

VOLUME $MAIN_USER_HOME/.ssh

COPY nix.conf /etc/nix/nix.conf

COPY env.sh /tmp/env.sh
RUN cat /tmp/env.sh | envsubst > ${MAIN_USER_HOME}.env.sh
RUN chown ${MAIN_USER_NAME}:${MAIN_USER_NAME} ${MAIN_USER_HOME}.env.sh
RUN echo "source ~/.env.sh" >> ${MAIN_USER_HOME}.bashrc

USER ${MAIN_USER_NAME}
WORKDIR /home/${MAIN_USER_NAME}

CMD ["bash", "/var/docker/bin/main.sh"]
