FROM debian:bookworm-slim

ARG USERNAME=dev
ARG USER_UID=1001
ARG USER_GID=1001
# debian:bookworm => ubuntu:jammy (https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian)
ARG UBUNTU_CODENAME=jammy

ENV LANG="C.UTF-8" \
    DEBIAN_FRONTEND="noninteractive"

USER root

COPY files/certs/*.crt /usr/local/share/ca-certificates/

RUN apt-get update -yq && \
    apt-get install -yqq \
        apt-transport-https \
        apt-utils \
        bash-completion \
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
        rsync \
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
    echo 'Adding ansible repository...' && \
    wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu ${UBUNTU_CODENAME} main" | tee /etc/apt/sources.list.d/ansible.list && \
    echo 'Adding Google Cloud repository...' && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    echo 'Adding helm repository...' && \
    curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list && \
    echo 'Adding terraform repository...' && \
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -yqq \
        ansible \
        google-cloud-cli \
        google-cloud-sdk-gke-gcloud-auth-plugin \
        helm \
        kubectl \
        terraform && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME && \
    echo 'git: mark all directories as safe' && \
    git config --system --add safe.directory '*' && \
    update-ca-certificates

USER $USERNAME

RUN curl https://raw.githubusercontent.com/devcontainers/features/refs/heads/main/src/common-utils/scripts/bash_theme_snippet.sh >>~/.bashrc && \
    echo 'source <(kubectl completion bash)' >>~/.bashrc && \
    echo 'alias k=kubectl' >>~/.bash_aliases && \
    echo 'complete -o default -F __start_kubectl k' >>~/.bashrc && \
    echo 'source <(helm completion bash)' >>~/.bashrc && \
    mkdir -p ~/.config/gcloud ~/.kube && \
    # Persisting bash history (https://code.visualstudio.com/remote/advancedcontainers/persist-bash-history)
    sudo install -d -o $USERNAME -g $USERNAME /commandhistory && \
    SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" && \
    touch /commandhistory/.bash_history && \
    echo "$SNIPPET" >> ~/.bashrc
