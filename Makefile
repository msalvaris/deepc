define PROJECT_HELP_MSG
Usage:
    make help                           show this message
    make pytorch                    	remove model
endef
export PROJECT_HELP_MSG

registry:=deepc
notebooks_dir?=$(PWD)
port?=9999
image:=$(registry)/pytorch36

help:
	@echo "$$PROJECT_HELP_MSG" | less

base:
	docker build -t $(registry)/base36 -f base/dockerfile .

all: pytorch tf mxnet keras cntk chainer
	@echo "All containers built"

pytorch: base
	docker build -t $(registry)/pytorch36 -f pytorch/dockerfile .

tf: base
	docker build -t $(registry)/tensorflow36 -f tensorflow/dockerfile .

mxnet: base
	docker build -t $(registry)/mxnet36 -f mxnet/dockerfile .

keras: base
	docker build -t $(registry)/keras36 -f keras/dockerfile .

cntk: base
	docker build -t $(registry)/cntk36 -f cntk/dockerfile .

chainer: base
	docker build -t $(registry)/chainer36 -f chainer/dockerfile .

caffe2: base
	docker build -t $(registry)/caffe236 -f caffe2/dockerfile .

start-notebook:
	nvidia-docker run -p $(port):$(port) -it -v $(notebooks_dir):/workspace/notebooks $(image) \
	jupyter notebook --port=$(port) --ip=* --no-browser --allow-root

.PHONY: help pytorch mxnet tf keras cntk chainer caffe2 base