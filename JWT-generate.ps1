# Define the constants
$issuer = "filserver"
$audience = "eoffice"
$algorithm = "HS256"  # Assuming HS256 as the algorithm

# Function to create the Base64Url-encoded string
function Base64UrlEncode {
    param (
        [string]$data
    )
    $base64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($data))
    $base64Url = $base64.TrimEnd('=') -replace '\+', '-' -replace '/', '_'
    return $base64Url
}

# Function to create the Base64Url-encoded byte array
function Base64UrlEncodeBytes {
    param (
        [byte[]]$data
    )
    $base64 = [Convert]::ToBase64String($data)
    $base64Url = $base64.TrimEnd('=') -replace '\+', '-' -replace '/', '_'
    return $base64Url
}

# Function to create the JWT
function GenerateToken {
    param (
        [string]$username,
        [string]$secretKey
    )

    # Define the header
    $header = @{
        "alg" = $algorithm
        "typ" = "JWT"
    }

    # Define the payload
    $payload = @{
        "iss"  = $issuer
        "aud"  = $audience
        "iat"  = [math]::Round((Get-Date).ToUniversalTime().Subtract((Get-Date "1970-01-01T00:00:00Z").ToUniversalTime()).TotalSeconds)
        "nbf"  = [math]::Round((Get-Date).ToUniversalTime().Subtract((Get-Date "1970-01-01T00:00:00Z").ToUniversalTime()).TotalSeconds)
        "exp"  = [math]::Round((Get-Date).ToUniversalTime().AddYears(1).Subtract((Get-Date "1970-01-01T00:00:00Z").ToUniversalTime()).TotalSeconds)
        "data" = @{
            "username" = $username
        }
    }

    # Encode header and payload
    $headerEncoded = Base64UrlEncode (ConvertTo-Json $header)
    $payloadEncoded = Base64UrlEncode (ConvertTo-Json $payload)

    # Create the signature input
    $signatureInput = "$headerEncoded.$payloadEncoded"

    # Generate the signature using .NET libraries
    $hmacsha256 = New-Object System.Security.Cryptography.HMACSHA256
    $hmacsha256.Key = [Text.Encoding]::UTF8.GetBytes($secretKey)
    $signature = $hmacsha256.ComputeHash([Text.Encoding]::UTF8.GetBytes($signatureInput))
    $signatureEncoded = Base64UrlEncodeBytes($signature)

    # Return the JWT
    return "$signatureInput.$signatureEncoded"
}

# Prompt the user for input
$username = Read-Host -Prompt "Enter username"
$secureSecretKey = Read-Host -Prompt "Enter JWT_SECRET_KEY" -AsSecureString

# Convert the SecureString to plain text
$ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureSecretKey)
$secretKey = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($ptr)

# Generate the token
$token = GenerateToken -username $username -secretKey $secretKey
Write-Output $token

# Clean up the SecureString
[System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptr)
