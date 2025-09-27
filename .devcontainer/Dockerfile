# Use Ubuntu as base
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && sudo ./aws/install \
 && rm -rf awscliv2.zip aws