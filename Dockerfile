FROM nvcr.io/nvidia/caffe:20.03-py3

# Remove examples and NVidia NSight
RUN rm -rf \
    /workspace \
    /usr/local/cuda-10.2/NsightSystems-cli-2020.1.1 \
    /opt/nvidia

# Packages
RUN export LC_ALL=C && \
    apt-get -y --no-install-recommends update && \
    apt-get -y --no-install-recommends upgrade && \
    apt-get install -y --no-install-recommends \
        build-essential \
        git \
        wget \
        nano \
        dialog \
        software-properties-common \
        libatlas-base-dev \
        libleveldb-dev \
        libsnappy-dev \
        libhdf5-serial-dev \
        libboost-all-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        liblmdb-dev \
        pciutils \
        python3-setuptools \
        python3-dev \
        python3-pip \
        opencl-headers \
        ocl-icd-opencl-dev \
        libviennacl-dev \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libv4l-dev \
        libxvidcore-dev \
        libx264-dev \
        libgtk-3-dev \
        gfortran \
        pkg-config \
        libssl-dev \
        libcanberra-gtk-module && \
    python3 -m pip install \
        numpy \
        opencv-python && \
    # Up to date ffmpeg
    add-apt-repository -y ppa:jonathonf/ffmpeg-4 && \
    apt-get -y --no-install-recommends update && \
    apt-get -y --no-install-recommends install ffmpeg && \
    # Up to date CMake (Ubuntu 18.04 includes 3.10 which is too old)
    wget -O - \
        https://apt.kitware.com/keys/kitware-archive-latest.asc | \
        gpg --dearmor - | \
        tee /etc/apt/trusted.gpg.d/kitware.gpg && \
    apt-add-repository -y 'deb https://apt.kitware.com/ubuntu/ bionic main' && \
    apt-get update && \
    apt-get -y --no-install-recommends install cmake & \
    # Clean
    apt-get clean

# Relink OpenCV against ffmpeg
RUN cd /opt && \
    wget https://github.com/opencv/opencv/archive/3.4.0.zip && \
    unzip 3.4.0.zip && \
    cd opencv-3.4.0 && \
    mkdir -p build && cd build && \
    cmake \
        -DWITH_FFMPEG=ON \
        -DCMAKE_INSTALL_PREFIX=/usr \
        ../ && \
    make -j4 && \
    make install && \
    cd ../.. && \
    rm -rf opencv-3.4.0 3.4.0.zip
