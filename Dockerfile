FROM ubuntu:xenial

RUN apt-get update && apt-get -y install llvm-3.7 libpq-dev ca-certificates netbase xz-utils clang-3.7 git gcc curl unzip wget

RUN curl -sSL https://get.haskellstack.org/ | sh

RUN mkdir /scisco

RUN wget -c https://github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-linux-x86_64.zip && unzip protoc-3.3.0-linux-x86_64.zip -d /usr

RUN cd /usr/bin && wget -c https://s3-us-west-2.amazonaws.com/tendermint/binaries/tendermint/v0.10.1/tendermint_0.10.1_linux_amd64.zip && unzip tendermint_0.10.1_linux_amd64.zip

WORKDIR /scisco

ADD Setup.hs        /scisco
ADD stack.yaml      /scisco
ADD scisco.cabal    /scisco
ADD run.sh          /scisco
ADD run_private.sh  /scisco
ADD genesis.json    /scisco

ADD www           /scisco/www

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && apt-get update && apt-get -y install yarn npm nodejs && ln -s /usr/bin/nodejs /usr/bin/node

RUN cd /scisco/www && yarn

RUN stack setup

ADD src           /scisco/src
ADD app           /scisco/app

RUN stack build

CMD ["/scisco/run.sh"]
