$root = "\tools\"
$package = "logstash"
$version = "9.2.3"

$ProgressPreference = 'SilentlyContinue'

$download_folder = Join-Path -Path $root -ChildPath "downloads" 
$installatoin_package_url = "https://artifacts.elastic.co/downloads/logstash/logstash-" + $version + "-windows-x86_64.zip"
$installatoin_package_path = Join-Path $download_folder -ChildPath ([System.IO.Path]::GetFileName($installatoin_package_url))
$target_folder = Join-Path $root -ChildPath $package

# Create the destination folder if it doesn't exist
if (-not (Test-Path -Path $download_folder)) {
    Write-Host "* Creating folder: $download_folder"
    New-Item -ItemType Directory -Path $download_folder | Out-Null
}

# Download installation package
if (!(Test-Path($installatoin_package_path))) {
	Write-Host "* Downloading $package - $installatoin_package_url" -ForegroundColor Yellow
	Invoke-WebRequest -uri $installatoin_package_url -Method "GET" -Outfile $installatoin_package_path
}

# Unpack & Rename
if (Test-Path($installatoin_package_path)) {
	
	if (-not (Test-Path($target_folder))) {
		
		$temporary_folder = Join-Path -Path $root -ChildPath ($package + "-" + $version)
		if (-not (Test-Path($temporary_folder))) {
			write-Host "* Unpacking $installatoin_package_path to $temporary_folder" -ForegroundColor Yellow
			Expand-Archive -Path $installatoin_package_path -DestinationPath $root
		}

		write-Host "* Renaming $temporary_folder to $target_folder" -ForegroundColor Yellow
		Rename-Item -Path $temporary_folder -NewName $package
	}
}

Write-Host "* Package $package  installation complete."