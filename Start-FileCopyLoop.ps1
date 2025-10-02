Add-Type -AssemblyName System.Windows.Forms
$remotePath = "\\FILER.LOCAL\OS\Rocky-9.3-x86_64-minimal.iso"
$localPath = "C:\ADMIN\Rocky-9.3-x86_64-minimal.iso"

$totalIterations = 0
$totalTimeMs = 0
$totalBytesCopied = 0

while ($true) {
    $fileInfo = Get-Item $remotePath
    $fileSizeBytes = $fileInfo.Length
    $fileSizeMB = [math]::Round($fileSizeBytes / 1MB, 2)

    Write-Host "Copying $remotePath to $localPath" -ForegroundColor Cyan
    $startTime = Get-Date
    Copy-Item -Path $remotePath -Destination $localPath -Force

    #Write-Host "Copying $localPath to $remotePath" -ForegroundColor Cyan
    #Copy-Item -Path $localPath -Destination $remotePath -Force

    $endTime = Get-Date
    $elapsed = ($endTime - $startTime).TotalSeconds
    $elapsedMs = ($endTime - $startTime).TotalMilliseconds

    $totalTimeMs += $elapsedMs
    $totalIterations++
    $totalBytesCopied += ($fileSizeBytes * 2)

    $totalSeconds = [Math]::Round($totalTimeMs / 1000, 3)
    $speedMBps = [math]::Round(($fileSizeMB * 2) / $elapsed, 2)
    $totalSpeedMBps = [math]::Round(($totalBytesCopied / 1MB) / ($totalTimeMs / 1000), 2)

    Write-Host ("Iteration: {0} - Time elapsed this iteration: {1} ms - Total time: {2} s - Speed: {3} MB/sec - Total Speed: {4} MB/sec" -f `
        $totalIterations, [Math]::Round($elapsedMs, 2), $totalSeconds, $speedMBps, $totalSpeedMBps)

    Write-host "Sleeping for 2 seconds"
    Start-Sleep -Seconds 2
}
