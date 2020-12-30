#!/bin/sh

## Container

CONTAINER=$(guix system container \
	--network \
	--share=/tmp/.X11-unix=/tmp/.X11-unix \
    	--share=/dev/kvm=/dev/kvm \
    	--share=/dev/shm=/dev/shm \
	--share=.env=/data/dev/.env \
	--share=./files/nix=/nix \
	--share=./files/home=/data/dev \
	isard.scm)

if [ $? == 0 ]; then
	sudo $(echo "$CONTAINER" | tail -n 1)
fi
