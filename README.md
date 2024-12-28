# Data Masking Project using nc, sed, and Shell Scripting

## **Objective**
Create a script that:
1. Accepts sensitive data via a network connection (using `nc`).
2. Masks specific parts of the data (e.g., masking credit card numbers or email addresses).
3. Outputs the masked data to the console or saves it to a file.

---

## **Example Input and Output**
- **Input**:  
  `Name: John Doe, Email: john.doe@example.com, Card: 1234-5678-9012-3456`

- **Masked Output**:  
  `Name: John Doe, Email: j***.d**@example.com, Card: 1234-****-****-3456`

---

## **Script**
Save the following script as `data_masking.sh`:

```bash
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
```

---

## **How to Run**

### 1. **Make the script executable:**
```bash
chmod +x data_masking.sh
```

### 2. **Run the script:**
```bash
./data_masking.sh
```

### 3. **Send data to the server using another terminal:**
```bash
echo "Name: John Doe, Email: john.doe@example.com, Card: 1234-5678-9012-3456" | nc localhost 12345
```

---

## **Expected Result**
The terminal running the script will display:
```
Original: Name: John Doe, Email: john.doe@example.com, Card: 1234-5678-9012-3456
Masked: Name: John Doe, Email: j***.d**@example.com, Card: 1234-****-****-3456
```

A `masked_output.log` file will also be created with the masked data.

---

## **Extending the Project**
You can enhance the script by:
- Adding more masking rules for other sensitive data formats.
- Integrating the script into larger ETL pipelines.
- Adding error handling and logging features.

Enjoy masking your data securely! 🚀

