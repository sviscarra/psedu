#Import Active Directory module
import-module ActiveDirectory

#Imports the CSV File containing all the users
$csv = Import-Csv -Path C:\Temp\Excel\mbusers.csv

#Path to the Security Groups OU
$groupOU = "OU=Groups,OU=Corp,DC=mb,DC=local"

#Import unique Department Names
$groups = $csv.Department | Select-Object -Unique

# Loop to add new Groups based on Department name
foreach ($group in $groups) {

    # Info for the Global group creation
    $GlobalGroupInfo = @{
        Name            = "$group Users"
        SamAccountName  = $group.ToLower() + "_users"
        Path            = $groupOU
        GroupScope      = "Global" 
        GroupCategory   = "Security"
        Description     = "Members of this group work in the $group Department"
    }

    # Info for the Domain local group creation
    $DomainLocalGroup = @{
        Name            = "$group Resources"
        SamAccountName  = $group.ToLower() + "_resources"
        Path            = $groupOU
        GroupScope      = "DomainLocal" 
        GroupCategory   = "Security"
        Description     = "Security Group used to manage access to the $group Department's resources"
    }

    New-ADGroup @GlobalGroupInfo
    New-ADGroup @DomainLocalGroup
}