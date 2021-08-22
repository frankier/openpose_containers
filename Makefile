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
	focal/Dockerfile.cpu \
	focal/Dockerfile.multi

clean:
	rm -f \
	  bionic/*.patch \
	  bionic/openpose_env_* \
	  bionic/*.cxx \
	  bionic/.assets \
	  focal/*.patch \
	  focal/*.cxx \
	  focal/openpose_env_* \
	  focal/.assets \
	  bionic/Dockerfile.nvcaffe \
	  bionic/Dockerfile.multi \
	  focal/Dockerfile.nvcaffe \
	  focal/Dockerfile.multi

bionic/.assets: \
	  patches/CMakeLists.patch \
	  patches/python37.patch \
	  patches/respect_mkldnnroot.patch \
	  patches/rm-ampere-cuda10.patch \
	  scripts/openpose_env_multi \
	  scripts/openpose_env_nvcaffe \
	  scripts/openpose_entrypoint \
	  scripts/cudacap.cxx
	cp $^ bionic/ && touch $@

focal/.assets: \
	  patches/CMakeLists.patch \
	  patches/respect_mkldnnroot.patch \
	  patches/rm-ampere-cuda10.patch \
	  scripts/openpose_env_multi \
	  scripts/openpose_env_nvcaffe \
	  scripts/openpose_env_cpu \
	  scripts/openpose_entrypoint \
	  scripts/cudacap.cxx
	cp $^ focal/ && touch $@

bionic/Dockerfile.nvcaffe: nvcaffe_template bionic/.assets snippets/*
	cat $< | \
	  TAG=bionic_base \
	  OP_PATCHES="rm-ampere-cuda10.patch python37.patch" \
	  envsubst > $@

bionic/Dockerfile.multi: multi_template bionic/.assets snippets/*
	cat $< | \
	  TAG=bionic_base \
	  OP_PATCHES="rm-ampere-cuda10.patch python37.patch respect_mkldnnroot.patch" \
	  envsubst > $@

focal/Dockerfile.nvcaffe: nvcaffe_template focal/.assets snippets/*
	cat $< | \
	  TAG=focal_base \
	  OP_PATCHES="rm-ampere-cuda10.patch" \
	  envsubst > $@

focal/Dockerfile.cpu: cpu_template focal/.assets snippets/*
	cat $< | \
	  TAG=focal_cpubase \
	  OP_PATCHES="respect_mkldnnroot.patch" \
	  envsubst > $@

focal/Dockerfile.multi: multi_template focal/.assets snippets/*
	cat $< | \
	  TAG=focal_base \
	  OP_PATCHES="rm-ampere-cuda10.patch respect_mkldnnroot.patch" \
	  envsubst > $@
