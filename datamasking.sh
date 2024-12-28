#!/bin/bash

# Define the port for nc to listen on
PORT=12345

echo "Starting Data Masking Server on port $PORT..."
echo "Waiting for input..."

# Start nc to listen for incoming data
nc -lk $PORT | while read -r line; do
    # Mask email addresses
    masked_email=$(echo "$line" | sed -E 's/([a-zA-Z])[a-zA-Z]*\.([a-zA-Z])[a-zA-Z]*@/\1***.\2**@/g')

    # Mask credit card numbers
    masked_data=$(echo "$masked_email" | sed -E 's/([0-9]{4})-[0-9]{4}-[0-9]{4}-([0-9]{4})/\1-****-****-\2/g')

    # Output the masked data
    echo "Original: $line"
    echo "Masked: $masked_data"

    # Optionally save to a file
    echo "$masked_data" >> masked_output.log
done

