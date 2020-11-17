FROM ubuntu:16.04

#installs
RUN apt-get -y update && apt-get install -y --no-install-recommends \
         wget \
         python \
         nginx \
         ca-certificates \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get update 
RUN apt-get install -y swig 
RUN apt-get install -y git
RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && \
    pip install numpy==1.16.2 scipy==1.2.1 scikit-learn==0.20.2 pandas flask gevent gunicorn && \
        (cd /usr/local/lib/python2.7/dist-packages/scipy/.libs; rm *; ln ../../numpy/.libs/* .) && \
        rm -rf /root/.cache

#path variables

ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/program:${PATH}"

WORKDIR /opt/program

RUN cd /opt/program 
RUN git clone https://github.com/DiegoJohnsonUPC/Pose_Estimation_3D.git 
RUN pip install tensorflow && pip install -r requirements.txt 
RUN pip install matplotlib 
RUN cd tf_pose 
RUN cd pafprocess 
RUN swig -python -c++ pafprocess.i && python setup.py build_ext --inplace 
RUN cd ..
RUN python run.py --model=mobilenet_thin --resize=432x368 --image=./dataset_images/im0001.jpg 

