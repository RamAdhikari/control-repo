class profile::windows::aclmachinekeys{

exec { 'machinekayacl':
  command   => file('profile/restore-machinekeys-acl.ps1'),
  unless    =>'if(((Get-Acl C:\\Programdata\\Microsoft\\Crypto\\RSA\\MachineKeys |select-object -ExpandProperty sddl|Out-String).length) -gt 45)){exit 1 }',
  provider  => powershell,
  }

}
