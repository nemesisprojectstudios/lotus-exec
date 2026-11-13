# Lotus - PowerShell one-liner to run without downloading
# Usage: iwr https://raw.githubusercontent.com/nemesisprojectstudios/lotus-exec/main/run-lotus.ps1 | iex
# Or: iwr https://raw.githubusercontent.com/nemesisprojectstudios/lotus-exec/main/run-lotus.ps1 -UseBasicParsing | iex

# This one-liner downloads and runs the latest Lotus.Nano.exe from the releases
# The executable is self-contained (no .NET install required)

$repo = "nemesisprojectstudios/lotus-exec"
$assetName = "Lotus.exe"
$downloadUrl = "https://github.com/$repo/releases/latest/download/$assetName"
$tempPath = "$env:TEMP\Lotus.exe"

Write-Host "Downloading Lotus from GitHub releases..." -ForegroundColor Cyan
try {
    Invoke-WebRequest -Uri $downloadUrl -OutFile $tempPath -UseBasicParsing -ErrorAction Stop
    Write-Host "Download complete. Running Lotus..." -ForegroundColor Green
    & $tempPath $args
} catch {
    Write-Error "Failed to download or run Lotus: $_"
    exit 1
} finally {
    # Clean up temp file after execution (optional - comment out if you want to keep it)
    Remove-Item -Path $tempPath -Force -ErrorAction SilentlyContinue
}
