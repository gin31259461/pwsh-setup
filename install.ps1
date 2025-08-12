Set-ExecutionPolicy Remotesigned -Scope CurrentUser -Force | Out-Null

Write-Output "Copying PreConfig Files"

Copy-Item -Path ./.starship -Destination $HOME/ -Recurse -Force

# PowerShell
Write-Output "Copying PowerShell Profile"

Copy-Item -Path ./.pwsh -Destination $HOME/ -Recurse -Force

New-Item -Path $profile -Value $HOME/.pwsh/Microsoft.PowerShell_profile.ps1 -ItemType SymbolicLink -Force

# Packages
Write-Output "Installing Packages"

Write-Output "Check for Scoop"
if (-not (Test-Path "$env:USERPROFILE\scoop"))
{
  Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

scoop bucket add extras
scoop bucket add versions 
Write-Output "Done"

Write-Output "Check for PSReadLine"
if (-not (Get-Module -ListAvailable -Name PSReadLine))
{
  Install-Module PSReadLine -Force
}
Write-Output "Done"

Write-Output "Check for Starship"
if (-not (winget list | Select-String -Pattern "Starship"))
{
  winget install --id Starship.Starship
}
Write-Output "Done"

Write-Output "Check for Neovim"
if (-not (winget list | Select-String -Pattern "Neovim"))
{
  winget install --id Neovim.Neovim
}
Write-Output "Done"

Write-Output "Check for WezTerm"
if (-not (scoop list wezterm-nightly))
{
  scoop install wezterm-nightly
}
Write-Output "Done"

Write-Output "Check for Alacritty"
if (-not (winget list | Select-String -Pattern "Alacritty"))
{
  winget install --id Alacritty.Alacritty 
}
Write-Output "Done"

Write-Output "Check for NodeJS"
if (-not (winget list | Select-String -Pattern "NodeJS"))
{
  winget install --id OpenJS.NodeJS 
  npm install -g pnpm
}
Write-Output "Done"

Write-Output "Check for ripgrep"
if (-not (winget list | Select-String -Pattern "ripgrep"))
{
  winget install BurntSushi.ripgrep.MSVC
}
Write-Output "Done"


Write-Output "All Done!"
