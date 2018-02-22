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
	docker build -t $(registry)/base:p36-cuda9-cudnn7-devel -f base/dockerfile .

all: pytorch tf mxnet keras cntk chainer caffe2
	@echo "All containers built"

push-all: push-pytorch push-tf push-mxnet push-keras push-cntk push-chainer push-caffe2
	@echo "All containers built"

pytorch: base
	docker build -t $(registry)/pytorch:p36-cuda9-cudnn7-devel -f pytorch/dockerfile .

push-pytorch: pytorch
	docker push $(registry)/pytorch:p36-cuda9-cudnn7-devel

tf: base
	docker build -t $(registry)/tensorflow:p36-cuda9-cudnn7-devel -f tensorflow/dockerfile .

push-tf: tf
	docker push $(registry)/tensorflow:p36-cuda9-cudnn7-devel

mxnet: base
	docker build -t $(registry)/mxnet:p36-cuda9-cudnn7-devel -f mxnet/dockerfile .

push-mxnet: mxnet
	docker push $(registry)/mxnet:p36-cuda9-cudnn7-devel

keras: base
	docker build -t $(registry)/keras:p36-cuda9-cudnn7-devel -f keras/dockerfile .

push-keras: keras
	docker push $(registry)/keras:p36-cuda9-cudnn7-devel

cntk: base
	docker build -t $(registry)/cntk:p36-cuda9-cudnn7-devel -f cntk/dockerfile .

push-cntk: cntk
	docker push $(registry)/cntk:p36-cuda9-cudnn7-devel

chainer: base
	docker build -t $(registry)/chainer:p36-cuda9-cudnn7-devel -f chainer/dockerfile .

push-chainer: chainer
	docker push $(registry)/chainer:p36-cuda9-cudnn7-devel

caffe2: base
	docker build -t $(registry)/caffe2:p36-cuda9-cudnn7-devel -f caffe2/dockerfile .

push-caffe2: caffe2
	docker push $(registry)/caffe2:p36-cuda9-cudnn7-devel

start-notebook:
	nvidia-docker run -p $(port):$(port) -it -v $(notebooks_dir):/workspace/notebooks $(image) \
	jupyter notebook --port=$(port) --ip=* --no-browser --allow-root

.PHONY: help pytorch mxnet tf keras cntk chainer caffe2 base