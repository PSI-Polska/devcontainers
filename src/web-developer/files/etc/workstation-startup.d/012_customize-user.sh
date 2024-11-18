#!/bin/bash

USERNAME=user

NVM_VERSION=0.40.1
echo "Installing nvm, node.js, nvm, angular cli..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | runuser -u $USERNAME bash
runuser -u $USERNAME nvm install 16
runuser -u $USERNAME nvm install 18
runuser -u $USERNAME nvm alias default 18
runuser -u $USERNAME npm install -g @angular/cli@18
echo 'Installing JEnv (https://www.jenv.be/)...'
runuser -u $USERNAME git clone https://github.com/jenv/jenv.git /home/$USERNAME/.jenv
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >>/home/$USERNAME/.bashrc
echo 'eval "$(jenv init -)"' >>/home/$USERNAME/.bashrc
runuser -u $USERNAME eval "$(jenv init -)"
runuser -u $USERNAME jenv enable-plugin export
runuser -u $USERNAME jenv add /usr/lib/jvm/temurin-17-jdk-amd64
runuser -u $USERNAME jenv global 17
echo 'export M2_HOME=/opt/apache-maven/apache-maven-${MAVEN_VERSION}' >>/home/$USERNAME/.bashrc
echo 'export M2=$M2_HOME/bin' >>/home/$USERNAME/.bashrc
echo 'export PATH=$M2:$PATH' >>/home/$USERNAME/.bashrc
echo 'export MAVEN_OPTS="-Xms512m -Xmx1g"' >>/home/$USERNAME/.bashrc