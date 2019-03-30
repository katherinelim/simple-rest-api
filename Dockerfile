FROM ruby:2.6-slim

ADD . /app
WORKDIR /app

# Pre-install gems
# COPY Gemfile /app/Gemfile
# COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install --path /usr/local/bundle

# COPY app/server.rb /app/server.rb
# COPY appmeta.yml /app/appmeta.yml
# WORKDIR /app

# Defaults
ENV PORT 5000
ENV RACK_ENV production
ENV MAIN_APP_FILE app.rb

# Expose app-server port
EXPOSE $PORT

# Create a user to run the app
RUN groupadd -r somebody && useradd -r -g somebody somebody

# Run as "somebody"
USER somebody

# Default command
CMD bundle exec rackup -p ${PORT-5000} -o '0.0.0.0'
