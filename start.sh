#!/bin/bash
NAME="zst_openvino_docker"
IMAGE="zst_openvino_docker"

mkdir -p ./files

docker run \
    --hostname "${NAME}" \
    --interactive \
    --name "${NAME}" \
    --privileged \
    --detach \
    --volume "$(pwd)/files:/FILES" \
	--device=/dev/video0:/dev/video0 \
    --env DISPLAY=unix$DISPLAY \
    --env="QT_X11_NO_MITSHM=1" \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    -p 5000:5000 -p 8888:8888 \
    $IMAGE
