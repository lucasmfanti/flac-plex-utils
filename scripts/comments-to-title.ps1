# The first script: adding the comments tag to the song title tag

# Path to the folder with the artist's albums
$dirPath = "D:\Music\Artist"

# Return all .flac files and their subfolders
$flacFiles = Get-ChildItem -Path $dirPath -Filter *.flac -File -Recurse

foreach ($file in $flacFiles) {
    # Using the metaflac library to get info about the files metadata
    $comment = & metaflac --show-tag=COMMENT "$($file.FullName)" | Out-String
    $title = & metaflac --show-tag=TITLE "$($file.FullName)" | Out-String

    # Remove useless prefix
    $comment = $comment -replace "COMMENT=", ""
    $title = $title -replace "TITLE=", ""

    # Remove blank spaces
    $comment = $comment.Trim()
    $title = $title.Trim()

    # Verify wether the comment is empty before updating the title
    if (-not [string]::IsNullOrWhiteSpace($comment)) {
        # Adding the comments within parenthesis to the song title tag
        $newTitle = "{0} ({1})" -f $title, $comment

        # Apply
        & metaflac --remove-tag=TITLE --set-tag="TITLE=$newTitle" "$($file.FullName)"
    }
}

