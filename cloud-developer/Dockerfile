# Preconfigured base images: https://cloud.google.com/workstations/docs/preconfigured-base-images
# Customize container images: https://cloud.google.com/workstations/docs/customize-container-images
FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/base:latest

ENV LANG="C.UTF-8" \
    DEBIAN_FRONTEND="noninteractive"

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
        sudo \
        tar \
        telnet \
        tmux \
        unzip \
        vim \
        wget \
        zip && \
    # Adding ansible repository \
    wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ansible.list && \
    # Adding terraform repository
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -yqq \
        ansible \
        terraform && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
ARG USERNAME=root
USER $USERNAME

RUN echo 'source <(kubectl completion bash)' >>~/.bashrc && \
    echo 'alias k=kubectl' >>~/.bash_aliases && \
    echo 'complete -o default -F __start_kubectl k' >>~/.bashrc && \
    echo 'source <(helm completion bash)' >>~/.bashrc && \
    # Persisting bash history (https://code.visualstudio.com/remote/advancedcontainers/persist-bash-history) \
    sudo install -d -o $USERNAME -g $USERNAME /commandhistory && \
    SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" && \
    touch /commandhistory/.bash_history && \
    echo "$SNIPPET" >> ~/.bashrc
