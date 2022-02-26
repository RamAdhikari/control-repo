class profile::windows{
  if $facts['kernel']!='windows'{

    fail ('This class is for windows only')
  }
include profile::wrapper::odpengmdeatp
include profile::wrapper::odpengaclmachinekeys

}
