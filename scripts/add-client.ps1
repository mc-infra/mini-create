function SetClient {
  param (
    $Loader,
    $Version,
    $ModName
  )

  $file_name = ".\versions\$Loader\$Version\$ModName.pw.toml"
  $file_data = Get-Content $file_name | ForEach-Object { $_ -replace 'side = "both"', 'side = "client"' }
  Write-Output $file_data > $file_name
}

function AddMod {
  param (
    $Loader,
    $Version,
    $ModName
  )
  pw -d ".\versions\$Loader\$Version" cf add $ModName -y
}

function AddForgeCore {
  Get-Content data\forge\core.txt | ForEach-Object {
    AddMod -Loader "forge" -Version "1.19.2" -ModName $_
  }
}

function AddForgeClient {
  Get-Content data\forge\client.txt | ForEach-Object {
    AddMod -Loader "forge" -Version "1.19.2" -ModName $_
    SetClient -Loader "forge" -Version "1.19.2" -ModName $_
  }
}
