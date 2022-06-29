#Multi-network TCP host sweep

#Set filename variables
$Currenttime = (Get-Date -Format yyyy-MM-dd-hhmm)
$filename = $Currenttime + "_" + "hosts.txt"

#Define networks
$networks = "127.0.0.","10.0.2."

#Define a common open port
$port = 135
foreach($n in $networks)  {
#Set the host range and scan the network
1..255 | % {
$ip = $n + $_
            $tcpobject = New-Object System.Net.Sockets.TcpClient
            $tcpconnection = $tcpobject.ConnectAsync("$ip",$port)
            $wait = $tcpconnection.AsyncWaitHandle.WaitOne(100,$false)
            If($wait) {
                echo $ip >> $filename
                }   
      }
           $tcpobject.Close()
 }

#Compare to network baseline
Compare-Object -ReferenceObject (Get-Content ($baseline = Read-Host -Prompt 'Enter the path of the list of hosts you want to compare to')) -DifferenceObject (Get-Content $filename)