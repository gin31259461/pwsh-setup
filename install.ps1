winget install --id Starship.Starship
Install-Module PSReadLine -Force

Copy-Item -Path ./.starship -Destination $HOME/ -Recurse -Force
Copy-Item -Path ./.pwsh -Destination $HOME/ -Recurse -Force
Copy-Item -Path ./files-theme-xcad.xaml -Destination $HOME/ -Recurse -Force
Copy-Item -Path ./windows-terminal-settings.json -Destination $HOME/ -Recurse -Force
Copy-Item -Path ./fira-code/* -Destination C:/Windows/Fonts/ -Recurse -Force

New-Item -Path $profile -Value $HOME/.pwsh/Microsoft.PowerShell_profile.ps1 -ItemType SymbolicLink -Force
