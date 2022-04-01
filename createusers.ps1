#Import Active Directory module
import-module ActiveDirectory

#Prompts User to enter a secure Temp password
$AccountPass = Read-Host -AsSecureString -Prompt "Enter Temporary Password for New Users"

#Imports the CSV File containing all the users
$csv = Import-Csv -Path C:\Temp\Excel\mbusers.csv


#Loop to Create Users from the CSV
foreach($User in $csv) {

    #Stores user attributes for Splatting
    $UserInfo = @{
        Name = $user.Name
        DisplayName = $user.Name
        GivenName = $user.GivenName
        Surname = $user.Surname

        SamAccountName = $user.SamAccountName
        Path = $user.Path

        Title = $user.Title
        Department = $user.Department
        Company = $user.Company
        EmailAddress = $user.EmailAddress

        AccountPassword = $AccountPass
        ChangePasswordAtLogon = $true
        Enabled = $true
    }

    #Creates New Users
    New-ADUser @UserInfo
}