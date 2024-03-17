# The third script: creating a lyrics .txt file

# Path to the folder with the artist's albums
$dirPath = "D:\Music\Artist"

# Return all .flac files and their subfolders
$flacFiles = Get-ChildItem -Path $dirPath -Filter *.flac -Recurse

foreach ($file in $flacFiles) {
    # Using the metaflac library to get info about the files metadata
    $lyrics = & metaflac --show-tag=LYRICS "$($file.FullName)" | Out-String

    # Remove useless prefix
    $lyrics = $lyrics -replace "LYRICS=", ""

    # Remove blank spaces
    $lyrics = $lyrics.Trim()

    # New path for the new lyrics file
    $txtFilePath = Join-Path -Path $file.Directory.FullName -ChildPath "$($file.BaseName).txt"

    # Apply
    Set-Content -Path $txtFilePath -Value $lyrics -Force
}