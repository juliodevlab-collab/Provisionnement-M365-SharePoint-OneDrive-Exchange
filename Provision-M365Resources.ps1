 # Set-MgUserLicense -UserId $userId -AddLicenses @{SkuId="c7df2760-2c53-4c64-a3f1-3b1c0f6f5a1c"}
 #  Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/users/$userId/drive"
 # Add-MgGroupMember -GroupId $groupId -DirectoryObjectId $userId



Import-Csv -Path "./users.csv" | ForEach-Object {

    $userId = $_.UserPrincipalName

    Write-Host "Provisionnement pour : $userId" -ForegroundColor Cyan

    # Attribution licence E5
    Set-MgUserLicense -UserId $userId -AddLicenses @{SkuId="c7df2760-2c53-4c64-a3f1-3b1c0f6f5a1c"} -RemoveLicenses @()

    # Provisionnement OneDrive
    Start-Sleep -Seconds 10
    Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/users/$userId/drive"

    # Ajout à un groupe SharePoint
    $groupId = "ID_DU_GROUPE_SHAREPOINT"
    Add-MgGroupMember -GroupId $groupId -DirectoryObjectId $userId

    Write-Host "Provisionnement terminé pour : $userId" -ForegroundColor Green
}

