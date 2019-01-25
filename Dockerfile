FROM ruby:2.3.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs cron

ADD crontab /etc/cron.d/bidagg
RUN chmod 0644 /etc/cron.d/bidagg
RUN crontab /etc/cron.d/bidagg
RUN touch /var/log/cron.log
RUN printenv | grep -v "no_proxy" >> /etc/environment

ENV INSTALL_PATH /rtb4free_admin
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install
COPY . ./
EXPOSE 3000
