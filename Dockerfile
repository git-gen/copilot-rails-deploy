
FROM ruby:2.7.0-alpine3.11

ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

RUN apk update && \
  apk upgrade && \
  apk add --no-cache \
  gcc \
  g++ \
  git \
  libc-dev \
  libxml2-dev \
  linux-headers \
  make \
  nodejs \
  mariadb-dev \
  tzdata && \
  apk add --virtual build-packs --no-cache \
  build-base \
  curl-dev

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
RUN apk del build-packs

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
