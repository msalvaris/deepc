define PROJECT_HELP_MSG
Usage:
    make help                           show this message
    make pytorch                    	remove model
endef
export PROJECT_HELP_MSG

registry:=deepc
notebooks_dir?=.
port?=9999
image:=$(registry)/pytorch

help:
	@echo "$$PROJECT_HELP_MSG" | less

pytorch:
	docker build -t $(registry)/pytorch -f pytorch/dockerfile .

tf:
	docker build -t $(registry)/tensorflow -f tensorflow/dockerfile .

mxnet:
	docker build -t $(registry)/mxnet -f mxnet/dockerfile .

keras:
	docker build -t $(registry)/keras -f keras/dockerfile .

cntk:
	docker build -t $(registry)/cntk -f cntk/dockerfile .

chainer:
	docker build -t $(registry)/chainer -f chainer/dockerfile .

caffe2:
	docker build -t $(registry)/caffe2 -f caffe2/dockerfile .

start-notebook:
	nvidia-docker run -p 5000:5000 -v $(notebooks_dir):/mnt/notebooks $(image) \
	jupyter notebook --port=$(port) --ip=* --no-browser --notebook-dir=/mnt/notebooks

.PHONY: help pytorch