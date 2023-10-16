$dc = ""
$pw = "Password123" | ConvertTo-SecureString -asPlainText -Force
$usr = "$dcT.#####"
$pc = "######" # Specify the computer that should be joined to the domain.
$creds = New-Object System.Management.Automation.PSCredential($usr,$pw)
Add-Computer -ComputerName $pc -LocalCredential $pcadmin -DomainName $dc -Credential $creds -Verbose -Restart -Force