FROM ubuntu:latest

RUN apt-get update \
    # 先に言語の設定
    && apt-get -y install locales \
    && locale-gen en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
RUN localedef -f UTF-8 -i en_US en_US.UTF-8

RUN apt-get -y install \
    build-essential \
    curl \
    file \
    git \
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

# default を fishに
RUN brew install fish
SHELL ["fish", "-c"]
RUN echo $0

# && chsh -s $(which fish)