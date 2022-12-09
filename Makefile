UDEVRULEDIR := /etc/udev/rules.d

all: installudevrules build

.PHONY:installudevrules
installudevrules:
	@echo Installing Kinect and Vrui devices permission udev rule in $(UDEVRULEDIR)
	@install -m u=rw,go=r 69-Kinect.rules $(UDEVRULEDIR)
	@install -m u=rw,go=r 69-Vrui-devices.rules $(UDEVRULEDIR)/69-Vrui-devices.rules

.PHONY:build
build:
	@docker-compose build

.PHONY:nvidia-dockerfile
nvidia-dockerfile:
	@cat Dockerfile > Dockerfile.nvidia
	@sed -i "s/FROM ubuntu:18.04/FROM nvcr.io\/nvidia\/driver:525.60.13-ubuntu18.04/g" Dockerfile.nvidia
