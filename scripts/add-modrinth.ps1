Get-Content data\forge\cf.txt | ForEach-Object {
  pw -d versions/forge/1.19.2 cf add $_ -y
}
