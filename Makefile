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
	bionic/Singularity.nvcaffe \
	bionic/Singularity.multi \
	focal/Singularity.nvcaffe \
	focal/Singularity.multi

clean:
	rm \
	  bionic/Dockerfile.nvcaffe \
	  bionic/Dockerfile.multi \
	  focal/Dockerfile.nvcaffe \
	  focal/Dockerfile.multi \
	  bionic/Singularity.nvcaffe \
	  bionic/Singularity.multi \
	  focal/Singularity.nvcaffe \
	  focal/Singularity.multi

bionic/Dockerfile.nvcaffe: nvcaffe_template
	cat $< | \
	  TAG=bionic_base \
	  envsubst > $@

bionic/Dockerfile.multi: multi_template
	cat $< | \
	  TAG=bionic_base \
	  envsubst > $@

focal/Dockerfile.nvcaffe: nvcaffe_template
	cat $< | \
	  TAG=focal_base \
	  envsubst > $@

focal/Dockerfile.multi: multi_template
	cat $< | \
	  TAG=focal_base \
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
