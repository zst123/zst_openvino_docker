# zst_openvino_docker

This is a docker setup to install Intel OpenVINO toolkit on an Ubuntu 16.04 instance.

### Instructions

1. Download version 2019 R1.01 (l_openvino_toolkit_p_2019.1.133.tgz) and place it in the `./files` directory. Alternatively, run `./download_openvino-2019.1.133.sh`
2. Build the docker image with `./build.sh`
3. Start the docker instance with `./start.sh`
4. Launch the shell with `./bash.sh`
5. Stop the docker instance with `./stop.sh`
