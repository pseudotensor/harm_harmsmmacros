setupaverywind 0        #
		rdbasic 0 0 -1
		jre cartonly.m
		cartgrid
		rd dump0000.dat
		define PLANE 3
		define WHICHLEV 32
		plc 0 r
		#
computestuff 0 #   New way to compute specific angular momentum around accretor in lab frame
		#
		# accretor position
		set pos_accretorx=0.0
		set pos_accretory=0.0
		set pos_accretorz=0.0
		#
		# x,y,z away from accretor
		set rx=x12-pos_accretorx
		set ry=x22-pos_accretory
		set rz=x32-pos_accretorz
		#
		# radius coordinate away from accretor
		set myr=sqrt(rx**2+ry**2+rz**2)
		#
		# from 0_analdata.dat
		#
		set GMnorm=0.201384588
		set Omegasystem=1.78238
		set rcm=0.251182
		#
		# specific angular momentum IN rotating frame
		set lspec1=(ry*vz-rz*vy)
		set lspec2=(rz*vx-rx*vz)
		set lspec3=(rx*vy-ry*vx)
		#
		# SO NOW ONLY CAN LOOK AT Z-COMPONENT
		# specific angular momentum OF rotating frame
		set lspecrot3= Omegasystem*rx**2
		#
		# specific angular momentum OF rotating frame (WRONG WAY AGAIN)
		#set lspecrot1= - rcm*Omegasystem*rz
		#set lspecrot2= 0.0*ry
		#set lspecrot3= rcm*Omegasystem*rx
		#
		# specific angular momentum in lab-frame of accretor
		set lsp1=lspec1+lspecrot1
		set lsp2=lspec2+lspecrot2
		set lsp3=lspec3+lspecrot3
		#
		# magnitude of specific angular momentum
		set magl = sqrt(lsp1**2+lsp2**2+lsp3**2)
		#
		#
		set rcirc = lsp3**2/(GMnorm)
		#
		# magnitude of angular velocity around accretor if dominated by angular part
		set vphi=myr*magl
		#
		# thickness of flow around accretor
		set hor=cs/vphi
		#
		set LENGTHUNIT=1.9905912e+12
		set TIMEUNIT=34597.18985
		set MASSUNIT=7.88762472e+34
		set GMnorm=0.201384588
		#
		set maglcgs = magl*LENGTHUNIT**2/TIMEUNIT
		set Msolar=1.989E33
		set massbh = 10*Msolar
		set G=6.672E-8
		set C=2.99792458E10
		set lGEOMunit=G*massbh/C
		set maglGEOM=maglcgs/lGEOMunit
		#
		set rcgs=myr*LENGTHUNIT
		set vkep=rcgs*sqrt(G*massbh/rcgs**3)
		set lkep=rcgs*vkep
		#
		set lspecrat=maglcgs/lkep
		#
		#
plotlspec3 0    #
		define NEGCONTCOLOR blue
		define NEGCONTCOLOR blue
		plc 0 lr
		define NEGCONTCOLOR red
		define NEGCONTCOLOR default
		#plc 0 lsp3 010
		plc 0 rcirc 010
		#
plotrcirc1d 0   #
		#
		set iii=0,$nx*$ny*$nz-1
		set indexi=INT(iii%$nx)
		set indexj=INT((iii%($nx*$ny))/$nx)
		set indexk=INT(iii/($nx*$ny))
		#
		set myrcirc=rcirc if(indexj==32 && indexk==32)
		set myx12=x12  if(indexj==32 && indexk==32)
		set myi=indexi if(indexj==32 && indexk==32)
		#
		#pl 0 myx12 myrcirc 0100
		pl 0 myi myrcirc 0100
		ptype 3 3
		expand 2
		points myi (LG(myrcirc))
		expand 1.001
		#
plotvec 0       #
		vpl 0 v 1 12 
		#
movievec 0      #
		animvplplot 'dump' v 0.3 12 100
		# vpl 0 v .3 12 100
		#
oldlspec 0	#    Old and apparently (maybe?) wrong way to compute specific angular momentum around accretor in lab frame
		# assumes accretor at x=y=z=0
		set rx=x12-0
		set ry=x22-0
		set rz=x32-0
		# radius coordinate
		set myr=sqrt(rx**2+ry**2+rz**2)
		#
		set Omegasystem=1.78238
		set rcm=0.251182
		#
		# specific angular momentum OF rotating frame
		set lspecrot1=-myr**2*Omegasystem*(rx/myr)
		set lspecrot2=-myr**2*Omegasystem*(ry/myr)
		set lspecrot3=-myr**2*Omegasystem*(rz/myr-1)
		#
		# specific angular momentum IN rotating frame
		set lspec1=(ry*vz-rz*vy)
		set lspec2=(rz*vx-rx*vz)
		set lspec3=(rx*vy-ry*vx)
		#
		# specific angular momentum in lab-frame of accretor
		set lsp1=lspec1+lspecrot1
		set lsp2=lspec2+lspecrot2
		set lsp3=lspec3+lspecrot3
		#
		# magnitude of specific angular momentum
		set magl = sqrt(lsp1**2+lsp2**2+lsp3**2)
awplot1 0       #
		plc 0 lr
		plc 0 lspecrat 010
		#
iaverygrid 0    #
		#
		! ~/sm/dump_interp -nodumps -uin
		#
iaverydump 1   #
		#
		! ~/sm/dump_interp -nogrids -nogparam -uin -is=$1
		#
iaveryzoom 0    #
		! ~/sm/dump_interp -uin -is=20 -amin=-.1 -amax=.1
		#
sawi           0
		#
		define averywind 1
		#
		rdbasic 1 0 -1
		rd idump0020.dat
		#
		define WHICHLEV ($nz/2)
		define PLANE 3
		#
