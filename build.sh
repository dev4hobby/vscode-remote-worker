#!/bin/sh
docker build -t ssh-remote-server:v1.0.0 .
docker run --name ssh-remote-server \
  --cap-add=SYS_PTRACE \
  --security-opt="seccomp=unconfined" \
  --tmpfs /tmp \
  -dit \
  -p 22:22 \
  --restart always \
  code-server:v1.0.0