FROM ruby:2.6-slim

ADD . /app
WORKDIR /app

# Pre-install gems
RUN bundle install --path /usr/local/bundle

# Defaults
ENV PORT 5000
ENV RACK_ENV production
ENV MAIN_APP_FILE server.rb

# Expose app-server port
EXPOSE $PORT

# Create a user to run the app
RUN groupadd -r somebody && useradd -r -g somebody somebody

# Run as "somebody"
USER somebody

# Default command
CMD bundle exec rackup -p ${PORT-5000} -o '0.0.0.0'
