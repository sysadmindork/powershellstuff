
# Get members of New Employee group who are more than 90 days old and removes them from the group
# 


$group = get-adgroup 'New Hires'

 $user_list = Get-ADGroupMember $group | foreach-object { 
	Get-ADUser -Identity $_.samaccountname -Properties whencreated | Where-Object {$_.whenCreated -lt ((Get-Date).AddDays(-90)).Date} | select -property samaccountname, name, whenCreated 
	}

foreach ($user in $user_list) {
    Write-Host "Removing "  $user.name "from group " $group
    Remove-ADPrincipalGroupMembership -Identity $user.samaccountname -MemberOf $group -Confirm:$false
}


