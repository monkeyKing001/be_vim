# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y vim curl git python3 python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node.js (LTS version)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /root

# Copy the Python script into the container
COPY setup_vim.py .

# Make the script executable
RUN chmod +x setup_vim.py

# Run the Python script when the container starts
CMD ["./setup_vim.py"]
