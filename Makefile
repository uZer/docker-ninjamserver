default: docker_build

docker_build:
	@docker build \
		--build-arg CONTAINER_VCS_REF=`git rev-parse --short HEAD` \
		--build-arg CONTAINER_BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` . -t ninjam

run:
	@docker run --rm -it ninjam
