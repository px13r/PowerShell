# source data from https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/convertto-securestring?view=powershell-6

# this prompts you to enter the word or phrase to be secured and saves it as a secure string
$Secure = Read-Host -AsSecureString

# converts secured string to encrypted standard string
# Key specifies the length of the encryption key: 16, 24, or 32 bytes.
$Encrypted = ConvertFrom-SecureString -SecureString $Secure -Key 16

# saves the encrypted standard string as a text file for future use
$Encrypted | Set-Content C:\EnP.txt

# retrieves encrypted standard string from saved file
# Key specifies the length of the encryption key: 16, 24, or 32 bytes.
$Retrieved = Get-Content C:\EnP.txt | ConvertTo-SecureString -Key 16
