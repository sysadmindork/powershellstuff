#  Exchange Online Powershell Hooker-upper
# Requires msonline, azuread

#function to check if a given module is installed and available and import if so
function CheckModuleAvailable ($modulename) {
    if (Get-Module -ListAvailable -Name $modulename) {
        Write-Host "$modulename module available - proceeding"
        Import-Module $modulename
        return $true
    } else {
        Write-Error "$modulename module not available"
        return $false
    }
}

#check dependencies
$ms = CheckModuleAvailable("MSOnline")
$azure = CheckModuleAvailable("AzureAD")
if(-not ($ms -and $azure)){
    exit
}

# Get creds from the user

$UserCredential = Get-Credential

# Connect to the 365 service
Connect-MsolService -Credential $UserCredential

# Create an Exchange online  session
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

# Import the Session
Import-PSSession $Session

