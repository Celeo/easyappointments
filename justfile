head_sha := `git rev-parse HEAD | cut -c 1-6`

default:

build-tagged:
  docker build -f Dockerfile -t celeo/zdv-easy-appointments:{{head_sha}} .

push-tagged:
  docker push celeo/zdv-easy-appointments:{{head_sha}}
