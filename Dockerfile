FROM ubuntu:latest

RUN apt-get update \
    #
    && apt-get -y install \
    fish \
    git \
    npm \
    # 不要なキャッシュを削除
    && apt-get clean \
    # default を fishに
    && chsh -s $(which fish)