FROM ruby:2.5.1

RUN gem install rails:5.0.1 bundler:1.13.6 \
    && apt-get update && apt-get install -y -qq --no-install-recommends nodejs

WORKDIR /opt/fullstack_app

COPY Gemfile Gemfile.lock ./

RUN bundle install

EXPOSE ${PORT:-3000}

CMD rails server -p ${PORT:-3000} -b "0.0.0.0"