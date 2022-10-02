# Set up a hashtable
$HashTable = @{}

# Pipe your list of file paths to ForEach-Object
Get-Content "data\forge\client.txt" | ForEach-Object {
  # Extract the filename with [System.IO.Path]::GetFileName(), split it by dots and grab only the part before the first dot
  $Prefix = [System.IO.Path]::GetFileName($_) -split "\." | Select-Object -First 1
  # Use the extracted prefix to place the string in the correct hashtable entry
  $HashTable[$Prefix] += $_
}
