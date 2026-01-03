$root = "\tools\"
$package = "hayabusa"
$version = "3.7.0"

$ProgressPreference = 'SilentlyContinue'

$download_folder = Join-Path -Path $root -ChildPath "downloads"
$installatoin_package_url = "https://github.com/Yamato-Security/hayabusa/releases/download/v" + $version + "/hayabusa-" + $version + "-win-x64.zip"
$installatoin_package_path = Join-Path $download_folder -ChildPath ([System.IO.Path]::GetFileName($installatoin_package_url))
$target_folder = Join-Path $root -ChildPath $package

# Create the destination folder if it doesn't exist
if (-not (Test-Path -Path $download_folder)) {
    Write-Host "* Creating folder: $download_folder"
    New-Item -ItemType Directory -Path $download_folder | Out-Null
}

$package_version_bin = Join-Path -Path $target_folder -ChildPath ($package + "-" + $version + "-win-x64.exe")

if (-not (Test-Path($target_folder))) {

	# Download installation package
	if (!(Test-Path($installatoin_package_path))) {
		Write-Host "* Downloading $package - $installatoin_package_url" -ForegroundColor Yellow
		Invoke-WebRequest -uri $installatoin_package_url -Method "GET" -Outfile $installatoin_package_path
	}

	# Unpack & Rename
	if (Test-Path($installatoin_package_path)) {
	
		write-Host "* Unpacking $installatoin_package_path to $target_folder" -ForegroundColor Yellow
		Expand-Archive -Path $installatoin_package_path -DestinationPath $target_folder
		
		write-Host "* Renaming $package_version_bin to $package.exe" -ForegroundColor Yellow
		Rename-Item -Path $package_version_bin -NewName ($package + ".exe")
	}
}

$package_bin = Join-Path -Path $target_folder -ChildPath ($package + ".exe")

write-Host "* Updating detection rules" -ForegroundColor Yellow
Invoke-Expression "$package_bin update-rules --quiet"

Write-Host "* Package $package installation complete." -ForegroundColor Yellow

# the end