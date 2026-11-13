# Lotus Nano - PowerShell one-liner to run without downloading
# Usage: iwr https://raw.githubusercontent.com/nemesisprojectstudios/lotus-nano/main/run.ps1 | iex
# Or: iwr https://raw.githubusercontent.com/nemesisprojectstudios/lotus-nano/main/run.ps1 -UseBasicParsing | iex

# This one-liner downloads and runs the latest Lotus.Nano.exe from the releases
# The executable is self-contained (no .NET install required)

$repo = "nemesisprojectstudios/lotus-nano"
$assetName = "Lotus.Nano.exe"
$downloadUrl = "https://github.com/$repo/releases/latest/download/$assetName"
$tempPath = "$env:TEMP\Lotus.Nano.exe"

Write-Host "Downloading Lotus.Nano from GitHub releases..." -ForegroundColor Cyan
try {
    Invoke-WebRequest -Uri $downloadUrl -OutFile $tempPath -UseBasicParsing -ErrorAction Stop
    Write-Host "Download complete. Running Lotus.Nano..." -ForegroundColor Green
    & $tempPath $args
} catch {
    Write-Error "Failed to download or run Lotus.Nano: $_"
    exit 1
} finally {
    # Clean up temp file after execution (optional - comment out if you want to keep it)
    Remove-Item -Path $tempPath -Force -ErrorAction SilentlyContinue
}
