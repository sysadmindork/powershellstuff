#  Exchange Online Powershell Hooker-upper
# Requires msonline, azuread

# Get creds from the user

$UserCredential = Get-Credential

# Connect to the 365 service
Connect-MsolService -Credential $UserCredential

# Create an Exchange online  session
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

# Import the Session
Import-PSSession $Session

