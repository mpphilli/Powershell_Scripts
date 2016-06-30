$_ActiveUserList = 'ActiveUserList.csv'
$_Report = 'Report.csv'
$_tmpActiveUsersList = '_tmpActiveUsersList.txt'
$_tmpDates = '_tmpDates.txt'
$_tmpReport1 = '_tmpReport1.txt'
$_tmpReport2 = '_tmpReport2.txt'

# If first argument exists then assign it to $_ActiveUserList
IF(!([string]::IsNullOrWhiteSpace($args[0]))) {            
    $_ActiveUserList = $args[0]
}
# If second argument exists then assign it to $_Report
IF(!([string]::IsNullOrWhiteSpace($args[1]))) {            
    $_Report = $args[1]
}

#Write-Host "Active user list: " $_ActiveUserList
#Write-Host "Report: " $_Report

#Write-Host "Should not reach here!"

Write-Host `n
Get-Content $_ActiveUserList | select -Skip 1 | ForEach-Object {$_.split(',')[0] + " " + $_.split(',')[1]} | sort | Set-Content $_tmpActiveUsersList
Get-Content $_Report | select -Skip 1 | ForEach-Object {$_.split(' ')[0]} | Sort-Object -Unique | Set-Content $_tmpDates 
Get-Content $_tmpDates | ForEach-Object {
    Get-Content $_Report | select-string -pattern $_ | Set-Content $_tmpReport1
    Get-Content $_tmpReport1 | ForEach-Object {$_.split(',')[2]} | Sort-Object -Unique | Set-Content $_tmpReport2
    $_NewReportName = 'Report_' + $_ -replace "/","-" 
    $_NewReportName = $_NewReportName + '.txt'
    Get-Content $_tmpReport2,$_tmpActiveUsersList | Group-Object | where-Object {$_.count -eq 1} | Foreach-object {$_.group[0]} | Set-Content $_NewReportName
    Write-Host  Report for $_ created: $_NewReportName
} 
del _tmp*.*

Exit 

#testing ****************************************************

IF([string]::IsNullOrWhiteSpace($string1)) {            
    Write-Host "Given string is NULL or having WHITESPACE"            
} else {            
    Write-Host "Given string has a value"            
}            



Get-Content $_tmpDates | ForEach-Object {
    Get-Content $_Report | select-string -pattern $_ | Set-Content '_tmp1.txt'; Get-Content '_tmp1.txt' | ForEach-Object {$_.split(',')[2]}
} 




Get-Content $_tmpDates | ForEach-Object {
    Get-Content $_Report | select-string -pattern $_ # | ForEach-Object {$_.split(',')[0]}
} 

ForEach($item in Get-Content $_tmpDates){
    Get-Content $_Report | select-string -pattern $item | ForEach-Object {
        $myline = $_; $myline.split(',')
    }
    #$obj | Where-Object{$_.arg -eq $item.arg}
}

if (Get-Variable args[0] -Scope Global -ErrorAction SilentlyContinue) {
    
} else {
    $false
}

Get-Content '1.txt','2.txt' | Group-Object
Get-Content '1.txt','2.txt' | Group-Object | where-Object {$_.count -eq 1} | Foreach-object {$_.group[0]} | Set-Content 'FileC.txt'
Get-Content '1.txt','2.txt' | Group-Object | where-Object {$_.count -ne 1} | Foreach-object {$_.group[0]}

Get-Content $_ActiveUserList | select -Skip 1 | ForEach-Object {$_.split(',')[1]}

Get-Content 'ActiveUserList.csv'
Get-Content 'Report.csv' 
#| Foreach-Object { $_ -replace "/", "-" } 


Get-Content 'ActiveUserList.csv' | select -Skip 1 | ForEach-Object {$_.split(',')[0] + " " + $_.split(',')[1] } 





 
