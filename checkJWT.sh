# checkJWT.sh
#!/bin/bash

# Prompt for the JWT
read -p "Enter the JWT: " jwt

# Prompt for the secret key
read -sp "Enter your JWT_SECRET_KEY: " secretKey
echo

# Split the JWT into its components
IFS='.' read -ra TOKEN <<< "$jwt"
header=${TOKEN[0]}
payload=${TOKEN[1]}
signature=${TOKEN[2]}

# Function to perform Base64Url decoding
base64UrlDecode() {
    local len=$((${#1} % 4))
    local result="$1"
    if [ $len -eq 2 ]; then result="$1"'=='
    elif [ $len -eq 3 ]; then result="$1"'='
    fi
    echo "$result" | tr '_-' '/+' | openssl enc -d -base64 -A
}

# Function to perform Base64Url encoding
base64UrlEncode() {
    echo -n "$1" | openssl enc -base64 -A | tr '+/' '-_' | tr -d '='
}

# Decode and display the header and payload
echo "Header:"
headerDecoded=$(base64UrlDecode "$header")
echo "$headerDecoded"

echo "Payload:"
payloadDecoded=$(base64UrlDecode "$payload")
echo "$payloadDecoded"

# Verify the signature
signatureInput="$header.$payload"
expectedSignature=$(echo -n "$signatureInput" | openssl dgst -sha256 -hmac "$secretKey" -binary | base64UrlEncode)

if [ "$expectedSignature" == "$signature" ]; then
    echo "The JWT signature is valid."
else
    echo "The JWT signature is invalid."
fi
