$PrimaryRegion = 'ap-southeast-2'
$ddbtablelist = Get-DDBTableList -Region $PrimaryRegion 


foreach ($ddbtablelist_item in $ddbtablelist)
{    
   Get-DDBTable -Region $PrimaryRegion -TableName $ddbtablelist_item |Select-Object  TableName , ItemCount, @{Name="ProvisionedThroughput";Expression={ $_.ProvisionedThroughput |  Select-Object ReadCapacityUnits ,WriteCapacityUnits}}|Select-Object -Property * -ExcludeProperty  ProvisionedThroughput -ExpandProperty ProvisionedThroughput}