$secretKey = Read-Host -Prompt "Enter your JWT_SECRET_KEY" -AsSecureString

# Define the parameters
$username = "eoffice"
$issuer = "fileserver"
$audience = "new-edispo"
# $secretKey = "your_secret_key_here"
$algorithm = "HS256" # Make sure this matches the algorithm used in PHP

# Define the payload
$payload = @{
    iss = $issuer
    aud = $audience
    iat = [DateTimeOffset]::Now.ToUnixTimeSeconds()
    nbf = [DateTimeOffset]::Now.ToUnixTimeSeconds()
    exp = [DateTimeOffset]::Now.ToUnixTimeSeconds() + 31536000 # 1 year
    data = @{
        username = $username
    }
}

# Convert the payload to JSON
$payloadJson = $payload | ConvertTo-Json -Compress

# Encode the payload to Base64Url
$payloadBase64Url = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($payloadJson)).TrimEnd('=').Replace('+', '-').Replace('/', '_')

# Create the header
$header = @{
    alg = $algorithm
    typ = "JWT"
}

# Convert the header to JSON
$headerJson = $header | ConvertTo-Json -Compress

# Encode the header to Base64Url
$headerBase64Url = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($headerJson)).TrimEnd('=').Replace('+', '-').Replace('/', '_')

# Create the signature input
$signatureInput = "$headerBase64Url.$payloadBase64Url"

# Create the HMACSHA256 signature
$hmacsha256 = New-Object System.Security.Cryptography.HMACSHA256
$hmacsha256.Key = [System.Text.Encoding]::UTF8.GetBytes($secretKey)
$signatureBytes = $hmacsha256.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($signatureInput))

# Encode the signature to Base64Url
$signatureBase64Url = [Convert]::ToBase64String($signatureBytes).TrimEnd('=').Replace('+', '-').Replace('/', '_')

# Create the JWT token
$token = "$signatureInput.$signatureBase64Url"

# Output the token
Write-Output $token