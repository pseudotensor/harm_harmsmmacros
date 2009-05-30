
set files = {
"dump0000"
"dump0001" 
"dump0002" 
"dump0003" 
"dump0004" 
"dump0005" 
"dump0006" 
"dump0007" 
"dump0008" 
"dump0009" 
"dump0010" 
"dump0011" 
"dump0012" 
"dump0013" 
"dump0014" 
"dump0015" 
"dump0016" 
"dump0017" 
"dump0018" 
"dump0019" 
"dump0020" 
}
define nf dimen(files)

macro read "/home/scn/sm/symmetry.m"

do if = 1 , $nf {
  define file (files[$($if-1)])
  jrdp $file
  write standard $file
  gammienew 
#  input "/home/scn/sm/scn.m"
#  input "/home/scn/sm/vsq_bsq.m"
  mirrordel rho
  mirrordel u  
  mirrordel v1 
  mirroradel v2 
  mirrordel v3 

  if( $if == 1 ) { 
    set dimen(rdrhotot) = $(dimen(rho))
    set dimen(  rdutot) = $(dimen(rho))
    set dimen( rdv1tot) = $(dimen(rho))
    set dimen( rdv2tot) = $(dimen(rho))
    set dimen( rdv3tot) = $(dimen(rho))
  }
  
  set rdrho$if =(rho==0.) ? abs(rhodiff) : abs(rhodiff/rho)
  set   rdu$if   = (u ==0.) ? abs(udiff) :  abs( udiff/u )
  set  rdv1$if  = (v1==0.) ? abs(v1diff) : abs(v1diff/v1)
  set  rdv2$if  = (v2==0.) ? abs(v2diff) : abs(v2diff/v2)
  set  rdv3$if  = (v3==0.) ? abs(v3diff) : abs(v3diff/v3)

  set rdrhotot = rdrhotot + rdrho$if
  set   rdutot =   rdutot +   rdu$if
  set  rdv1tot =  rdv1tot +  rdv1$if
  set  rdv2tot =  rdv2tot +  rdv2$if
  set  rdv3tot =  rdv3tot +  rdv3$if


  set  lrdrho$if = lg(  rdrho$if + 1.0e-15)
  set  lrdu$if = lg(    rdu$if + 1.0e-15)
  set  lrdv1$if = lg(   rdv1$if + 1.0e-15)
  set  lrdv2$if = lg(   rdv2$if + 1.0e-15)
  set  lrdv3$if = lg(   rdv3$if + 1.0e-15)

}

set rdrhotot = rdrhotot / $nf
set rdutot =   rdutot / $nf
set rdv1tot =  rdv1tot / $nf
set rdv2tot =  rdv2tot / $nf
set rdv3tot =  rdv3tot / $nf

set lrdrhotot = lg(rdrhotot + 1.0e-10)
set lrdutot   = lg(rdutot   + 1.0e-10)
set lrdv1tot  = lg(rdv1tot  + 1.0e-10)
set lrdv2tot  = lg(rdv2tot  + 1.0e-10)
set lrdv3tot  = lg(rdv3tot  + 1.0e-10)

set sumrdrho = sum(rdrhotot)
set sumrdu   = sum(rdutot)
set sumrdv1  = sum(rdv1tot)
set sumrdv2  = sum(rdv2tot)
set sumrdv3  = sum(rdv3tot)

print {sumrdrho}
print {sumrdu  }
print {sumrdv1 }
print {sumrdv2 }
print {sumrdv3 }

