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
    && apt-get clean \
    # default を fishに
    # && chsh -s $(which fish)