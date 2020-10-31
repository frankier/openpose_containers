<p align="center">
<a href="https://hub.docker.com/r/frankierr/openpose_containers/builds">
  <img alt="DockerHub hosted images" src="https://img.shields.io/docker/cloud/build/frankierr/openpose_containers?label=Docker&style=flat" />
</a>
<a href="https://singularity-hub.org/collections/4910">
  <img alt="SingularityHub hosted images" src="https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg" />
</a>
</p>

This repository builds Docker and Singularity images for OpenPose compiled with
NVCaffe.

It currently has two bases, which are in turn based upon:

 1. `bionic`: Based upon the `nvcr.io/nvidia/caffe:20.03-py3` Ubuntu 18.04 LTS (bionic) image provided by NVidia. [More info about the base is available from NVidia.](https://docs.nvidia.com/deeplearning/frameworks/caffe-release-notes/rel_20-03.html#rel_20-03) It contains dependencies of OpenPose including NVCaffe and OpenCV. It has been upgraded with a newer versions of some packages and otherwise tweaked to make a viable OpenPose build environment. It has the following versions:
  * CUDA 10.2
  * Python 3.7 (upgraded version from universe)
  * OpenCV 3.4.1 (upgrade version from PPA)
 2. `focal`: Based upon the `nvidia/cuda:11.1-devel-ubuntu20.04` image. It
    compiles NVCaffe with patches to make it compile in this newer environment. It has the following versions:
  * CUDA 11.1
  * Python 3.8 (default)
  * OpenCV 4.2.0 (default)

Upon these bases OpenPose is built either against NVCaffe or else multiple
versions are compiled with the following configurations:

 1. A CPU version with CPU Caffe
 2. A GPU version with normal Caffe
 3. A GPU version with NVCaffe

Upon these Docker bases, Singularity images which automatically select the
correct version of OpenPose at runtime are made available.

The multi OpenPose container concept is based upon [this blog post by Peter
Uhrig](peter-uhrig.de/openpose-with-nvcaffe-in-a-singularity-container-with-support-for-multiple-architectures/).

# Get the images

Get the images from [Docker
Hub](https://hub.docker.com/r/frankierr/openpose_containers/) or [Singularity
Hub](https://singularity-hub.org/collections/4910).

# Rebuilding from templates

To rebuild Singularity files:
1. Directly make your changes to one of the `*_template` files or a file in
   `snippets`.
2. Run `make`.
3. Add and push both all changes generated files so they can
   be build on Docker and Singularity Hub

For older versions see:
https://github.com/frankier/gsoc2020/commits/master/openpose_singularity
