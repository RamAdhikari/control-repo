class profile::windows::aclmachinekeys{

exec { 'machinekayacl':
  command   => file('windows/restore-machinekeys-acl.ps1'),
  unless    =>'if(((((((get-acl C:\\ProgramData\\Microsoft\\Crypto\\RSA\\MachineKeys).access)| select IdentityReference | ft -HideTableHeaders | Out-String).trim()) -replace "\`r\`n", "" ) -replace "              ",",") -ne "Everyone,BUILTIN\Administrators"){exit 1 }',
  provider  => powershell,
  }

}
