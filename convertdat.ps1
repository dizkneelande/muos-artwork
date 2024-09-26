# Path to your .dat file
$datFilePath = "C:\Users\nell\Documents\cfw\rg35xxsp\Nintendo DS.dat"

# create a folder named 'INFO' and reference it here. 
# Output folder path for muOS metadata
$outputFolder = "C:\Users\nell\Documents\cfw\rg35xxsp\text"

# Load the .dat file as XML
[xml]$xml = Get-Content -Path $datFilePath

# Iterate through each <game> node
foreach ($game in $xml.datafile.game) {
    $gameName = $game.name
    $gameDescription = $game.description
    
    # Clean up description if needed (remove line breaks and extra spaces)
    $gameDescription = $gameDescription -replace '\s+', ' '

    # Get the ROM name from the <rom> tag and remove file extension
    $romNameWithExtension = $game.rom.name
    $romName = [System.IO.Path]::GetFileNameWithoutExtension($romNameWithExtension)

    # Create output file path based on ROM name
    $outputFilePath = Join-Path -Path $outputFolder -ChildPath "$romName.txt"

    # Write description to file
    Set-Content -Path $outputFilePath -Value $gameDescription

    Write-Host "Processed: $romName"
}

Write-Host "Script execution completed."