# Use an official Ubuntu base image
FROM ubuntu:latest

# Set environment variables
ENV ADMIN_USER=reabillaw
ENV ADMIN_PASSWORD=test

# Install necessary dependencies
RUN apt-get update && apt-get install -y wget curl unzip sudo

# Create admin user and set password
RUN useradd -m $ADMIN_USER && echo "$ADMIN_USER:$ADMIN_PASSWORD" | chpasswd && usermod -aG sudo $ADMIN_USER

# Download and install ngrok
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.zip \
    && unzip ngrok-stable-linux-amd64.zip \
    && mv ngrok /usr/local/bin/ \
    && rm ngrok-stable-linux-amd64.zip

# Add ngrok authtoken
RUN ngrok config add-authtoken 2aeX4cs4MTzYimDVm9pRpfMeg4R_7aVc58JpynJXGBZL4HTyg

# Switch to the admin user
USER $ADMIN_USER

# Expose ngrok HTTP and TCP tunnels
EXPOSE 4040 22 80

# Set the default command to run ngrok http
CMD ["ngrok", "http", "80"]
