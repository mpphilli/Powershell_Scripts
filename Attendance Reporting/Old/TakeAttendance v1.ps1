$ErrorActionPreference = "Stop"
$_AllUsersList = 'AllUsersList.csv'
$_Report = 'Report.csv'
$_tmpAllUsersList = '_tmpAllUsersList.txt'
$_tmpDates = '_tmpDates.txt'
$_tmpReport1 = '_tmpReport1.txt'
$_tmpReport2 = '_tmpReport2.txt'

# If first argument exists then assign it to $_AllUsersList
IF(!([string]::IsNullOrWhiteSpace($args[0]))) {            
    $_AllUsersList = $args[0]
}
# If second argument exists then assign it to $_Report
IF(!([string]::IsNullOrWhiteSpace($args[1]))) {            
    $_Report = $args[1]
}

Write-Host 
Get-Content -Encoding Ascii $_AllUsersList `
    | select -Skip 1 `
    | ForEach-Object {$_ -ireplace '[^\x20-\x7E]'} `
    | ForEach-Object {$_.split(',')[0] + " " + $_.split(',')[1]} `
    | sort `
    | Set-Content $_tmpAllUsersList
Get-Content -Encoding Ascii $_Report `
    | select -Skip 1 `
    | ForEach-Object {$_ -ireplace '[^\x20-\x7E]'} `
    | ForEach-Object {$_.split(' ')[0]} `
    | Sort-Object -Unique `
    | Set-Content $_tmpDates 
Get-Content $_tmpDates | `
    ForEach-Object {
        IF ([string]::IsNullOrWhiteSpace($_)) { return }
        Get-Content $_Report `
            | Select-String -pattern $_ `
            | Set-Content $_tmpReport1
        Get-Content $_tmpReport1 `
            | ForEach-Object {$_.split(',')[2]} `
            | Sort-Object -Unique `
            | Set-Content $_tmpReport2
        $_NewReportName = 'Report_' + $_ -replace "/","-" 
        $_NewReportName = $_NewReportName + '.txt'
        Get-Content $_tmpReport2,$_tmpAllUsersList `
            | Group-Object `
            | where-Object {$_.count -eq 1} `
            | Foreach-object {$_.group[0]} `
            | Set-Content $_NewReportName
        Write-Host  Report for $_ created: $_NewReportName
    } 
del _tmp*.*

Exit 
