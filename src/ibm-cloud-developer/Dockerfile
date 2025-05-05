FROM ghcr.io/psi-polska/devcontainers/base

USER root

RUN echo 'Installing IBM CLI...' && \
    curl -fsSL https://clis.cloud.ibm.com/install/linux | sh && \
    apt-get update -yq && \
    apt-get install -yqq \
        terraform=1.5.7-1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG USERNAME=dev
USER $USERNAME

RUN echo "[[ -f /usr/local/ibmcloud/autocomplete/bash_autocomplete ]] && source /usr/local/ibmcloud/autocomplete/bash_autocomplete" >>~/.bashrc && \
    ibmcloud plugin install vpc-infrastructure cloud-object-storage container-registry container-service cloud-databases
