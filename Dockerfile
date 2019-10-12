FROM ubuntu:latest

RUN apt-get update \
    #
    && apt-get -y install \
    build-essential \
    curl \
    file \
    git \
    # fish \
    # npm \
    # 不要なキャッシュを削除
    && apt-get clean

# brewを使いたいのでuserという名のuserを作成
RUN groupadd -g 61000 docker \
    && useradd -g 61000 -l -m -s /bin/false -u 61000 user \
    && gpasswd -a user sudo

USER user

# install brew
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
ENV PATH $PATH:/home/user/.linuxbrew/bin
RUN which brew

# default を fishに
# && chsh -s $(which fish)