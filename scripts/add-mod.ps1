
function AddMod {
  param (
    [string]$Name,
    [string]$Type = "mr"
  )
  pw -d versions/fabric/1.18.2 $Type add $Name
  pw -d versions/quilt/1.18.2 $Type add $Name
}

AddMod $args[0] $args[1]
