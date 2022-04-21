FROM ruby:3.1.2-slim

RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    build-essential \
    sqlite3 libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LANG=C.UTF-8
ENV BUNDLE_WITHOUT=development:test
ENV BUNDLE_DEPLOYMENT=1
RUN gem install bundler

COPY --chown=1000 . /usr/src/app

WORKDIR /usr/src/app

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]