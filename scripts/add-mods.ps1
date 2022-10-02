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
      Refresh -Loader "forge" -Version "1.19.2"
    }
  }
}

function Get-ModList {
  param (
    [array] $CategoryKeys
  )
  $returnVar = New-Object 'System.Collections.Generic.List[object]'
  Get-Content ".\data\forge\modlist.json" | ConvertFrom-Json | % {
    foreach ($category in $CategoryKeys) {
      $obj = $_ | Select-Object -ExpandProperty "${category}"
      Write-Output $obj.Keys
      $obj.Keys | % { $returnVar.Add(@{
            name = $_
            side = $obj[$k].side ?? "both"
          }) }

      # foreach ($k in $obj.Keys) {
      #   $val = @{
      #     name = $k
      #     side = $obj[$k].side || "both"
      #   }
      #   #$val = $obj[$k] | Select-Object -Property Name, file-id | Set-ItemProperty -Name "name" -Value $k
      #   $returnVar.Add($val)
      # }
    }
  }
  return $returnVar
}

$ValidCategories = @("core", "common", "client", "worldgen", "tech")


$ModList = Get-ModList -CategoryKeys "common", "worldgen"

#Get-ModList -CategoryKeys $ValidCategories
Write-Output $ModList

# if ($args.Count -gt 0) {
#   foreach ($a in $args) {
#     if ($ValidCategories.Contains($a)) {
#       $Categories += $a
#     }
#   }
# }
# else { $Categories = $ValidCategories }

# foreach ($cat in $Categories) {
#   AddForge -Category "${cat}"
# }
