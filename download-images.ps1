# Hannah Moore Portfolio — Image Downloader
# Run this from inside your portfolio folder (where your HTML files live)
# Right-click this file and choose "Run with PowerShell"
# OR open PowerShell, navigate to your folder, and run: .\download-images.ps1

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Hannah Moore — Image Downloader" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Create folder structure
$folders = @("images", "images\interests", "images\projects", "images\logo")
foreach ($folder in $folders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder | Out-Null
        Write-Host "Created folder: $folder" -ForegroundColor Green
    }
}

# All images to download — [url, local path]
$images = @(
    # Logo
    @(
        "https://uploads-ssl.webflow.com/61088b79428861b097c4210b/63119fe3e078ad6e7fc8ce0d_Group%2021.svg",
        "images\logo\hannah-moore-logo.svg"
    ),

    # Interest grid images
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ad1064c8ce0e_interests2.PNG",
        "images\interests\interests-2.png"
    ),
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ad62dbc8ce2a_interests9.PNG",
        "images\interests\interests-9.png"
    ),
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ad8442c8ce1a_interests1.PNG",
        "images\interests\interests-1.png"
    ),
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ad22fdc8ce32_interests10.PNG",
        "images\interests\interests-10.png"
    ),
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ad48e3c8ce36_interests11.PNG",
        "images\interests\interests-11.png"
    ),
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ad528cc8ce26_interests7.PNG",
        "images\interests\interests-7.png"
    ),
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ade8b2c8ce12_interests3.PNG",
        "images\interests\interests-3.png"
    ),
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ada3f4c8ce16_interests4.PNG",
        "images\interests\interests-4.png"
    ),
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078ade1d0c8ce22_interests6.PNG",
        "images\interests\interests-6.png"
    ),

    # Developer Portfolio images
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/64eaee9b036004e0da2af69d_MacBook%20Pro%2016.png",
        "images\projects\dev-portfolio-macbook.png"
    ),
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/64eaf16f587c6d32b6a49762_Linkedin%20Image.png",
        "images\projects\dev-portfolio-linkedin.png"
    ),

    # Discord iOS Widget images
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/6311adc70d09393d87ca1867_Group%206.png",
        "images\projects\discord-overview.png"
    ),
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/6311adc70d09390c33ca186d_Group%20304.png",
        "images\projects\discord-research.png"
    ),
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/6311adc70d09391683ca186f_Group%20305.png",
        "images\projects\discord-wireframes.png"
    ),
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/6311adc70d093923fcca1873_Group%20306.png",
        "images\projects\discord-exploration.png"
    ),
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/6311adc70d093953beca1877_Group%20307.png",
        "images\projects\discord-hifi.png"
    ),
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/6311adc70d09393373ca187b_Group%20309.png",
        "images\projects\discord-final.png"
    ),

    # World Cosplay Summit images
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/63119fe3e078adadd1c8ce3a_Group%207%20(1).png",
        "images\projects\wcsa-design.png"
    ),
    @(
        "https://cdn.prod.website-files.com/61088b79428861b097c4210b/64eaeae5dbce9b580c045723_MacBook%20Pro%2016.png",
        "images\projects\wcsa-macbook.png"
    )
)

Write-Host "Downloading $($images.Count) images..." -ForegroundColor Yellow
Write-Host ""

$success = 0
$failed = 0

foreach ($pair in $images) {
    $url  = $pair[0]
    $dest = $pair[1]
    $name = Split-Path $dest -Leaf

    try {
        Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing -TimeoutSec 30
        Write-Host "  OK  $name" -ForegroundColor Green
        $success++
    } catch {
        Write-Host "  FAIL  $name  ($url)" -ForegroundColor Red
        $failed++
    }
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Done! $success downloaded, $failed failed." -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

if ($failed -gt 0) {
    Write-Host "Any failed images may have already been removed from Webflow's CDN." -ForegroundColor Yellow
    Write-Host "You can replace them manually with your own image files." -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "Next step: run update-image-paths.ps1 to update your HTML files." -ForegroundColor Cyan
Write-Host ""

Read-Host "Press Enter to close"
