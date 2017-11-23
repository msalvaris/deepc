define PROJECT_HELP_MSG
Usage:
    make help                           show this message
    make pytorch                    	remove model
endef
export PROJECT_HELP_MSG

registry:=deepc

help:
	@echo "$$PROJECT_HELP_MSG" | less

pytorch:
	docker build -t $(registry)/pytorch -f pytorch/dockerfile .

start-server:
	nvidia-docker run -p 5000:5000 $(registry)/pytorch jupyter notebook --port=9999 --ip=* --no-browser

.PHONY: help pytorch