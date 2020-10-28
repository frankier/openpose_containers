<p align="center">
<a href="https://hub.docker.com/r/frankierr/openpose_containers/builds">
  <img alt="DockerHub hosted images" src="https://img.shields.io/docker/cloud/build/frankierr/openpose_containers?label=Docker&style=flat" />
</a>
<a href="https://singularity-hub.org/collections/4910">
  <img alt="SingularityHub hosted images" src="https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg" />
</a>
</p>

This repository builds Singularity images for OpenPose. It is based on [this
blog post by Peter
Uhrig](peter-uhrig.de/openpose-with-nvcaffe-in-a-singularity-container-with-support-for-multiple-architectures/).

It builds three versions of OpenPose:

 1. A CPU version
 2. A GPU version with normal Caffe
 3. A GPU version with NVCaffe

At runtime, the container configures itself to use the correct one.

This repository first builds a Docker base on Docker Hub, upon which
a Singularity container is built on Singularity Hub.

To rebuild Singularity files:
1. Directly make your changes to `singularity_template`.
2. Run `make`.
3. Add and push both `singularity_template` and the generated files so they can
   be build on Singularity Hub

For older versions see: https://github.com/frankier/gsoc2020/commits/master/openpose_singularity
