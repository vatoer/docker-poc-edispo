# Prompt the user to enter a password
$password = Read-Host -Prompt "Enter your password" -AsSecureString

# Function to generate a BCrypt hash
function GenerateBCryptHash([SecureString] $password) {
    $bcrypt = New-Object 'System.Security.Cryptography.Rfc2898DeriveBytes' -ArgumentList $password, 16, 10
    $salt = $bcrypt.Salt
    $hash = $bcrypt.GetBytes(24)
    $saltBase64 = [Convert]::ToBase64String($salt)
    $hashBase64 = [Convert]::ToBase64String($hash)
    return '$2y$10$' + $saltBase64 + $hashBase64
}

# Generate the hashed password
$hashedPassword = GenerateBCryptHash $password

# Output the hashed password
Write-Output $hashedPassword