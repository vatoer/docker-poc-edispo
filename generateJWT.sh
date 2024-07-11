# generateJWT.sh
#!/bin/bash

# Define the header and payload
header='{"alg":"HS256","typ":"JWT"}'
payload='{"iss":"fileserver","aud":"new-edispo","iat":'"$(date +%s)"',"nbf":'"$(date +%s)"',"exp":'$(( $(date +%s) + 31536000 ))',"data":{"username":"eoffice"}}'

# Function to perform Base64Url encoding
base64UrlEncode() {
    echo -n "$1" | openssl enc -base64 -A | tr '+/' '-_' | tr -d '='
}

# Encode the header and payload
encodedHeader=$(base64UrlEncode "$header")
encodedPayload=$(base64UrlEncode "$payload")

# Create the signature input
signatureInput="$encodedHeader.$encodedPayload"

# Read the secret key
read -sp "Enter your JWT_SECRET_KEY: " secretKey
echo

# Create the signature using HMAC SHA-256
signature=$(echo -n "$signatureInput" | openssl dgst -sha256 -hmac "$secretKey" -binary | base64UrlEncode)

# Construct the JWT
jwt="$signatureInput.$signature"

# Output the JWT
echo $jwt
