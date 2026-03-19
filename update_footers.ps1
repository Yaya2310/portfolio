$footerHtml = @"
    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="footer-grid">
                <!-- Column 1: Logo -->
                <div class="footer-col">
                    <a href="index.html" class="logo">Yannick <span>CONTI-LIGNAC</span></a>
                </div>

                <!-- Column 2: Navigation -->
                <div class="footer-col">
                    <h4>Navigation</h4>
                    <ul class="footer-links">
                        <li><a href="index.html">Accueil</a></li>
                        <li><a href="presentation.html">Présentation</a></li>
                        <li><a href="parcours.html">Mon parcours</a></li>
                        <li><a href="contact.html">Contact</a></li>
                    </ul>
                </div>

                <!-- Column 3: Réalisations -->
                <div class="footer-col">
                    <h4>Réalisations</h4>
                    <ul class="footer-links">
                        <li><a href="realisation-phishing.html">Campagne de Phishing</a></li>
                        <li><a href="realisation-soc.html">Mise en place d'un SOC</a></li>
                        <li><a href="realisation-dockstock.html">Projet DockStock</a></li>
                        <li><a href="realisation-winview.html">Projet WinVieW</a></li>
                        <li><a href="realisation-office365.html">Migration vers Office 365</a></li>
                    </ul>
                </div>

                <!-- Column 4: Compétences -->
                <div class="footer-col">
                    <h4>Compétences</h4>
                    <ul class="footer-links">
                        <li><a href="competences-techniques.html">Techniques</a></li>
                        <li><a href="competences-humaines.html">Humaines</a></li>
                    </ul>
                </div>
            </div>

            <div class="footer-bottom">
                <p>&copy; 2026 - Yannick CONTI-LIGNAC. Tous droits réservés.</p>
            </div>
        </div>
    </footer>
"@

$scriptTag = '<script src="script.js"></script>'

Get-ChildItem -Path . -Filter *.html | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $newContent = $null
    
    if ($content -match '(?s)<!-- Footer -->.*?</footer>') {
        $newContent = [regex]::Replace($content, '(?s)<!-- Footer -->.*?</footer>', $footerHtml)
    } elseif ($content -match '(?s)<footer>.*?</footer>') {
        $newContent = [regex]::Replace($content, '(?s)<footer>.*?</footer>', $footerHtml)
    } else {
        if ($content.Contains($scriptTag)) {
            $newContent = $content.Replace($scriptTag, "$footerHtml`r`n    $scriptTag")
        } else {
            $newContent = $content.Replace('</body>', "$footerHtml`r`n</body>")
        }
    }
    
    if ($null -ne $newContent -and $newContent -ne $content) {
        $newContent | Set-Content $_.FullName -Encoding UTF8
        Write-Host "Updated: $($_.Name)"
    }
}
