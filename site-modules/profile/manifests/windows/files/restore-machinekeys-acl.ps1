$ErrorActionPreference = “stop”
Try{
    if(((((((get-acl C:\\ProgramData\\Microsoft\\Crypto\\RSA\\MachineKeys).access)| select IdentityReference | ft -HideTableHeaders | Out-String).trim()) -replace "\`r\`n", "" ) -replace "              ",",") -ne "Everyone,BUILTIN\Administrators")
    {
        $TargetFolder='C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys'
        $ExistingPermission=Get-Acl -Path $TargetFolder |FL|out-string
        $sddl=(get-acl -path $TargetFolder | Select-Object -ExpandProperty sddl| Out-String).Substring(0,13) + '(A;;0x12019f;;;WD)(A;;FA;;;BA)'
        $SecDes=get-acl -path $TargetFolder;
        $SecDes.setsecuritydescriptorsddlform($sddl);
        set-acl -Path $TargetFolder -aclobject $Secdes
        $Currentpermission = Get-Acl -Path $TargetFolder |FL|out-string
        Write-EventLog –LogName Application –Source “Puppet” –EntryType Warning –EventID 1000 –Message “Permission has been changed On MachineKeys.
        From: $ExistingPermission To: $Currentpermission”
    }
    else
    {
        Write-output "MachineKeys has default permission, no action required"   
    }
}
catch
{
    Write-EventLog –LogName Application –Source “Puppet” –EntryType Warning –EventID 1000 –Message "$error"
}
 
