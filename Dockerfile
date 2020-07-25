FROM ruby:2.7-alpine

RUN apk add --no-cache docker
RUN apk add --no-cache build-base ruby ruby-dev

RUN wget https://storage.googleapis.com/kubernetes-release/release/v1.18.6/bin/linux/amd64/kubectl
RUN chmod u+x kubectl && mv kubectl /bin/kubectl

WORKDIR /app
ADD . /app
RUN bundle install
RUN rake install

ENTRYPOINT ["/usr/local/bundle/bin/kubes"]
