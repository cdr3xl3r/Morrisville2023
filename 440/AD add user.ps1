# Import Active Directory module
Import-Module ActiveDirectory

# Open file dialog
# Load Windows Forms
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

# Create and show open file dialog
$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.InitialDirectory = $StartDir
$dialog.Filter = "CSV (*.csv)| *.csv" 
$dialog.ShowDialog() | Out-Null

# Get file path
$CSVFile = $dialog.FileName

# Import file into variable
# Mmake sure the file path was valid
# If the file path is not valid, then exit the script
if ([System.IO.File]::Exists($CSVFile)) {
    Write-Host "Importing CSV..."
    $CSV = Import-Csv -LiteralPath "$CSVFile"
} else {
    Write-Host "File path specified was not valid"
    Exit
}

# Iterate over each line in the CSV file
foreach($user in $CSV) {

    # Password
    
    # Format their username
    $Username = "$($user.'First Name'[0])$($user.'Last Name')"
    $Username = $Username.Replace(" ", "")

    # Create new user
    New-ADUser -Name $user `
                -UserPrincipalName $Username `
                -SamAccountName $Username `
                -Description $user.Description `
                -Path $user.'Organizational Unit'
                -ChangePasswordAtLogon $true `
                -Enabled $([System.Convert]::ToBoolean($user.Enabled))

    # Write to host that we created a new user
    Write-Host "Created $Username / $($user.'Email Address')"

    #If groups is not null... then iterate over groups (if any were specified) and add user to groups
   #if ($user.'Add Groups (csv)' -ne "") {
    #    $user.'Add Groups (csv)'.Split(",") | ForEach-Object {
     #   Add-ADGroupMember -Identity $_ -Members $Username
      #  WriteHost "Added $Username to $_ group" # Log to console
    #}
    #}

    # Write to host that we created the user
    Write-Host "Created user $Username with groups $($Username.'Add Groups (csv)')"
}

Read-Host -Prompt "Script complete... Press enter to exit."