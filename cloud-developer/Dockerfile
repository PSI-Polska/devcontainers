FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

ENV LANG="C.UTF-8"
ENV DEBIAN_FRONTEND="noninteractive"

ARG USERNAME=dev
ARG UID=1001
ARG GID=1001

USER root

RUN apt-get update -yq && \
    apt-get install -yqq \
        apt-transport-https \
        apt-utils \
        ca-certificates \
        curl \
        dnsutils \
        git \
        gpg \
        htop \
        iperf3 \
        iputils-ping \
        jq \
        lsb-release \
        mc \
        nano \
        screen \
        shellcheck \
        skopeo \
        software-properties-common \
        sudo \
        tar \
        telnet \
        tmux \
        unzip \
        vim \
        wget \
        zip && \
    # Adding ansible repository
    add-apt-repository "ppa:ansible/ansible" && \
    # Adding Google Cloud repository
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    # Adding helm repository
    curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list && \
    # Adding terraform repository
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -yqq \
        ansible \
        google-cloud-cli \
        helm \
        kubectl \
        terraform && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # Adding "dev" user 
    groupadd --gid $GID $USERNAME && \
    useradd --uid $UID --gid $GID -m $USERNAME && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

RUN echo 'source <(kubectl completion bash)' >>~/.bashrc && \
    echo 'alias k=kubectl' >>~/.bash_aliases && \
    echo 'complete -o default -F __start_kubectl k' >>~/.bashrc && \
    echo 'source <(helm completion bash)' >>~/.bashrc
