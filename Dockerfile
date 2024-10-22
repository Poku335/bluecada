# Use an official Ruby runtime as a parent image
FROM ruby:3.3.3

# Set environment variables
ENV RAILS_VERSION 3.3.3

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set the working directory
WORKDIR /app

# Install Bundler
RUN gem install bundler

# Copy the Gemfile and Gemfile.lock into the image
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Install the gems specified in the Gemfile
RUN bundle install

# Copy the rest of the application code
COPY . /app

# Expose the port the app runs on
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
