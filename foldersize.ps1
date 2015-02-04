$startFolder = "."

#first we compute the size of the current folder
#get all child items recursively and  sum all lengths
$allFilesLength = (Get-ChildItem $startFolder -recurse | Measure-Object -property length -sum) 
"$startFolder -- " + "{0:N2}" -f ($allFilesLength.sum / 1MB) + " MB"

#get all first level folders
$colItems = (Get-ChildItem $startFolder | Where-Object {$_.PSIsContainer -eq $True} | Sort-Object)

#recursively calculate the size each folder
foreach ($i in $colItems)
{
	$subFolderItems = (Get-ChildItem $i.FullName.Replace("[","``[").Replace("]","``]") -recurse | Measure-Object -property length -sum)
	$size = $subFolderItems.sum / 1MB
	$i.FullName + " -- " + "{0:N2}" -f $size + " MB"
}