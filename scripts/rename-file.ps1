# The second script: renaming file names according to metadata

# Path to the folder with the artist's albums
$dirPath = "D:\Music\Artist"

# Return all .flac files and their subfolders
$flacFiles = Get-ChildItem -Path $dirPath -Filter *.flac -File -Recurse

foreach ($file in $flacFiles) {
    # Using the metaflac library to get info about the files metadata
    $cdNumber = & metaflac --show-tag=DISCNUMBER "$($file.FullName)" | Out-String
    $trackNumber = & metaflac --show-tag=TRACKNUMBER "$($file.FullName)" | Out-String
    $trackTitle = & metaflac --show-tag=TITLE "$($file.FullName)" | Out-String

    # Remove useless prefix
    $cdNumber = $cdNumber -replace "DISCNUMBER=", ""
    $trackNumber = $trackNumber -replace "TRACKNUMBER=", ""
    $trackTitle = $trackTitle -replace "TITLE=", ""

    # Remove blank spaces
    $cdNumber = $cdNumber.Trim()
    $trackNumber = $trackNumber.Trim()
    $trackTitle = $trackTitle.Trim()

    # Make sure the track number has two digits to properly order alphabetically
    $trackNumber = "{0:D2}" -f [int]$trackNumber

    # Get invalid characters in song titles
    $invalidChars = [System.IO.Path]::GetInvalidFileNameChars()

    # Escape those characters in the regular expression
    $escapedInvalidChars = [regex]::Escape($invalidChars -join '')

    # If there are brackets in the song original file name, escape them again
    if ($escapedInvalidChars -match "\[|\]") {
        $escapedInvalidChars = $escapedInvalidChars -replace "\\[", "\\\[" -replace "\\]", "\\\]"
    }

    # Write the regex to find invalid characters
    $invalidCharsRegex = "[$escapedInvalidChars]"

    # Replace invalid chars for blank string
    $trackTitle = $trackTitle -replace $invalidCharsRegex, ''

    # New file name, according to Plex preferred settings
    $newFileName = "{0:D3}{1:D2} - {2}.flac" -f $cdNumber, $trackNumber, $trackTitle

    # Path to the new fileCaminho completo para o novo arquivo
    $newFilePath = Join-Path -Path $dirPath -ChildPath $newFileName

    # Apply
    Rename-Item -Path $file.FullName -NewName $newFileName -Force
}