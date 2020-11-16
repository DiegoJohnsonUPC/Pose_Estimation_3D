FROM ubuntu:16.04

RUN apt-get install -yq python3 python3-dev python3-pip python3-setuptools python3-tk git && \
apt-get remove -yq python-pip python3-pip && wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py && \
pip3 install numpy && \
cd ~ && git clone https://github.com/DiegoJohnsonUPC/Pose_Estimation_3D.git