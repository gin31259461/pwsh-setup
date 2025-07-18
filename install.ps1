Set-ExecutionPolicy Remotesigned -Scope CurrentUser -Force | Out-Null

Write-Output "Copying PreConfig Files"

Copy-Item -Path ./.starship -Destination $HOME/ -Recurse -Force

# PowerShell
Write-Output "Copying PowerShell Profile"

Copy-Item -Path ./.pwsh -Destination $HOME/ -Recurse -Force

New-Item -Path $profile -Value $HOME/.pwsh/Microsoft.PowerShell_profile.ps1 -ItemType SymbolicLink -Force

# Packages
Write-Output "Installing Packages"

if (-not (Get-Module -ListAvailable -Name PSReadLine)) {
  Install-Module PSReadLine -Force
}

if (-not (winget list | Select-String -Pattern "Starship")) {
  winget install --id Starship.Starship
}

if (-not (winget list | Select-String -Pattern "Neovim")) {
  winget install --id Neovim.Neovim
}

if (-not (winget list | Select-String -Pattern "WezTerm")) {
  winget install --id wez.wezterm
}

if (-not (winget list | Select-String -Pattern "Alacritty")) {
  winget install --id Alacritty.Alacritty 
}

if (-not (winget list | Select-String -Pattern "NodeJS")) {
  winget install --id OpenJS.NodeJS 
  Get-ChildItem Env:
  npm install -g yarn
}

Write-Output "All Done!"
