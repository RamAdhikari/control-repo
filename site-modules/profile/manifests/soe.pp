class profile::soe {

$soe_os =$facts['os']['name']
$soe_major = facts['os']['release']['major']
$failmsg = "The SOE is unsupported on ${soe_os} ${soe_major} based systems."

case $soe_os{
  'windows':{
   include profile::windows
  }
  'CentOS','Redhat':{
    include profile::linux
  }
  default:{
    fail($failmsg)
    }
}
}


