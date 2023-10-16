$NewComputerName = "Server*****3" # Specify the new computer name.

$DC = "contoso.com" # Specify the domain to join.

$Path = "OU=T****,DC=*****,DC=com" # Specify the path to the OU where to put the computer account in the domain.

Add-Computer -DomainName $DC -OUPath $Path -NewName $NewComputerName –Restart –Force