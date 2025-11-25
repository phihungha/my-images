FROM registry.fedoraproject.org/fedora-toolbox:latest

WORKDIR /setup

ARG BRUNO_VERSION=2.14.2
RUN wget "https://github.com/usebruno/bruno/releases/download/v${BRUNO_VERSION}/bruno_${BRUNO_VERSION}_x86_64_linux.rpm" -O bruno.rpm && \
    sudo dnf install bruno.rpm -y && rm bruno.rpm

RUN wget https://dbeaver.io/files/dbeaver-ce-latest-stable.x86_64.rpm -O dbeaver.rpm && \
    sudo dnf install dbeaver.rpm -y && rm dbeaver.rpm

RUN sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null && \
    sudo dnf install code -y

RUN sudo dnf --setopt install_weak_deps=False install neovim -y
RUN sudo dnf install fuse-libs libatomic -y
RUN sudo dnf install dotnet-sdk-10.0 python-launcher -y
RUN sudo dnf install fira-code-fonts -y

RUN wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -O aws.zip && \
    unzip aws.zip && sudo ./aws/install && \
    rm -r aws && rm aws.zip

RUN sudo ln -sv /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
    sudo ln -sv /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
    sudo ln -sv /usr/bin/distrobox-host-exec /usr/local/bin/xdg-open
