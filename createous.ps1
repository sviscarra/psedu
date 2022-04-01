#Import Active Directory module
import-module ActiveDirectory

#Create Root OU
#New-ADOrganizationalUnit 'Corp'

#Create Child OUs in Corp
$OUs = @(
    'Users'
    'Groups'
    'Computers'
    'Servers'
) 

ForEach ($ou in $OUs) {
    New-ADOrganizationalUnit -Path 'OU=Corp,DC=mb,DC=local' -Name $ou
}