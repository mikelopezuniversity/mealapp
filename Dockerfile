FROM ruby
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  postgresql-client nodejs yarn && rm -rf /var/lib/apt/lists

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .
VOLUME ["/usr/src/app"]

EXPOSE 3000
CMD [ "rails", "server", "-b", "0.0.0.0" ]
