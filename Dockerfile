FROM ubuntu:latest

RUN apt-get update \
    # 先に言語の設定
    && apt-get -y install locales \
    && locale-gen en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
RUN localedef -f UTF-8 -i en_US en_US.UTF-8

# brewに必要なパッケージを入れる
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

# gcc系と必須コマンド系
RUN brew install \
    boost \
    cmake \
    colordiff \
    gcc \
    sl \
    tree \
    wget \
    && alias diff='colordiff'

# install online judge-tools and more python tools
RUN brew install python \
    && pip3 install \
    online-judge-tools \
    selenium \
    yq

RUN brew install clang-format
RUN brew cleanup

# default を fishに
WORKDIR /home/user
RUN brew install fish
CMD ["fish"]