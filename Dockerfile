FROM debian:stretch

LABEL Romain Bellande <contact@berelindis.com>

ENV TERM=xterm

RUN apt-get -y update

RUN apt-get install -y apt-utils \
                       bash \
                       wget \
                       curl \
                       iputils-ping \
                       vim \
                       zsh \
                       git git-core

RUN bash -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
    && sed -i -- 's/robbyrussell/wezm+/g' /root/.zshrc \
    && echo "source /root/.oh-my-zsh/oh-my-zsh.sh" >> ~/.zshrc \
    && echo "plugins=(z dirhistory)" >> ~/.zshrc

RUN echo 'export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/.composer/vendor/bin:$PATH' >> ~/.bashrc \
    && echo 'export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/.composer/vendor/bin:$PATH' >> ~/.zshrc \
    && echo "alias sf='bin/console'" >> ~/.bashrc \
    && echo "alias ls='ls --color'" >> ~/.bashrc \
    && echo "alias ll='ls -l'" >> ~/.bashrc \
    && echo "alias la='ls -la'" >> ~/.bashrc

RUN echo 'deb http://ftp.debian.org/debian stretch-backports main' > /etc/apt/sources.list.d/backports.list && \
    apt-get update -y && \
    apt-get install -y python-certbot-nginx -t stretch-backports

RUN echo 'certbot --nginx -d $DOMAIN -n --email $EMAIL --agree-tos' >> /usr/local/bin/cert \
    && chmod +x /usr/local/bin/cert
