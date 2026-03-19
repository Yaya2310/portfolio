$UTF8NoBOM = New-Object System.Text.UTF8Encoding($false)

# Define replacements using char codes to avoid script encoding issues
# Ã (195) followed by something
$A_tilde = [char]195
$copy = [char]169    # ©
$space = [char]160   # Non-breaking space often follows Ã for à
$para = [char]164    # ¤
$deg = [char]176     # °
$cent = [char]162    # ¢
$macron = [char]170  # ª
$sup2 = [char]178    # ²
$sup3 = [char]179    # ³
$acute = [char]180   # ´
$para_sign = [char]182 # ¶
$middot = [char]183  # ·
$cedilla = [char]184 # ¸
$sup1 = [char]185    # ¹
$ordm = [char]186    # º
$raquo = [char]187   # »
$frac14 = [char]188  # ¼
$frac12 = [char]189  # ½
$frac34 = [char]190  # ¾
$iquest = [char]191  # ¿

Get-ChildItem -Path . -Filter *.html | ForEach-Object {
    $filePath = $_.FullName
    $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    
    $newContent = $content
    
    # Common replacements
    $newContent = $newContent.Replace("$A_tilde$([char]169)", 'é')
    $newContent = $newContent.Replace("$A_tilde$([char]160)", 'à')
    $newContent = $newContent.Replace("$A_tilde$([char]168)", 'è')
    $newContent = $newContent.Replace("$A_tilde$([char]137)", 'É')
    $newContent = $newContent.Replace("$A_tilde$([char]136)", 'È')
    $newContent = $newContent.Replace("$A_tilde$([char]162)", 'â')
    $newContent = $newContent.Replace("$A_tilde$([char]170)", 'ê')
    $newContent = $newContent.Replace("$A_tilde$([char]180)", 'ô')
    $newContent = $newContent.Replace("$A_tilde$([char]167)", 'ç')
    $newContent = $newContent.Replace("$A_tilde$([char]187)", 'û')
    $newContent = $newContent.Replace("$A_tilde$([char]185)", 'ù')
    $newContent = $newContent.Replace("$A_tilde$([char]171)", 'ë')
    $newContent = $newContent.Replace("$A_tilde$([char]175)", 'ï')
    $newContent = $newContent.Replace("$A_tilde$([char]128)", 'À')
    $newContent = $newContent.Replace("$([char]226)$([char]128)$([char]153)", "’") # Apostrophe
    
    if ($newContent -ne $content) {
        [System.IO.File]::WriteAllText($filePath, $newContent, $UTF8NoBOM)
        Write-Host "Fixed: $($_.Name)"
    }
}
