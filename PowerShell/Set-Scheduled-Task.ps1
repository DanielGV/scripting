Param(
    [Parameter(Mandatory=$True,Position=1)] [string] $scriptPath,
    [Parameter()] [string] $arguments,
    [Parameter()] [string] $taskName,
    [Parameter()] [string] $taskDescription,
    [DateTime] $time =  (Get-Date "0:00 AM")
)

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' `
  -Argument "-NoProfile -WindowStyle Hidden -command ""& {$scriptPath $arguments}"""

$trigger = New-ScheduledTaskTrigger -Daily -At $time

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $taskName -Description $taskDescription