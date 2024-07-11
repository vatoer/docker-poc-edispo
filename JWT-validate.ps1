# Define the constants
$issuer = "filserver"
$audience = "eoffice"
$algorithm = "HS256"  # Assuming HS256 as the algorithm

# Function to create the Base64Url-decoded byte array
function Base64UrlDecode {
    param (
        [string]$base64Url
    )
    $base64 = $base64Url.Replace('-', '+').Replace('_', '/')
    switch ($base64.Length % 4) {
        2 { $base64 += '==' }
        3 { $base64 += '=' }
    }
    return [Convert]::FromBase64String($base64)
}

# Function to validate the JWT
function ValidateJWT {
    param (
        [string]$token,
        [string]$secretKey
    )

    # Split the JWT into its parts
    $parts = $token -split '\.'
    if ($parts.Length -ne 3) {
        throw "Invalid JWT format"
    }

    $header = $parts[0]
    $payload = $parts[1]
    $signature = $parts[2]

    # Decode the header and payload
    $decodedHeader = [Text.Encoding]::UTF8.GetString((Base64UrlDecode $header))
    $decodedPayload = [Text.Encoding]::UTF8.GetString((Base64UrlDecode $payload))

    # Parse the header as JSON
    $headerJson = $decodedHeader | ConvertFrom-Json

    # Check the algorithm
    if ($headerJson.alg -ne $algorithm) {
        throw "Invalid JWT algorithm"
    }

    # Recreate the signature
    $hmac = New-Object System.Security.Cryptography.HMACSHA256
    $hmac.Key = [Text.Encoding]::UTF8.GetBytes($secretKey)
    $dataToSign = "$header.$payload"
    $computedSignature = $hmac.ComputeHash([Text.Encoding]::UTF8.GetBytes($dataToSign))
    $computedSignatureEncoded = [Convert]::ToBase64String($computedSignature).Replace('+', '-').Replace('/', '_').TrimEnd('=')

    # Verify the signature
    if ($computedSignatureEncoded -ne $signature) {
        throw "Invalid JWT signature"
    }

    # Parse the payload as JSON
    $payloadJson = $decodedPayload | ConvertFrom-Json

    # Validate the claims
    if ($payloadJson.iss -ne $issuer) {
        throw "Invalid issuer"
    }
    if ($payloadJson.aud -ne $audience) {
        throw "Invalid audience"
    }

    # Validate token expiry
    $expUnixTime = [long]$payloadJson.exp
    $expDateTime = (Get-Date "1970-01-01T00:00:00Z").AddSeconds($expUnixTime)
    if ([DateTime]::UtcNow -gt $expDateTime) {
        throw "Token has expired"
    }

    return $payloadJson
}

# Example usage
$token = Read-Host -Prompt "Enter JWT"
$secretKey = Read-Host -Prompt "Enter your JWT_SECRET_KEY" -AsSecureString
$plainSecretKey = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secretKey))

try {
    $payload = ValidateJWT -token $token -secretKey $plainSecretKey
    Write-Output "JWT is valid. Payload:"
    Write-Output $payload
}
catch {
    Write-Error $_.Exception.Message
}
