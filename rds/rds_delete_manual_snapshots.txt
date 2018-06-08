$20Days = (Get-Date).Adddays(-20) 
$ManulSonpshot = Get-RDSDBSnapshot -Region us-east-1 | Sort-Object SnapshotCreateTime | select -First 1000 | Where-Object {$_.SnapshotType -eq "manual" -and $_.SnapshotCreateTime -le $20Days } | Select-Object DBInstanceIdentifier , Engine , SnapshotCreateTime ,dbsnapshotidentifier 

foreach ($ManulSonpshot_loop in $ManulSonpshot) 
{
  Remove-RDSDBSnapshot -Region us-east-1 -DBSnapshotIdentifier $ManulSonpshot_loop.DBSnapshotIdentifier -Force
  Write-Host ' Deleted snapshot ' $ManulSonpshot_loop.DBInstanceIdentifier + '-'+ $ManulSonpshot_loop.DBSnapshotIdentifier
} 