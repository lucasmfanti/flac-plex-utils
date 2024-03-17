# The fourth script: creating the cover image file

# Path to the folder with the artist's albums
$dirPath = "D:\Music\Artist"

# Checking for existing subfolder
$subfolders = Get-ChildItem -Path $dirPath -Directory

if ($subfolders.Count -gt 0) {
    # If there are subfolders, get the first flac file in each of them
    foreach ($subfolder in $subfolders) {
        $flacFile = Get-ChildItem -Path $subfolder.FullName -Filter *.flac | Select-Object -First 1

        if ($flacFile -eq $null) {
            # If there isn't any, write it out
            Write-Host "No FLAC files in the folder $($subfolder.Name)."
        } else {
            # Path to create the cover file in the same folder as the songs
            $savePath = $flacFile.Directory.FullName

            # Creating the command to export the cover imagem from metadata to a file
            $command = "metaflac --export-picture-to=`"$savePath\Cover.jpg`" `"$($flacFile.FullName)`""

            # Apply
            Invoke-Expression $command

            Write-Host "Cover saved in: $savePath\Cover.jpg"
        }
    }
} else {
    # If there are no subfolders, get the first flac file on the main directory
    $flacFile = Get-ChildItem -Path $dirPath -Filter *.flac | Select-Object -First 1

    if ($flacFile -eq $null) {
        Write-Host "Nenhum arquivo FLAC encontrado na pasta principal."
    } else {
        # Path to create the cover file in the same folder as the songs
        $savePath = $flacFile.Directory.FullName

        # Creating the command to export the cover imagem from metadata to a file
        $command = "metaflac --export-picture-to=`"$savePath\Cover.jpg`" `"$($flacFile.FullName)`""

        # Apply
        Invoke-Expression $command

        Write-Host "Cover saved in: $savePath\Cover.jpg"
    }
}
