$UTF8NoBOM = New-Object System.Text.UTF8Encoding($false)

# Common double-encoded UTF-8 sequences (UTF-8 bytes read as Latin-1 and re-encoded to UTF8)
$map = @{
    'Ã©' = 'é';
    'Ã ' = 'à';
    'Ã¨' = 'è';
    'Ã¹' = 'ù';
    'Ã®' = 'î';
    'Ã»' = 'û';
    'Ã¢' = 'â';
    'Ãª' = 'ê';
    'Ã´' = 'ô';
    'Ã§' = 'ç';
    'Ã‰' = 'É';
    'Ã€' = 'À';
    'Ãˆ' = 'È';
    'Ã¯' = 'ï';
    'Ã«' = 'ë';
    'Ãœ' = 'Ü';
    'Ã¶' = 'ö';
    'Ã¤' = 'ä';
    'â€™' = '’';
    'Ã»' = 'û';
    'Ã»' = 'û';
    'Ã»' = 'û';
}

# The sequence for 'à' is C3 A0. Written as UTF-8 it becomes C3 83 C2 A0 which is Ã followed by a space (A0 is non-breaking space) or just Ã .
# Let's use a more robust replacement strategy.

Get-ChildItem -Path . -Filter *.html | ForEach-Object {
    $filePath = $_.FullName
    $content = [System.IO.File]::ReadAllText($filePath) # Default uses local ANSI/OEM
    
    # If the file was written with -Encoding UTF8 in PS 5.1, it has a BOM.
    # ReadAllText with no encoding usually handles BOM correctly.
    
    # Re-read with UTF8 to be sure
    $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    
    $newContent = $content
    # Known breakages
    $newContent = $newContent.Replace('Ã©', 'é')
    $newContent = $newContent.Replace('Ã ', 'à')
    $newContent = $newContent.Replace('Ã¨', 'è')
    $newContent = $newContent.Replace('Ã‰', 'É')
    $newContent = $newContent.Replace('Ãˆ', 'È')
    $newContent = $newContent.Replace('Ã ', 'à') # Sometimes there's a space after Ã for à
    $newContent = $newContent.Replace('Ã¢', 'â')
    $newContent = $newContent.Replace('Ãª', 'ê')
    $newContent = $newContent.Replace('Ã´', 'ô')
    $newContent = $newContent.Replace('Ã§', 'ç')
    $newContent = $newContent.Replace('Ã»', 'û')
    $newContent = $newContent.Replace('Ã¹', 'ù')
    $newContent = $newContent.Replace('â€™', "’")
    $newContent = $newContent.Replace('Ã«', 'ë')
    $newContent = $newContent.Replace('Ã¯', 'ï')
    $newContent = $newContent.Replace('Ã²', 'ò')
    $newContent = $newContent.Replace('Ã€', 'À')
    $newContent = $newContent.Replace('Ã‹', 'Ë')
    $newContent = $newContent.Replace('Ãˆ', 'È')
    $newContent = $newContent.Replace('Ã†', 'Æ')
    $newContent = $newContent.Replace('Ã‡', 'Ç')
    $newContent = $newContent.Replace('ÃŠ', 'Ê')
    $newContent = $newContent.Replace('Ã–', 'Ö')
    $newContent = $newContent.Replace('ÃŸ', 'ß')
    $newContent = $newContent.Replace('Ã´', 'ô') # redundant but safe
    $newContent = $newContent.Replace('Ã¨', 'è')
    $newContent = $newContent.Replace('Ã´', 'ô')
    $newContent = $newContent.Replace('Â°', '°')
    $newContent = $newContent.Replace('Â»', '»')
    $newContent = $newContent.Replace('Â«', '«')
    $newContent = $newContent.Replace('Â ', ' ') # non-breaking space to space

    if ($newContent -ne $content) {
        [System.IO.File]::WriteAllText($filePath, $newContent, $UTF8NoBOM)
        Write-Host "Fixed: $($_.Name)"
    }
}
