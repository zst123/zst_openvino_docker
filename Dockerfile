FROM ubuntu:16.04

# Based loosely on:
# https://docs.openvinotoolkit.org/2018_R5/_docs_install_guides_installing_openvino_docker.html

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    cpio \
    curl \
    sudo \
    lsb-release \
    software-properties-common \
    libgl1-mesa-glx \
    && \
    rm -rf /var/lib/apt/lists/*

# Install Python 3.6
RUN sudo add-apt-repository ppa:deadsnakes/ppa && sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends \
    python3.6 \
    python3-setuptools \
    python3-pip \
    libpython3.6 \
    && \
    rm -rf /var/lib/apt/lists/* && \
    ln -sf /usr/bin/python3.6 /usr/bin/python3

# Install Python dependencies
# https://github.com/openvinotoolkit/openvino/issues/459
# https://stackoverflow.com/questions/60042568/this-application-failed-to-start-because-no-qt-platform-plugin-could-be-initiali
RUN python3.6 -m pip install -U pip && \
    python3.6 -m pip install -U futures && \
    python3.6 -m pip install -U opencv-python==4.1.2.30 && \
    python3.6 -m pip install -U opencv-contrib-python

# Copy over the downloaded install archive
COPY ./files/l_openvino_toolkit*.tgz /root/l_openvino_toolkit*.tgz

# OpenVINO Full-Install
RUN cd /root/ && \
    tar -zxf l_openvino_toolkit*.tgz && \
    rm l_openvino_toolkit*.tgz && \
    cd l_openvino_toolkit*/ && \
    sed -i 's/decline/accept/g' silent.cfg && \
    ./install.sh -s silent.cfg

RUN cd /opt/intel/openvino/install_dependencies/ && \
    sudo -E ./install_openvino_dependencies.sh

RUN echo "source /opt/intel/openvino/bin/setupvars.sh" > /root/.bashrc

# Configure the Model Optimizer
RUN cd /opt/intel/openvino/deployment_tools/model_optimizer/install_prerequisites/ && \
    sudo ./install_prerequisites.sh

# Customize bach prompt
RUN echo 'set completion-ignore-case on' >> ~/.inputrc && \
    echo "export LS_OPTIONS='--color=auto'" >> ~/.bashrc && \
    echo "alias ls='ls $LS_OPTIONS'" >> ~/.bashrc && \
    echo 'dracula_theme_black="\[$(tput setaf 0)\]"' >> ~/.bashrc && \
    echo 'dracula_theme_red="\[$(tput setaf 1)\]"' >> ~/.bashrc && \
    echo 'dracula_theme_green="\[$(tput setaf 2)\]"' >> ~/.bashrc && \
    echo 'dracula_theme_yellow="\[$(tput setaf 3)\]"' >> ~/.bashrc && \
    echo 'dracula_theme_blue="\[$(tput setaf 4)\]"' >> ~/.bashrc && \
    echo 'dracula_theme_magenta="\[$(tput setaf 5)\]"' >> ~/.bashrc && \
    echo 'dracula_theme_cyan="\[$(tput setaf 6)\]"' >> ~/.bashrc && \
    echo 'dracula_theme_white="\[$(tput setaf 7)\]"' >> ~/.bashrc && \
    echo 'dracula_theme_clear_attributes="\[$(tput sgr0)\]"' >> ~/.bashrc && \
    echo 'export PS1="${debian_chroot:+($debian_chroot)}${dracula_theme_yellow}\u@\h:${dracula_theme_green}\w${dracula_theme_red} # ${dracula_theme_clear_attributes}"' >> ~/.bashrc
