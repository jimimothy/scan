#OS Detect for PowerShell 

#Set the path to the list of active hosts
$activehosts = Read-Host -Prompt 'Enter the path to your list of active hosts' 

$ip = Get-Content $activehosts
foreach ($i in $ip) {
    ping -n 1 $i | 
    Select-String "TTL" | % { 
        if ($_ -match "ms") { 
            $ttl = $_.line.split('=')[2] -as [int]; if ($ttl -lt 65) { $os = "Linux" } ElseIf ($ttl -gt 64 -And $ttl -lt 129) { $os = "Windows" } else { $os = "Cisco"};
            Write-Host "$i OS: $os";  echo "$i OS: $os" >> scan_results.txt }} }