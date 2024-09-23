FROM ruby:3.3.3

# Install necessary dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config postgresql-client dos2unix && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV SECRET_KEY_BASE=9b7c55e2a40b9413c98d41948d2bc8008efedc3817a3ee25d4bff311238fbab87c157bf37ff3bdbb64a9eae5cd79742db147e2b5c9b2f248dd3ae7578d


# Set working directory
WORKDIR /usr/src/app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --jobs 4 --retry 3

# Copy the rest of the application code
COPY . .

# Fix EOL characters for scripts
RUN find /usr/src/app -type f -exec dos2unix {} \;

RUN dos2unix bin/delayed_job

# Ensure the bin/rails and bin/delayed_job scripts are executable
RUN chmod +x bin/rails bin/delayed_job

# Expose the port the app runs on
EXPOSE 3000

# Start the Rails server and delayed_job
CMD ["sh", "-c", "bin/rails db:seed && bin/rails server -b 0.0.0.0 -p 3000 & bin/delayed_job start"]