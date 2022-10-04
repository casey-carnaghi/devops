<#This script quickly retrieves members of an AD group.
Output:
	User's full name and SAMaccountname

Usage:
	To ouput to command line:
		.\Get-MembersOfGroup.ps1
	To save as csv:
		.\Get-MembersOfGroup.ps1 | export-csv ".\some_file_name.csv" -notypeinformation
Author:
    Casey Carnaghi 9.23.2022
#>

function Get-Members-Of-Group(){
	Param([Parameter(Mandatory = $true)] $group_name)

	# input name of AD group
	Write-Host "[INFO] Here are the members of $group_name" -ForegroundColor White -BackgroundColor Green	
	
	# retrieve all members of AD group (first name and samaccountname)
	Get-ADGroupMember -Identity $group_name -Recursive | 
	Get-ADUser -Properties Name, SAMaccountname | 
	Select-Object Name, Samaccountname
	
}

function main(){
	<# 
		main function to initialize variables and call functions
	#>
	
	$group_name = Read-Host "[INPUT] Enter group name you need a list of members for"
	$group_name = $group_name.ToUpper()
	Get-Members-Of-Group $group_name
}

main