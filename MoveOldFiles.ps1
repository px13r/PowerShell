# gets the date 6 months ago
$MoveDate = (Get-Date).AddMonths(-6)

# finds files older than 6 months in source directory and saves as variable
Get-ChildItem -Path SOURCE PATH -Recurse |
    Where-Object { $_.CreationTime -lt $MoveDate } |
    Select-Object -OutVariable MoveFiles 

# gets total file size of all files older than 6 months
$FilesSize = ($MoveFiles | Measure-Object -Sum Length).Sum

# gets available space at destination
[int64]$FreeSpace = (Get-Volume -DriveLetter ** |
    Select-Object -ExpandProperty SizeRemaining)

# if there's enough room, moves files older than 6 months
If ($FreeSpace -gt $FilesSize) {
    Get-ChildItem -Path SOURCE PATH -Recurse |
    Where-Object { $_.CreationTime -lt $MoveDate } | 
    Move-Item -Destination DESTINATION PATH
    }