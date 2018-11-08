FROM phusion/passenger-ruby25:1.0.0

ENV HOME /root

CMD ["/sbin/my_init"]

RUN rm -f /etc/service/nginx/down

RUN rm /etc/nginx/sites-enabled/default

ADD /docker/gifinity.conf /etc/nginx/sites-enabled/gifinity.conf

RUN mkdir /home/app/gifinity

WORKDIR /home/app/gifinity

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN chown -R app:app .

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
