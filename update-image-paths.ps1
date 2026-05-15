# Hannah Moore Portfolio — Update Image Paths
# Run this AFTER download-images.ps1 has finished successfully
# Right-click and "Run with PowerShell", or run: .\update-image-paths.ps1

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Hannah Moore — Update Image Paths" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Map of Webflow CDN URLs -> local paths
# Order matters: more specific URLs first
$replacements = [ordered]@{

    # Logo
    "https://uploads-ssl.webflow.com/61088b79428861b097c4210b/63119fe3e078ad6e7fc8ce0d_Group%2021.svg" = "images/logo/hannah-moore-logo.svg"

    # Interest images
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ad1064c8ce0e_interests2.PNG"  = "images/interests/interests-2.png"
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ad62dbc8ce2a_interests9.PNG"  = "images/interests/interests-9.png"
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ad8442c8ce1a_interests1.PNG"  = "images/interests/interests-1.png"
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ad22fdc8ce32_interests10.PNG" = "images/interests/interests-10.png"
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ad48e3c8ce36_interests11.PNG" = "images/interests/interests-11.png"
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ad528cc8ce26_interests7.PNG"  = "images/interests/interests-7.png"
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ade8b2c8ce12_interests3.PNG"  = "images/interests/interests-3.png"
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ada3f4c8ce16_interests4.PNG"  = "images/interests/interests-4.png"
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ade1d0c8ce22_interests6.PNG"  = "images/interests/interests-6.png"

    # Developer Portfolio
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/64eaee9b036004e0da2af69d_MacBook%20Pro%2016.png" = "images/projects/dev-portfolio-macbook.png"
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/64eaf16f587c6d32b6a49762_Linkedin%20Image.png"   = "images/projects/dev-portfolio-linkedin.png"

    # Discord iOS Widget
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/6311adc70d09393d87ca1867_Group%206.png"    = "images/projects/discord-overview.png"
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/6311adc70d09390c33ca186d_Group%20304.png"  = "images/projects/discord-research.png"
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/6311adc70d09391683ca186f_Group%20305.png"  = "images/projects/discord-wireframes.png"
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/6311adc70d093923fcca1873_Group%20306.png"  = "images/projects/discord-exploration.png"
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/6311adc70d093953beca1877_Group%20307.png"  = "images/projects/discord-hifi.png"
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/6311adc70d09393373ca187b_Group%20309.png"  = "images/projects/discord-final.png"

    # World Cosplay Summit
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078adadd1c8ce3a_Group%207%20(1).png" = "images/projects/wcsa-design.png"
    "https://cdn.prod.website-files.com/61088b79428861b097c4210b/64eaeae5dbce9b580c045723_MacBook%20Pro%2016.png" = "images/projects/wcsa-macbook.png"
}

# HTML files to update
$htmlFiles = @(
    "index.html",
    "developer-portfolio.html",
    "discord-ios-widget.html",
    "world-cosplay-summit.html"
)

$totalReplacements = 0

foreach ($file in $htmlFiles) {
    if (-not (Test-Path $file)) {
        Write-Host "  SKIP  $file (not found)" -ForegroundColor Yellow
        continue
    }

    $content = Get-Content $file -Raw -Encoding UTF8
    $fileReplacements = 0

    foreach ($old in $replacements.Keys) {
        $new = $replacements[$old]
        if ($content -match [regex]::Escape($old)) {
            $content = $content -replace [regex]::Escape($old), $new
            $fileReplacements++
        }
    }

    if ($fileReplacements -gt 0) {
        Set-Content $file -Value $content -Encoding UTF8 -NoNewline
        Write-Host "  OK  $file  ($fileReplacements replacements)" -ForegroundColor Green
    } else {
        Write-Host "  --  $file  (nothing to replace)" -ForegroundColor Gray
    }

    $totalReplacements += $fileReplacements
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Done! $totalReplacements total replacements made." -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Your HTML files now reference local images." -ForegroundColor Green
Write-Host "Open index.html in your browser to check everything looks right." -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Open index.html in a browser and check images load" -ForegroundColor White
Write-Host "  2. Create a GitHub repo and push all files + the images folder" -ForegroundColor White
Write-Host "  3. Connect to Netlify and deploy" -ForegroundColor White
Write-Host ""

Read-Host "Press Enter to close"
