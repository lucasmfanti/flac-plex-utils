$artist = "Artist Name"
$album = "Album Name"
$dirPath = "C:\Path\To\Songs\From\$artist\$album"
$flacFiles = Get-ChildItem -Path $dirPath -Filter *.flac -File -Recurse

foreach ($file in $flacFiles) {
    $comment = & metaflac --show-tag=COMMENT "$($file.FullName)" | Out-String
    $comment = $comment -replace "COMMENT=", ""
    $comment = $comment.Trim()
    $title = & metaflac --show-tag=TITLE "$($file.FullName)" | Out-String
    $title = $title -replace "TITLE=", ""
    $title = $title.Trim()
    if (-not [string]::IsNullOrWhiteSpace($comment)) {
        $newTitle = "{0} ({1})" -f $title, $comment
        & metaflac --remove-tag=TITLE --set-tag="TITLE=$newTitle" "$($file.FullName)"
    }
}
Write-Host "Comments added to titles for the $album album from $artist"

foreach ($file in $flacFiles) {
    $cdNumber = & metaflac --show-tag=DISCNUMBER "$($file.FullName)" | Out-String
    $cdNumber = $cdNumber -replace "DISCNUMBER=", ""
    $cdNumber = $cdNumber.Trim()
    $trackNumber = & metaflac --show-tag=TRACKNUMBER "$($file.FullName)" | Out-String
    $trackNumber = $trackNumber -replace "TRACKNUMBER=", ""
    $trackNumber = $trackNumber.Trim()
    $trackNumber = "{0:D2}" -f [int]$trackNumber
    $trackTitle = & metaflac --show-tag=TITLE "$($file.FullName)" | Out-String
    $trackTitle = $trackTitle -replace "TITLE=", ""
    $trackTitle = $trackTitle.Trim()
    $invalidChars = [System.IO.Path]::GetInvalidFileNameChars()
    $escapedInvalidChars = [regex]::Escape($invalidChars -join '')
    if ($escapedInvalidChars -match "\[|\]") {
        $escapedInvalidChars = $escapedInvalidChars -replace "\\[", "\\\[" -replace "\\]", "\\\]"
    }
    $invalidCharsRegex = "[$escapedInvalidChars]"
    $trackTitle = $trackTitle -replace $invalidCharsRegex, ''
    $newFileName = "{0:D3}{1:D2} - {2}.flac" -f $cdNumber, $trackNumber, $trackTitle
    $newFilePath = Join-Path -Path $dirPath -ChildPath $newFileName
    Rename-Item -Path $file.FullName -NewName $newFileName -Force
}
Write-Host "Files renamed for the $album album from $artist"

foreach ($file in $flacFiles) {
    $lyrics = & metaflac --show-tag=LYRICS "$($file.FullName)" | Out-String
    $lyrics = $lyrics -replace "LYRICS=", ""
    $lyrics = $lyrics.Trim()
    $txtFilePath = Join-Path -Path $file.Directory.FullName -ChildPath "$($file.BaseName).txt"
    Set-Content -Path $txtFilePath -Value $lyrics -Force
}
Write-Host "Lyrics created for the $album album from $artist"

$flacFile = Get-ChildItem -Path $dirPath -Filter *.flac | Select-Object -First 1
$savePath = $flacFile.Directory.FullName
$command = "metaflac --export-picture-to=`"$savePath\Cover.jpg`" `"$($flacFile.FullName)`""
Invoke-Expression $command
Write-Host "Cover saved for the $album album from $artist"