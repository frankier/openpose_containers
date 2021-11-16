This repository builds Docker images for OpenPose compiled with NVCaffe. They have also been tested with Singularity. Check out the different versions in the [Packages](https://github.com/frankier?tab=packages&repo_name=openpose_containers) section.

It currently has two bases:

 1. `bionic`: Based upon the `nvcr.io/nvidia/caffe:20.03-py3` Ubuntu 18.04 LTS (bionic) image provided by NVidia. [More info about the base is available from NVidia.](https://docs.nvidia.com/deeplearning/frameworks/caffe-release-notes/rel_20-03.html#rel_20-03) It contains dependencies of OpenPose including NVCaffe and OpenCV. It has been upgraded with a newer versions of some packages and otherwise tweaked to make a viable OpenPose build environment. It has the following versions:
  * CUDA 10.2
  * Python 3.7 (upgraded version from universe)
  * OpenCV 3.4.1 (upgraded version from PPA)
 2. `focal`: Based upon the `ubuntu:focal` image. It compiles NVCaffe with
    patches to make it compile in this newer environment. It has the following
    versions:
  * CUDA 10.2
  * Python 3.8 (default)
  * OpenCV 4.2.0 (default)

Upon these bases OpenPose there are multiple images built. For example, for
`focal` these are the following images:

 * `focal_cpu`: Contains OpenPose built against an Intel MKL optimised CPU Caffe
 * `focal_nvcaffe`: Contains OpenPose built against an NVidia optimised NVCaffe
 * `focal_multi`: Contains both of the above versions, as well as normal GPU
   Caffe. The entrypoint script automatically configures the correct version of
   OpenPose.

The multi OpenPose container concept is based upon [this blog post by Peter
Uhrig](peter-uhrig.de/openpose-with-nvcaffe-in-a-singularity-container-with-support-for-multiple-architectures/).
