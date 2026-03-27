FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y sudo tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
RUN useradd -m -s /bin/bash testuser && \
    echo "testuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    mkdir -p /home/testuser/be_vim && \
    chown -R testuser:testuser /home/testuser/be_vim

USER testuser
WORKDIR /home/testuser/be_vim
COPY --chown=testuser:testuser . .

CMD ["./setup.sh"]
