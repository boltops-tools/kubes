FROM ruby:2.7

COPY docker docker
RUN docker/install/docker.sh
RUN docker/install/gcloud.sh
ENV PATH=/opt/google/google-cloud-sdk/bin/:$PATH
RUN docker/install/kubectl.sh

WORKDIR /app
ADD . /app
RUN bundle install
RUN rake install

ENTRYPOINT ["/usr/local/bundle/bin/kubes"]
