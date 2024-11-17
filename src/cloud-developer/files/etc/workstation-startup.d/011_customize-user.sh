#!/bin/bash

USERNAME=user

echo 'source <(kubectl completion bash)' >>/home/$USERNAME/.bashrc && \
echo 'alias k=kubectl' >>/home/$USERNAME/.bash_aliases && \
echo 'complete -o default -F __start_kubectl k' >>/home/$USERNAME/.bashrc && \
echo 'source <(helm completion bash)' >>/home/$USERNAME/.bashrc && \
# Persisting bash history (https://code.visualstudio.com/remote/advancedcontainers/persist-bash-history) \
sudo install -d -o $USERNAME -g $USERNAME /commandhistory && \
SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" && \
touch /commandhistory/.bash_history && \
echo "$SNIPPET" >> /home/$USERNAME/.bashrc