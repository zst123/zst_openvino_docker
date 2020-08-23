#!/bin/bash
mkdir -p ./files
cd ./files
curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1ciX7cHqCh8lLFYI0HKkhC3r_fMirrlKk" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1ciX7cHqCh8lLFYI0HKkhC3r_fMirrlKk" -o l_openvino_toolkit_p_2019.1.133.tgz
cd ..
