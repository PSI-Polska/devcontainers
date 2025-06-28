FROM debian:bookworm-slim

ARG USERNAME=dev
ARG USER_UID=1001
ARG USER_GID=1001
# debian:bookworm => ubuntu:jammy (https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian)
ARG UBUNTU_CODENAME='jammy'
ARG GLAB_VERSION=1.55.0

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
    echo 'Installing GitLab CLI (glab)...' && \
    curl -L https://gitlab.com/gitlab-org/cli/-/releases/v${GLAB_VERSION}/downloads/glab_${GLAB_VERSION}_linux_amd64.deb -o glab_${GLAB_VERSION}_linux_amd64.deb && \
    dpkg -i ./glab_${GLAB_VERSION}_linux_amd64.deb && \
    rm -f ./glab_${GLAB_VERSION}_linux_amd64.deb && \
    echo 'Adding ansible repository...' && \
    wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | \
        gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu ${UBUNTU_CODENAME} main" | \
        tee /etc/apt/sources.list.d/ansible.list && \
    echo 'Adding helm repository...' && \
    curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | \
        tee /etc/apt/sources.list.d/helm-stable-debian.list && \
    echo "Adding kubectl repository..." && \
    kubectl_version="$(curl -L -s https://dl.k8s.io/release/stable.txt | cut -c -5)" && \
    curl -fsSL https://pkgs.k8s.io/core:/stable:/${kubectl_version}/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${kubectl_version}/deb/ /" | \
        tee /etc/apt/sources.list.d/kubernetes.list && \
    echo 'Adding terraform repository...' && \
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
        tee /etc/apt/sources.list.d/hashicorp.list && \
    echo 'Installing velero...' && \
    velero_version="$(basename $(curl -Ls -o /dev/null -w "%{url_effective}" "https://github.com/vmware-tanzu/velero/releases/latest"))" && \
    curl -L https://github.com/vmware-tanzu/velero/releases/download/${velero_version}/velero-${velero_version}-linux-amd64.tar.gz | \
        sudo tar -xzf - --strip-components=1 velero-${velero_version}-linux-amd64/velero --directory /usr/bin/ && \
    apt-get update -yq && \
    apt-get install -yqq \
        ansible \
        helm \
        kubectl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME && \
    install -d -o $USERNAME -g $USERNAME /commandhistory && \
    echo 'git: mark all directories as safe' && \
    git config --system --add safe.directory '*' && \
    update-ca-certificates

USER $USERNAME

RUN curl https://raw.githubusercontent.com/devcontainers/features/refs/heads/main/src/common-utils/scripts/bash_theme_snippet.sh >>~/.bashrc && \
    echo 'source <(kubectl completion bash)' >>~/.bashrc && \
    echo 'alias k=kubectl' >>~/.bash_aliases && \
    echo 'complete -o default -F __start_kubectl k' >>~/.bashrc && \
    echo 'source <(helm completion bash)' >>~/.bashrc && \
    echo 'source <(glab completion -s bash)' >>~/.bashrc && \
    echo 'source <(velero completion bash)' >>~/.bashrc && \
    echo 'alias v=velero' >>~/.bash_aliases && \
    echo 'complete -F __start_velero v' >>~/.bashrc && \
    mkdir -p ~/.kube && \
    # Persisting bash history (https://code.visualstudio.com/remote/advancedcontainers/persist-bash-history)
    touch /commandhistory/.bash_history && \
    echo "export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" >> ~/.bashrc
