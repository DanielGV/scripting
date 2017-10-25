<# 
.Synopsis 
   Set the quota size for the MSMQ service. 
.DESCRIPTION 
   The Restart-service script is designed to be run once to set up a machine. 
   It will restart the MSMQ service so it might affect depencing processes. 
.NOTES 
   Created by: Daniel Gómez Villanueva @DanielGV 
   Modified: 25/10/2017 17:00:00 AM

   To Do: 
    * Add machine parameter to run remotely.
.PARAMETER MachineQuota 
   The size in KB to set the MSMQ Quota.
.PARAMETER MachineJournalQuota 
   The size in KB to set the MSMQ JournalQuota.
   If not set it will use MachineQuota.
.EXAMPLE 
   Set-MSMQ-Quota -MachineQuota 10520576
   Sets the MSMQ Quota and Journal Quota size to 1GB.
#> 
Param(
    [Parameter(Mandatory=$True,Position=1)] [long] $MachineQuota,
    [Parameter(Position=2)] [long] $MachineJournalQuota
)

$MachineCachePath = "HKLM:\SOFTWARE\Microsoft\MSMQ\Parameters\MachineCache\"

if (!$MachineJournalQuota) {
    $MachineJournalQuota = $MachineQuota
}

Write-Host "Setting the MachineQuota to $($MachineQuota)"
Set-ItemProperty -Path $MachineCachePath -Name MachineQuota -Value $($MachineQuota)

Write-Host "Setting the MachineJournalQuota to $($MachineJournalQuota)"
Set-ItemProperty -Path $MachineCachePath -Name MachineJournalQuota -Value $($MachineJournalQuota)

Write-Host "Restarting the MSMQ Service"
Get-Service MSMQ | Restart-Service -Verbose