export BUILD_GPU=$(file < snippets/build_op_gpu)
export BUILD_CPU=$(file < snippets/build_op_cpu)
export BUILD_LEGACY_GPU=$(file < snippets/build_op_legacy_gpu)
export GET_OPENPOSE=$(file < snippets/get_openpose)
export OPENPOSE_GIT=https://github.com/CMU-Perceptual-Computing-Lab/openpose.git
export OPENPOSE_BRANCH=master

all: \
	bionic/Dockerfile.nvcaffe \
	bionic/Dockerfile.multi \
	focal/Dockerfile.nvcaffe \
	focal/Dockerfile.multi \
	bionic/Singularity.bionic_nvcaffe \
	bionic/Singularity.bionic_multi \
	focal/Singularity.focal_nvcaffe \
	focal/Singularity.focal_multi

clean:
	rm -f \
	  bionic/*.patch \
	  bionic/.patches \
	  focal/*.patch \
	  focal/.patches \
	  bionic/Dockerfile.nvcaffe \
	  bionic/Dockerfile.multi \
	  focal/Dockerfile.nvcaffe \
	  focal/Dockerfile.multi \
	  bionic/Singularity.bionic_nvcaffe \
	  bionic/Singularity.bionic_multi \
	  focal/Singularity.focal_nvcaffe \
	  focal/Singularity.focal_multi

bionic/.patches: patches/CMakeLists.patch patches/python37.patch
	cp $^ bionic/ && touch $@

focal/.patches: patches/CMakeLists.patch patches/rm-compute-30.patch patches/cudnn8.patch
	cp $^ focal/ && touch $@

bionic/Dockerfile.nvcaffe: nvcaffe_template bionic/.patches snippets/*
	cat $< | \
	  TAG=bionic_base \
	  OP_PATCHES="CMakeLists.patch python37.patch" \
	  envsubst > $@

bionic/Dockerfile.multi: multi_template bionic/.patches snippets/*
	cat $< | \
	  TAG=bionic_base \
	  OP_PATCHES="CMakeLists.patch python37.patch" \
	  envsubst > $@

focal/Dockerfile.nvcaffe: nvcaffe_template focal/.patches focal/rm-compute-30.patch focal/cudnn8.patch snippets/*
	cat $< | \
	  TAG=focal_base \
	  OP_PATCHES="CMakeLists.patch rm-compute-30.patch cudnn8.patch" \
	  envsubst > $@

focal/Dockerfile.multi: multi_template focal/.patches focal/rm-compute-30.patch focal/cudnn8.patch snippets/*
	cat $< | \
	  TAG=focal_base \
	  OP_PATCHES="CMakeLists.patch rm-compute-30.patch cudnn8.patch" \
	  envsubst > $@

bionic/Singularity.bionic_nvcaffe: singularity_template
	cat $< | \
	  TAG=bionic_nvcaffe \
	  envsubst '$$TAG' > $@

bionic/Singularity.bionic_multi: singularity_template
	cat $< | \
	  TAG=bionic_multi \
	  envsubst '$$TAG' > $@

focal/Singularity.focal_nvcaffe: singularity_template
	cat $< | \
	  TAG=focal_nvcaffe \
	  envsubst '$$TAG' > $@

focal/Singularity.focal_multi: singularity_template
	cat $< | \
	  TAG=focal_multi \
	  envsubst '$$TAG' > $@
