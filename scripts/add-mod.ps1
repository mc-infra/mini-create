
function AddMod {
  param (
    [string]$Name,
    [string]$Type = "mr"
  )
  pw -b -d versions/fabric $Type add $Name
  pw -b -d versions/quilt $Type add $Name
}

AddMod $args
