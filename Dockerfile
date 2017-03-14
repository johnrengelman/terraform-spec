FROM uzyexe/serverspec:2.37.2

RUN apk update && \
    apk add curl make bash gcc build-base abuild binutils git openssh && \
    rm -rf /var/cache/apk/*

ENV BUNDLE_GEMFILE /vendor/Gemfile
ENTRYPOINT ["bundle", "exec"]
WORKDIR /module

ADD ./vendor /vendor
RUN bundle install

ENV TERRAFORM_VERSION=0.8.8

RUN curl -Ls https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip && \
    unzip terraform.zip -d /usr/local/bin && \
    rm -f terraform.zip && \
    git config --global url."https://github.com/".insteadOf "ssh://git@github.com/"
