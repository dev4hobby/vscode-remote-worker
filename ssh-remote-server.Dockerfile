FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

USER root
RUN apt update \
  && apt upgrade -y -q \
  && apt install -y -q \
    --no-install-recommends \
    ca-certificates \
    cmake \
    curl \
    g++ \
    gcc \
    gdb \
    git \
    gnupg2 \
    make \
    openssh-server \
    sudo \
    zsh \
  && apt clean \
  && rm -rf /var/lib/apt/lists/*
RUN echo 'root:code' | chpasswd
RUN mkdir -pv /home/code
RUN useradd -m -d /home/code -s /bin/zsh code && echo 'code:code' | chpasswd
RUN chown code:code /home/code
RUN echo "code ALL=(ALL:ALL) ALL" >> /etc/sudoers
RUN /usr/bin/ssh-keygen -A
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN echo "#!/bin/sh" > /usr/sbin/sshd-start && \
  echo "service ssh restart && /bin/sh" >> /usr/sbin/sshd-start && \
  chmod +x /usr/sbin/sshd-start
USER code
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
USER root

EXPOSE 22

CMD ["/bin/sh", "-c", "/usr/sbin/sshd-start"]
