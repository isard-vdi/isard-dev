#!/bin/sh

## Container

CONTAINER=$(guix system container \
	--network \
	--share=/tmp/.X11-unix=/tmp/.X11-unix \
    	--share=/dev/kvm=/dev/kvm \
    	--share=/dev/shm=/dev/shm \
	--share=./files/nix=/nix \
	--share=.env=/data/dev/.env \
	--share=./files/home=/data/dev \
	--share=./files/home/dev=/home/dev/dev \
	--share=./files/home/.config=/data/dev/.config \
	--share=./files/home/.local=/data/dev/.local \
	--share=./files/home/.cache=/data/dev/.cache \
	isard.scm)

if [ $? == 0 ]; then
	sudo $(echo "$CONTAINER" | tail -n 1)
fi
