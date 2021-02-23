# Gets time stamps for all computers in the domain that have NOT logged in since after specified date 
# Mod by Tilo 2013-08-27 
# Updated by px13r 2017-05-19
# Run from a DC if possible, update the domain variable, number of days can be changed
import-module activedirectory  
$domain = "DOMAIN_NAME"  
$DaysInactive = 90  
$time = (Get-Date).Adddays(-($DaysInactive)) 
 
# Get all AD computers with lastLogonTimestamp less than our time 
Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} -Properties Name,OperatingSystem,LastLogonTimeStamp | 
 
# Output hostname and lastLogonTimestamp into CSV 
select-object Name,OperatingSystem,@{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}} | export-csv OldCompByLogonr.csv -notypeinformation
 
# Get all AD computers with modified/whenchanged less than our time as sometimes laslLogonTimestamp isn't populated
Get-ADComputer -Filter {whenchanged -lt $time} -Properties Name,OperatingSystem,whenchanged | 
 
# Output hostname and whenchanged into CSV 
select-object Name,OperatingSystem,whenchanged | export-csv OldCompByMod.csv -notypeinformation
 
# For greater detail on a specific system use the next line
# Get-ADComputer -identity [computername] -properties *
