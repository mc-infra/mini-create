function SetClient {
  param (
    $Loader,
    $Version,
    $ModName
  )

  $file_name = ".\versions\$Loader\$Version\mods\$ModName.pw.toml"
  $file_data = Get-Content $file_name | ForEach-Object { $_ -replace 'side = "both"', 'side = "client"' }
  Write-Output $file_data > $file_name
}

function Refresh {
  param (
    $Loader,
    $Version
  )
  pw -d ".\versions\$Loader\$Version" refresh
}

function AddMod {
  param (
    $Loader,
    $Version,
    $ModName
  )
  pw -d ".\versions\$Loader\$Version" cf add $ModName -y
}

function AddForge {
  param (
    $Category
  )
  Get-Content ".\data\forge\${Category}.txt" | ForEach-Object {
    AddMod -Loader "forge" -Version "1.19.2" -ModName $_

    if ("${Category}" -eq "client") {
      SetClient -Loader "forge" -Version "1.19.2" -ModName $_
    }
  }
}

AddForge -Category "core"
AddForge -Category "decorations"
AddForge -Category "client"
AddForge -Category "world"
Refresh -Loader "forge" -Version "1.19.2"
