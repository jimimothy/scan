#Multi-network Ping Scan

#Set filename variables
$Currenttime = (Get-Date -Format yyyy-MM-dd-hhmm)
$filename = $Currenttime + "_" + "hosts.txt"

#Define Network portion of address
$networks = "127.0.0.","10.0.2."
foreach ($n in $networks){
#Define the range of hosts and scan the network
    1..255 | % {
        $ip = $n + $_
            Test-Connection -Count 1 $ip -ErrorAction SilentlyContinue | Where-Object IPV4Address -ne $null | Select-Object Address >> $filename
            }
        }
    (gc $filename) | ? {$_.trim() -ne "" -and $_.trim() -ne "Address" -and $_.trim() -ne "-------"} | Set-Content $filename

#Compare to network baseline
Compare-Object -ReferenceObject (Get-Content ($baseline = Read-Host -Prompt 'Enter the path of the list of hosts you want to compare to')) -DifferenceObject (Get-Content $filename)
