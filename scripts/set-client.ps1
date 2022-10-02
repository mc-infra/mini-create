Get-Content data\forge\client.txt | ForEach-Object {
  $file_name = ".\versions\forge\1.19.2\mods\$_.pw.toml"
  Get-Content $file_name | ForEach-Object { $_ -replace 'side = "both"', 'side = "client"' } > $file_name
}
