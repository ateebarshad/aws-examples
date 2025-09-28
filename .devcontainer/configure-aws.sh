#!/bin/bash
set -e

echo " Configuring AWS CLI credentials..."

mkdir -p ~/.aws

cat > ~/.aws/credentials <<EOF
[default]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
EOF

echo "✅ AWS credentials configured successfully."
