FROM ghcr.io/psi-polska/devcontainers/base

USER root

RUN echo 'Installing IBM CLI...' && \
    curl -fsSL https://clis.cloud.ibm.com/install/linux | sh

ARG USERNAME=dev
USER $USERNAME

RUN echo "[[ -f /usr/local/ibmcloud/autocomplete/bash_autocomplete ]] && source /usr/local/ibmcloud/autocomplete/bash_autocomplete" >>~/.bashrc && \
    ibmcloud plugin install vpc-infrastructure cloud-object-storage container-registry container-service cloud-databases
