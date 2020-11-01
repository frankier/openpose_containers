export BUILD_GPU=$(file < snippets/build_op_gpu)
export BUILD_CPU=$(file < snippets/build_op_cpu)
export BUILD_LEGACY_GPU=$(file < snippets/build_op_legacy_gpu)
export GET_OPENPOSE=$(file < snippets/get_openpose)
export OPENPOSE_GIT=https://github.com/CMU-Perceptual-Computing-Lab/openpose.git
export OPENPOSE_BRANCH=master
export OP_PATCHES=CMakeLists.patch

all: \
	bionic/Dockerfile.nvcaffe \
	bionic/Dockerfile.multi \
	focal/Dockerfile.nvcaffe \
	focal/Dockerfile.multi \
	bionic/Singularity.nvcaffe \
	bionic/Singularity.multi \
	focal/Singularity.nvcaffe \
	focal/Singularity.multi

clean:
	rm -f \
	  bionic/CMakeLists.patch \
	  focal/CMakeLists.patch \
	  focal/rm-compute-30.patch \
	  focal/cudnn8.patch \
	  bionic/Dockerfile.nvcaffe \
	  bionic/Dockerfile.multi \
	  focal/Dockerfile.nvcaffe \
	  focal/Dockerfile.multi \
	  bionic/Singularity.nvcaffe \
	  bionic/Singularity.multi \
	  focal/Singularity.nvcaffe \
	  focal/Singularity.multi

bionic/CMakeLists.patch: patches/CMakeLists.patch
	cp $< $@

focal/CMakeLists.patch: patches/CMakeLists.patch
	cp $< $@

focal/rm-compute-30.patch: patches/rm-compute-30.patch
	cp $< $@

focal/cudnn8.patch: patches/cudnn8.patch
	cp $< $@

bionic/Dockerfile.nvcaffe: nvcaffe_template bionic/CMakeLists.patch snippets/*
	cat $< | \
	  TAG=bionic_base \
	  envsubst > $@

bionic/Dockerfile.multi: multi_template bionic/CMakeLists.patch snippets/*
	cat $< | \
	  TAG=bionic_base \
	  envsubst > $@

focal/Dockerfile.nvcaffe: nvcaffe_template focal/CMakeLists.patch focal/rm-compute-30.patch focal/cudnn8.patch snippets/*
	cat $< | \
	  TAG=focal_base \
	  OP_PATCHES="CMakeLists.patch rm-compute-30.patch cudnn8.patch" \
	  envsubst > $@

focal/Dockerfile.multi: multi_template focal/CMakeLists.patch focal/rm-compute-30.patch focal/cudnn8.patch snippets/*
	cat $< | \
	  TAG=focal_base \
	  OP_PATCHES="CMakeLists.patch rm-compute-30.patch cudnn8.patch" \
	  envsubst > $@

bionic/Singularity.nvcaffe: singularity_template
	cat $< | \
	  TAG=bionic_nvcaffe \
	  envsubst '$$TAG' > $@

bionic/Singularity.multi: singularity_template
	cat $< | \
	  TAG=bionic_multi \
	  envsubst '$$TAG' > $@

focal/Singularity.nvcaffe: singularity_template
	cat $< | \
	  TAG=focal_nvcaffe \
	  envsubst '$$TAG' > $@

focal/Singularity.multi: singularity_template
	cat $< | \
	  TAG=focal_multi \
	  envsubst '$$TAG' > $@
