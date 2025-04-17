# Stage 1: Build the Flutter web app
FROM --platform=linux/amd64 dart:stable AS build

# Set working directory
WORKDIR /app

# Install Flutter
RUN apt-get update && \
    apt-get install -y curl git unzip xz-utils zip libglu1-mesa && \
    apt-get clean && \
    git clone https://github.com/flutter/flutter.git -b stable /flutter

# Add flutter to path
ENV PATH="/flutter/bin:$PATH"

# Copy the project files
COPY . .

# Enable Flutter web
RUN flutter config --enable-web

# Get Flutter packages
RUN flutter pub get

# Build the web app
RUN flutter build web --release

# Stage 2: Create a lightweight web server to serve the application
FROM --platform=linux/amd64 nginx:alpine

# Copy the built web app from the previous stage
COPY --from=build /app/build/web /usr/share/nginx/html

# Copy the custom nginx config if you need specific settings
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
