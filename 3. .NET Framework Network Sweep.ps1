#Ping Sweep using the .Net Framework

#Set filename variables
$Currenttime = (Get-Date -Format yyyy-MM-dd-hhmm)
$filename = $Currenttime + "_" + "hosts.txt"

#Define Network portion of address e.g. "192.168.110."
$networks = "192.168.110."

#Define Host portion of address e.g. 1..255 then scan the network
foreach ($n in $networks) {
    1..255 | % {
        $ping = new-object System.Net.NetworkInformation.Ping

        $ip = $n + $_
        $test = $ping.send($ip)

        if ($test.status -eq "Success") {
            echo $test.Address.IPAddressToString >> $filename
        }
    }
}

#Compare to network baseline
Compare-Object -ReferenceObject (Get-Content ($baseline = Read-Host -Prompt 'Enter the path of the list of hosts you want to compare to')) -DifferenceObject (Get-Content $filename)