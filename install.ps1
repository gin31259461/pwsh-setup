Set-ExecutionPolicy Remotesigned -Scope CurrentUser -Force | Out-Null


# setup starship
if (-not (Test-Path $HOME/.starship))
{
  Write-Output "Copying PreConfig Files"
  Copy-Item -Path ./.starship -Destination $HOME/ -Recurse -Force
}


# setup powershell
if (-not (Test-Path $HOME/.pwsh))
{
  Write-Output "Copying PowerShell Profile"
  Copy-Item -Path ./.pwsh -Destination $HOME/ -Recurse -Force
  New-Item -Path $profile -Value $HOME/.pwsh/Microsoft.PowerShell_profile.ps1 -ItemType SymbolicLink -Force
}

# -------------------- install packages --------------------
# scoop
# PSReadLine
Write-Output "Installing Packages"

Write-Output "Check for PSReadLine"
if (-not (Get-Module -ListAvailable -Name PSReadLine))
{
  Install-Module PSReadLine -Force
}
Write-Output "Done"

Write-Output "Check for Scoop"
if (-not (Test-Path "$env:USERPROFILE\scoop"))
{
  Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
  scoop bucket add extras
  scoop bucket add versions 
}
Write-Output "Done"

Write-Output "Check for WezTerm"
if (-not (scoop list wezterm-nightly))
{
  scoop install wezterm-nightly
}
Write-Output "Done"

# -------------------- install packages via winget --------------------
winget list > winget_list.txt

Write-Output "Check for NodeJS"
if (-not (Get-Content winget_list.txt | Select-String -Pattern "NodeJS"))
{
  winget install --id OpenJS.NodeJS 
  npm install -g pnpm
}
Write-Output "Done"

foreach($line in Get-Content packages.txt )
{
  $tokens = $line -split "."
  $name = $tokens[-1]

  Write-Output "Check for $line"
  if (
    (-not (Get-Content winget_list.txt | Select-String -Pattern $line)) -and 
    (-not (Get-Content winget_list.txt | Select-String -Pattern $name))
  )
  {
    winget install --id $line
  }
  Write-Output "Done"
}
