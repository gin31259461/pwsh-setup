Set-ExecutionPolicy Remotesigned

if (-not (winget list | Select-String -Pattern "Starship")) {
  winget install --id Starship.Starship
}

if (-not (Get-Module -ListAvailable -Name PSReadLine)) {
  Install-Module PSReadLine
}

Write-Output "Copying PreConfig Files"

Copy-Item -Path ./.starship -Destination $HOME/ -Recurse -Force
Copy-Item -Path ./.pwsh -Destination $HOME/ -Recurse -Force
Copy-Item -Path ./files-theme-xcad.xaml -Destination $HOME/ -Recurse -Force
Copy-Item -Path ./windows-terminal-settings.json -Destination $HOME/ -Recurse -Force

Write-Output "Installing Fonts"

$fontsPath = [System.Environment]::GetFolderPath("Fonts")
Copy-Item -Path ./fonts/* -Destination $fontsPath -Recurse -Force

Write-Output "Copying PowerShell Profile"

New-Item -Path $profile -Value $HOME/.pwsh/Microsoft.PowerShell_profile.ps1 -ItemType SymbolicLink -Force

Write-Output "Installing Packages"

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

Pause
