FROM fedora:38

ENV TZ=Asia/Seoul

USER root
RUN dnf upgrade -y --refresh
RUN dnf install -y \
  bash \
  cmake \
  curl \
  dnf-utils \
  g++ \
  gcc \
  gdb \
  git \
  glibc-static \
  gnupg2 \
  libstdc++-static \
  passwd \
  wget
RUN curl -fsSL https://code-server.dev/install.sh | sh -s --
RUN dnf clean all
RUN rm -rf /var/cache/yum
RUN echo code | passwd root --stdin
RUN useradd code -G wheel && echo code | passwd code --stdin
RUN echo "code	ALL=(ALL:ALL)	ALL" >> /etc/sudoers
USER code
RUN mkdir -p /home/code/.config/code-server
RUN echo "bind-addr: 0.0.0.0:8080" > /home/code/.config/code-server/config.yaml && \
  echo "auth: password" >> /home/code/.config/code-server/config.yaml && \
  echo "password: code" >> /home/code/.config/code-server/config.yaml && \
  echo "cert: false" >> /home/code/.config/code-server/config.yaml && \
  echo "#!/bin/sh" > /home/code/.config/code-server/run.sh && \
  echo "/usr/bin/code-server &" >> /home/code/.config/code-server/run.sh && \
  echo "while true ; do" >> /home/code/.config/code-server/run.sh && \
  echo "  sleep 3600;" >> /home/code/.config/code-server/run.sh && \
  echo "done" >> /home/code/.config/code-server/run.sh

EXPOSE 8080
CMD ["/bin/sh", "/home/code/.config/code-server/run.sh"]