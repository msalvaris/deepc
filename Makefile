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

start-notebook:
	nvidia-docker run -p 5000:5000 -v $(notebooks_dir):/mnt/notebooks $(image) \
	jupyter notebook --port=$(port) --ip=* --no-browser --notebook-dir=/mnt/notebooks

.PHONY: help pytorch