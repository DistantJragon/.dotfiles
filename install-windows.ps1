function backup-nvim-folders {
  # Backup the folder
  $date = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
  $backup_folder = "$env:LOCALAPPDATA\nvim_$date"
  Move-Item "$env:LOCALAPPDATA\nvim" $backup_folder
  Write-Host "nvim folder backed up to $backup_folder"
  if (Test-Path "$env:LOCALAPPDATA\nvim-data") {
    $data_backup_folder = "$env:LOCALAPPDATA\nvim-data_$date"
    Move-Item "$env:LOCALAPPDATA\nvim-data" $data_backup_folder
    Write-Host "nvim-data folder backed up to $data_backup_folder"
  }
}

function remove-nvim-folders {
  # Remove the existing nvim folders if they exist
  if (Test-Path "$env:LOCALAPPDATA\nvim") {
    Remove-Item "$env:LOCALAPPDATA\nvim" -Recurse
  }
  if (Test-Path "$env:LOCALAPPDATA\nvim-data") {
    Remove-Item "$env:LOCALAPPDATA\nvim-data" -Recurse
  }
  # Remove the existing nvim symlink if it exists
  if (Test-Path "$env:LOCALAPPDATA\nvim") {
    Remove-Item "$env:LOCALAPPDATA\nvim" -Force
  }
  # Check if the folders were removed
  if (Test-Path "$env:LOCALAPPDATA\nvim") {
    return 1
  }
  if (Test-Path "$env:LOCALAPPDATA\nvim-data") {
    return 1
  }
  return 0
}

# Ask user if they want to install the package
$user_install = Read-Host "Do you want to install the nvim package? (y/n)"
if ($user_install -eq "y") {
  # First, check if C:\Users\%USERNAME%\AppData\Local\nvim exists
  $user_continue = "y"
  if (Test-Path "$env:LOCALAPPDATA\nvim") {
    # If it exists, ask the user if they want to backup the folder and continue
    $user_backup = Read-Host "nvim folder already exists in AppData\Local. Do you want to backup the folder and continue? (y/n)"
    if ($user_backup -eq "Y") {
      backup-nvim-folders
    } else {
      $user_continue = Read-Host "Do you want to continue without backing up the folder? THIS WILL DELETE THE FOLDERS (y/n)"
    }
  }
  if ($user_continue -eq "y") {
    $remove_result = remove-nvim-folders
    if ($remove_result -eq 1) {
      Write-Host "Failed to remove existing nvim/nvim-data folder(s)"
    } else {
      # Install the package
      # A symlink should be created at %LOCALAPPDATA%\nvim pointing to nvim\.config\nvim (this path is relative to this script)
      $nvim_path = "$env:LOCALAPPDATA\nvim"
      $nvim_config_path = "nvim\.config\nvim"
      $nvim_config_full_path = Join-Path $PSScriptRoot $nvim_config_path
      cmd /c mklink /D $nvim_path $nvim_config_full_path
      Write-Host "nvim package installed"
    }
  }
}
