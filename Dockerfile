FROM ubuntu:latest

RUN apt-get update \
    # 先に日本語を入れておく
    && apt-get -y install language-pack-ja \
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
    groupadd -g 61000 docker \
    && useradd -g 61000 -l -m -s /bin/false -u 61000 user \
    && gpasswd -a user sudo

USER user

# install brew
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
ENV PATH $PATH:/home/user/.linuxbrew/bin

# default を fishに
RUN brew install fish
SHELL ["fish", "-c"]
RUN echo $0

# && chsh -s $(which fish)