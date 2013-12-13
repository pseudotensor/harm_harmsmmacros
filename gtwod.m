mov	3               #
		pl $1 $2
		do i=$2+1,$3,1 {\
			grd $i
			pla $1
		}
		#
plg	2	#
		#
		grd $2
		setgrd
		pla $1
jpl	2	#
		#
		jrd $2
		setgrd
		pla $1
setgrd	0	#
		set i=1,$n1*$n2
		#
		image($n1,$n2) $startx1 $stopx1 $startx2 $stopx2
		#
		set i1 = int((x1 - $startx1 - 0.4*$dx1)/$dx1)
		set i2 = int((x2 - $startx2 - 0.4*$dx2)/$dx2)
		set i3 = int((x3 - $startx3 - 0.4*$dx3)/$dx3)
		#
pla	1	#
		#
		set image[i1,i2] = $1[i-1]
		#
		limits $startx1 $stopx1 $startx2 $stopx2
		erase
		minmax min max echo $min $max
                define cres (50)
		if($min*$max < 0.) {\
	                #
                        define delta ((-$min)/$cres)
                        set lev=$min,-$delta,$delta
                        levels lev
                        ltype 2
                        contour
                        #
                        define delta ($max/$cres)
                        set lev=$delta,$max,$delta
                        levels lev
                        ltype 0
                        contour
                        #
		} \
		else {\
			set lev=$min,$max,($max-$min)/$cres
			levels lev
			ltype 0
			contour
		}
		#
		define tmp (lg(r[0]))
		define dum1 ($startx1/ln($cres) + $tmp)
		define dum2 ($stopx1/ln($cres)  + $tmp)
		limits $dum1 $dum2 $startx2 $stopx2
		ticksize -1 0 0 0 
		box
		limits $startx1 $stopx1 $startx2 $stopx2
		#
grd	1	#
		if($1 < 10) {define num <00$1>} \
                else {if($1 < 100) {define num <0$1>} \
                else {define num <$1>}}
                echo $num
		grdp dump$num
jrd	1	#
		if($1 < 10) {define num <000$1>} \
                else {if($1 < 100) {define num <00$1>} \
                else {if($1 < 1000) {define num <0$1>} \
		else {define num <$1>}}}
                echo $num
		jrdp dump$num
		gammienew
grdp	1	#
		#
		da dumps/$1
		lines 1 1
		read {_t 1 _n1 2 _n2 3 _startx1 4 _startx2 5 _dx1 6 _dx2 7}
		set _a=0.5
		set _R0=0
		set _Rin=1.96
		set _Rout=80
		set _hslope=0.2
		set _gam=4/3
		set _defcoord=0
		lines 2 10000000
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		     {x1 x2 r h rho u v1 v2 v3 \
		      B1 B2 B3 divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
		      v1m v1p v2m v2p gdet}
	        #
		#read {x1 3 x2 4 r 5 h 6 rho 7 u 8 v1 9 v2 10 v3 11 \
		#      B1 12 B2 13 B3 14 divb 15 \
		#      uu0 16 uu1 17 uu2 18 uu3 19 ud0 20 ud1 21 ud2 22 ud3 23 \
		#      bu0 24 bu1 25 bu2 26 bu3 27 bd0 28 bd1 29 bd2 30 bd3 31 \
		#      v1m 32 v1p 33 v2m 34 v2p 35 gdet 36}
	        #
                gsetup
		setgrd
		set ti=i1
		set tj=i2
		gcalc
 		#
jrdpallgrb 1    # for latest code (3d, with metric and EOS stuff)
                set h1='dump'
		set h1gdump='gdump'
		set h1eosdump='eosdump'
		set h1debugdump='debug'
		#
		define ii ($1)
		set h2=sprintf('%04d',$ii)
		set _fname=h1+h2
		set _fnamegdump=h1gdump+h2
		set _fnameeosdump=h1eosdump+h2
		set _fnamedebugdump=h1debugdump+h2
                #
		define filename (_fname)
		define filenamegdump (_fnamegdump)
		define filenameeosdump (_fnameeosdump)
		define filenamedebugdump (_fnamedebugdump)
		#
		#jrdp3dugrb $filename
                jrdpcf3dugrb $filename
		jrdpeos $filenameeosdump
		jrdpunits
                if($nx>1 && $ny==1 && $nz==1){\
		  grid3d $filenamegdump
                }
                #
                jrdpdebug $filenamedebugdump
		#
                #
jrdpallgrbvst 0 #               
                # load time-dependent stuff
                #
                jrdpgrbener
                #
                flenergrb flener.out
                #
                debugener
                #
                #
                #
		#
jrdpcf2d 1	# for reading file with current (jcon/jcov) and faraday (fcon,fcov).
		jrdpheader2d $1
		da dumps/$1
		lines 2 10000000
		#
		# 6+29+1+4*2+6*2=56
		#     1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {ti tj x1 x2 r h rho u v1 v2 v3 \
		      B1 B2 B3 divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
		     v1m v1p v2m v2p gdet \
		    ju0 ju1 ju2 ju3  \
		    jd0 jd1 jd2 jd3  \
		    fu0 fu1 fu2 fu3 fu4 fu5 \
		    fd0 fd1 fd2 fd3 fd4 fd5 }
		    #
		set tx1=x1
		set tx2=x2
                gsetup
		if($DOGCALC) { gcalc }
		# gcalc
		abscompute
 		#
		gammienew2d
 		#
jrdpcf 1        #
		jrdpcf3du $1
 		#
jrdpcf3du 1	# for reading file with current (jcon/jcov) and faraday (fcon,fcov).
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
		# 72
                set totalcolumns=3*3+8+3+8+1+4*4+6+1+4*2+6*2
                #
                if(totalcolumns!=_numcolumns || dimen(nprdumplist)!=8 || dimen(nprlist)!=8){\
                 echo "Wrong format"
                 print {totalcolumns _numcolumns}
                }\
                else{\
                     read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
                     {ti tj tk x1 x2 x3 r h ph rho u v1 v2 v3 \
		      B1 B2 B3 \
		      p cs2 Sden \
		      U0 U1 U2 U3 U4 U5 U6 U7 \
		      divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
                      v1m v1p v2m v2p v3m v3p gdet \
                      ju0 ju1 ju2 ju3  \
                      jd0 jd1 jd2 jd3  \
                      fu0 fu1 fu2 fu3 fu4 fu5 \
                      fd0 fd1 fd2 fd3 fd4 fd5 }
                     #
                     set tx1=x1
                     set tx2=x2
                     set tx3=x3
                     gsetup
                     if($DOGCALC) { gcalc }
                  # gcalc
                  abscompute
                  #
                  gammienew
                }
 		#
jrdpcf3dudipole 1	# for reading file with current (jcon/jcov) and faraday (fcon,fcov).
		jrdpheader3dold dumps/$1
		da dumps/$1
		lines 2 10000000
		#
                     read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
                     {ti tj tk x1 x2 x3 r h ph rho u v1 v2 v3 \
		      B1 B2 B3 \
		      p cs2 Sden \
		      U0 U1 U2 U3 U4 U5 U6 U7 \
		      divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
                      v1m v1p v2m v2p v3m v3p gdet \
                      ju0 ju1 ju2 ju3  \
                      jd0 jd1 jd2 jd3  \
                      fu0 fu1 fu2 fu3 fu4 fu5 \
                      fd0 fd1 fd2 fd3 fd4 fd5 }
                     #
                     set tx1=x1
                     set tx2=x2
                     set tx3=x3
                     gsetup
                     if($DOGCALC) { gcalc }
                  # gcalc
                  abscompute
                  #
                  gammienew
 		#
jrdpdissdipole 1	# for dissdump????
		jrdpheader3dold dumps/$1
		da dumps/$1
		lines 2 10000000
		#
                     read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
                     {diss0 diss1 diss2 diss3 diss4 diss5 diss6 diss7 diss8 diss9 \
                     diss10 diss11 diss12 diss13 diss14 diss15 diss16 diss17 dissfail }
                     #
 		#
                #
jrdpcf3duentropy 1	# for reading file with current (jcon/jcov) and faraday (fcon,fcov).
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
                # 73
		set totalcolumns=3*3+8+3+9 + 1 + 4*4+6+1 + 4*2+6*2
                #
                if(totalcolumns!=_numcolumns || dimen(nprdumplist)!=8 || dimen(nprlist)!=9){\
                 echo "Wrong format"
                 print {totalcolumns _numcolumns}
                }\
                else{\
                     read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
                     {ti tj tk x1 x2 x3 r h ph rho u v1 v2 v3 \
		      B1 B2 B3 \
		      p cs2 Sden \
		      U0 U1 U2 U3 U4 U5 U6 U7 U8 \
		      divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
                      v1m v1p v2m v2p v3m v3p gdet \
                      ju0 ju1 ju2 ju3  \
                      jd0 jd1 jd2 jd3  \
                      fu0 fu1 fu2 fu3 fu4 fu5 \
                      fd0 fd1 fd2 fd3 fd4 fd5 }
                     #
                     set tx1=x1
                     set tx2=x2
                     set tx3=x3
                     gsetup
                     if($DOGCALC) { gcalc }
                  # gcalc
                  abscompute
                  #
                  gammienew
                }
 		#
                #
jrdprad 1	# for reading file with full set of stuff with radiation
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
                # 81
        set NPR=13
        set NPRDUMP=12
        set nprend=12
        set NDIM=4
		set totalcolumns=3*3 + NPRDUMP + 3 + (nprend+1) + 1 + 4 * NDIM + 6 + 1 + NDIM*2 + 2*6
                #
                if(totalcolumns!=_numcolumns || dimen(nprdumplist)!=12 || dimen(nprlist)!=13){\
                 echo "Wrong format"
                 print {totalcolumns _numcolumns}
                 print {nprdumplist}
                 print {nprlist}
                }\
                else{\
                     read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
                     {ti tj tk x1 x2 x3 r h ph \
                      rho u v1 v2 v3 B1 B2 B3 prad0 prad1 prad2 prad3 \
		      p cs2 Sden \
		      U0 U1 U2 U3 U4  U5 U6 U7  U8 U9 U10 U11  U12 \
		      divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
                      v1m v1p v2m v2p v3m v3p gdet \
                      ju0 ju1 ju2 ju3  \
                      jd0 jd1 jd2 jd3  \
                      fu0 fu1 fu2 fu3 fu4 fu5 \
                      fd0 fd1 fd2 fd3 fd4 fd5 }
                     #
                     set tx1=x1
                     set tx2=x2
                     set tx3=x3
                     gsetup
                     if($DOGCALC) { gcalc }
                  # gcalc
                  abscompute
                  #
                  gammienew
                }
                #
                jrdpraddump rad$1
                jrdpdissmeasure dissmeasure$1
                jrdpraddims
                #
 #
 set qsqrad=gv311*prad1*prad1+gv312*prad1*prad2+gv313*prad1*prad3\
            +gv321*prad2*prad1+gv322*prad2*prad2+gv323*prad2*prad3\
            +gv331*prad3*prad1+gv332*prad3*prad2+gv333*prad3*prad3
 set gammarad=sqrt(1+qsqrad)
 set alpha=1/sqrt(-gn300)
 set uru0=gammarad/alpha
 set beta1=alpha**2*gn301
 set beta2=alpha**2*gn302
 set beta3=alpha**2*gn303
 set eta0=(1/alpha)
 set eta1=-(1/alpha)*beta1
 set eta2=-(1/alpha)*beta2
 set eta3=-(1/alpha)*beta3
 set uru1=prad1 + gammarad*eta1
 set uru2=prad2 + gammarad*eta2
 set uru3=prad3 + gammarad*eta3
 #
 #
 set uu0ortho=uu0*sqrt(abs(gv300))
 set uu1ortho=uu1*sqrt(abs(gv311))
 set uu2ortho=uu2*sqrt(abs(gv322))
 set uu3ortho=uu3*sqrt(abs(gv333))
 #
 set vu1ortho=uu1ortho/uu0ortho
 set vu2ortho=uu2ortho/uu0ortho
 set vu3ortho=uu3ortho/uu0ortho
 #
 set uur1ortho=uru1*sqrt(abs(gv311))
 set uur2ortho=uru2*sqrt(abs(gv322))
 set uur3ortho=uru3*sqrt(abs(gv333))
 set ursq=uur1ortho*uur1ortho+uur2ortho*uur2ortho+uur3ortho*uur3ortho
 set uur0ortho=sqrt(1.0+ursq)
 #
 set vur1ortho=uur1ortho/uur0ortho
 set vur2ortho=uur2ortho/uur0ortho
 set vur3ortho=uur3ortho/uur0ortho
 
 set Rtt=(-U8/gdet*sqrt(abs(gv300)))
 set Rtx=(U9/gdet*sqrt(abs(gn311)))
 set Rty=(U10/gdet*sqrt(abs(gn322)))
 set Rtz=(U11/gdet*sqrt(abs(gn333)))
 #
 set myRtt=(prad0/3)*(4*uur0ortho*uur0ortho-1)
 set myRtx=(prad0/3)*(4*uur0ortho*uur1ortho-0)
 set myRty=(prad0/3)*(4*uur0ortho*uur2ortho-0)
 set myRtz=(prad0/3)*(4*uur0ortho*uur3ortho-0)
 #
 #
jrdprad2 1	# for reading file with full set of stuff with radiation
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
                # 81
        set NPR=13
        set NPRDUMP=12
        set nprend=12
        set NDIM=4
		set totalcolumns=3*3 + NPRDUMP + 3 + (nprend+1) + 1 + 4 * NDIM + 6 + 1
                #
                if(totalcolumns!=_numcolumns || dimen(nprdumplist)!=12 || dimen(nprlist)!=13){\
                 echo "Wrong format"
                 print {totalcolumns _numcolumns}
                 print {nprdumplist}
                 print {nprlist}
                }\
                else{\
                     read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
                     {ti tj tk x1 x2 x3 r h ph \
                      rho u v1 v2 v3 B1 B2 B3 prad0 prad1 prad2 prad3 \
		      p cs2 Sden \
		      U0 U1 U2 U3 U4  U5 U6 U7  U8 U9 U10 U11  U12 \
		      divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
                      v1m v1p v2m v2p v3m v3p gdet }
                     #
                     set tx1=x1
                     set tx2=x2
                     set tx3=x3
                     gsetup
                     if($DOGCALC) { gcalc }
                  # gcalc
                  abscompute
                  #
                  gammienew
                }
                #
                jrdpraddump rad$1
                jrdpdissmeasure dissmeasure$1
                jrdpraddims
                #
 #
 set qsqrad=gv311*prad1*prad1+gv312*prad1*prad2+gv313*prad1*prad3\
            +gv321*prad2*prad1+gv322*prad2*prad2+gv323*prad2*prad3\
            +gv331*prad3*prad1+gv332*prad3*prad2+gv333*prad3*prad3
 set gammarad=sqrt(1+qsqrad)
 set alpha=1/sqrt(-gn300)
 set uru0=gammarad/alpha
 set beta1=alpha**2*gn301
 set beta2=alpha**2*gn302
 set beta3=alpha**2*gn303
 set eta0=(1/alpha)
 set eta1=-(1/alpha)*beta1
 set eta2=-(1/alpha)*beta2
 set eta3=-(1/alpha)*beta3
 set uru1=prad1 + gammarad*eta1
 set uru2=prad2 + gammarad*eta2
 set uru3=prad3 + gammarad*eta3
 #
 #
 set uu0ortho=uu0*sqrt(abs(gv300))
 set uu1ortho=uu1*sqrt(abs(gv311))
 set uu2ortho=uu2*sqrt(abs(gv322))
 set uu3ortho=uu3*sqrt(abs(gv333))
 #
 set vu1ortho=uu1ortho/uu0ortho
 set vu2ortho=uu2ortho/uu0ortho
 set vu3ortho=uu3ortho/uu0ortho
 #
 set uur1ortho=uru1*sqrt(abs(gv311))
 set uur2ortho=uru2*sqrt(abs(gv322))
 set uur3ortho=uru3*sqrt(abs(gv333))
 set ursq=uur1ortho*uur1ortho+uur2ortho*uur2ortho+uur3ortho*uur3ortho
 set uur0ortho=sqrt(1.0+ursq)
 #
 set vur1ortho=uur1ortho/uur0ortho
 set vur2ortho=uur2ortho/uur0ortho
 set vur3ortho=uur3ortho/uur0ortho
 
 set Rtt=(-U8/gdet*sqrt(abs(gv300)))
 set Rtx=(U9/gdet*sqrt(abs(gn311)))
 set Rty=(U10/gdet*sqrt(abs(gn322)))
 set Rtz=(U11/gdet*sqrt(abs(gn333)))
 #
 set myRtt=(prad0/3)*(4*uur0ortho*uur0ortho-1)
 set myRtx=(prad0/3)*(4*uur0ortho*uur1ortho-0)
 set myRty=(prad0/3)*(4*uur0ortho*uur2ortho-0)
 set myRtz=(prad0/3)*(4*uur0ortho*uur3ortho-0)
 #
 #
jrdpraddims 0
          da dimensions.txt
          lines 1 1
          read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
          {GGG CCCTRUE MSUNCM MPERSUN LBAR TBAR VBAR RHOBAR MBAR ENBAR UBAR TEMPBAR ARAD_CODE_DEF XFACT ZATOM AATOM MUE MUI OPACITYBAR MASSCM KORAL2HARMRHO1}
 		#
        set MSUN=1.9891E33
        set sigmaT=0.665E-24
        set mproton=1.673E-24
        set Ledd=4*pi*GGG*(MPERSUN*MSUN)*mproton*CCCTRUE/sigmaT
        set Leddcode = Ledd/ENBAR*TBAR
        set effnom = 1.0-tdeinfisco
        set Mdotedd = Ledd/(CCCTRUE**2*effnom)
        set Mdoteddcode = Mdotedd/MBAR*TBAR
        set rhoedd = Mdotedd/CCCTRUE*(GGG*MPERSUN*MSUN/CCCTRUE**2)/(GGG*MPERSUN*MSUN/CCCTRUE**2)**3
        set rhoeddcode = rhoedd/RHOBAR
        set uedd = rhoedd*CCCTRUE**2
        set bedd = sqrt(uedd)
        set ueddcode = uedd/UBAR
        set beddcode = bedd/sqrt(UBAR)
        print {effnom}
        print {Ledd Mdotedd rhoedd uedd bedd}
        print {Leddcode Mdoteddcode rhoeddcode ueddcode beddcode}
        #
        #
        #
jrdpcf3duentropystag 1	# for reading file with current (jcon/jcov) and faraday (fcon,fcov).
                  # for debugging
		#jrdpheader3dsasha dumps/$1
                jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
                # 76
		set totalcolumns=3*3+8+3+9 + 1 + 4*4+6+1 + 4*2+6*2 + 3
                #
                if(totalcolumns!=_numcolumns || dimen(nprdumplist)!=8 || dimen(nprlist)!=9){\
                 echo "Wrong format"
                 print {totalcolumns _numcolumns}
                }\
                else{\
                     read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
                     {ti tj tk x1 x2 x3 r h ph rho u v1 v2 v3 \
		      B1 B2 B3 \
		      p cs2 Sden \
		      U0 U1 U2 U3 U4 U5 U6 U7 U8 \
		      divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
                      v1m v1p v2m v2p v3m v3p gdet \
                      ju0 ju1 ju2 ju3  \
                      jd0 jd1 jd2 jd3  \
                      fu0 fu1 fu2 fu3 fu4 fu5 \
                      fd0 fd1 fd2 fd3 fd4 fd5 \
                      B1s B2s B3s}
                     #
                     set tx1=x1
                     set tx2=x2
                     set tx3=x3
                     gsetup
                     if($DOGCALC) { gcalc }
                  # gcalc
                  abscompute
                  #
                  gammienew
                }
 		#
                #
jrdpdissmeasure 1	# for reading file with dissmeasure stuff
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
        read '%g %g %g %g %g %g %g %g %g %g %g %g %g' \
                     {dm0 dm1 dm2 dm3 dm4 dm5 dm \
                      Fi1 Fi2 Fi3 \
                      Firad1 Firad2 Firad3 \
                     }
        #
        #
jrdppenna 1	# for reading file with current (jcon/jcov) and faraday (fcon,fcov).
		jrdpheader3dold dumps/$1
		da dumps/$1
		lines 2 10000000
		#
                # 9+8+3+8+1+16+6+1+8+12 = 72
                #
                read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
                     {ti tj tk x1 x2 x3 r h ph \
                      rho u v1 v2 v3 \
		      B1 B2 B3 \
		      p cs2 Sden \
		      U0 U1 U2 U3 U4 U5 U6 U7 \
		      divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
                      v1m v1p v2m v2p v3m v3p \
                      gdet \
                      ju0 ju1 ju2 ju3  \
                      jd0 jd1 jd2 jd3  \
                      fu0 fu1 fu2 fu3 fu4 fu5 \
                      fd0 fd1 fd2 fd3 fd4 fd5 }
                     #
                     set tx1=x1
                     set tx2=x2
                     set tx3=x3
                     gsetup
                     if($DOGCALC) { gcalc }
                  # gcalc
                  abscompute
                  #
                  gammienew
                #
 		#
                #
jrdpcf3dugrb 1	# for reading file with current (jcon/jcov) and faraday (fcon,fcov).
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
                # 77
                set totalcolumns=3*3+10+3+11+1+4*4+6+1+4*2+6*2
                #
                if(totalcolumns!=_numcolumns || dimen(nprdumplist)!=10 || dimen(nprlist)!=11){\
                 echo "Wrong format"
                 print {totalcolumns _numcolumns}
                }\
                else{\
                     #
                     #
                     # note that used to have "yl ynu" but now have "ye ynu"
                     read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
                     {ti tj tk x1 x2 x3 r h ph \
                      rho u v1 v2 v3 B1 B2 B3 ye ynu \
		      p cs2 Sden \
		      U0 U1 U2 U3 U4 U5 U6 U7 U8 U9 U10 \
		      divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
                      v1m v1p v2m v2p v3m v3p gdet \
                      ju0 ju1 ju2 ju3  \
                      jd0 jd1 jd2 jd3  \
                      fu0 fu1 fu2 fu3 fu4 fu5 \
                      fd0 fd1 fd2 fd3 fd4 fd5 }
                     #
                     set tx1=x1
                     set tx2=x2
                     set tx3=x3
                     gsetup
                     if($DOGCALC) { gcalc }
                  # gcalc
                  abscompute
                  #
                  gammienew
                }
                #
 		#
jrdpcf3duold 1	# for reading file with current (jcon/jcov) and faraday (fcon,fcov).
		jrdpheader3dold dumps/$1
		da dumps/$1
		lines 2 10000000
		#
		# 3*3+8+8+1+4*4+6+1+4*2+6*2=69
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {ti tj tk x1 x2 x3 r h ph rho u v1 v2 v3 \
		      B1 B2 B3 \
		      U0 U1 U2 U3 U4 U5 U6 U7 \
		      divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
		     v1m v1p v2m v2p v3m v3p gdet \
		    ju0 ju1 ju2 ju3  \
		    jd0 jd1 jd2 jd3  \
		    fu0 fu1 fu2 fu3 fu4 fu5 \
		    fd0 fd1 fd2 fd3 fd4 fd5 }
		    #
		set tx1=x1
		set tx2=x2
		set tx3=x3
                gsetup
		if($DOGCALC) { gcalc }
		# gcalc
		abscompute
 		#
		gammienew
 		#
jrdpcf3dold 1	# for reading file with current (jcon/jcov) and faraday (fcon,fcov).
		jrdpheader3dold dumps/$1
		da dumps/$1
		lines 2 10000000
		#
		# 3*3+8+1+4*4+6+1+4*2+6*2=61
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {ti tj tk x1 x2 x3 r h ph rho u v1 v2 v3 \
		      B1 B2 B3 divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
		     v1m v1p v2m v2p v3m v3p gdet \
		    ju0 ju1 ju2 ju3  \
		    jd0 jd1 jd2 jd3  \
		    fu0 fu1 fu2 fu3 fu4 fu5 \
		    fd0 fd1 fd2 fd3 fd4 fd5 }
		    #
		set tx1=x1
		set tx2=x2
		set tx3=x3
                gsetup
		if($DOGCALC) { gcalc }
		# gcalc
		abscompute
 		#
		gammienew
 		#
jrdpcfo1	1	# for reading file with current (jcon/jcov and time averages) and faraday (fcon,fcov and time averages).
		da dumps/$1
		lines 1 1
		set _dt=-1
		read '%g %d %d %g %g %g %g %d %g %g %g %g %g %g %g %g' \
		    {_t _n1 _n2 _startx1 _startx2 _dx1 _dx2 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord}
		    if(_dt==-1) {\
		           set _hslope=-1
		           read '%g %d %d %g %g %g %g %d %g %g %g %g %g %g' \
		               {_t _n1 _n2 _startx1 _startx2 _dx1 _dx2 _realnstep _gam _a _R0 _Rin _Rout _hslope}
		               if(_hslope==-1)	{\
		                      read '%g %d %d %g %g %g %g' \
		                   {_t _n1 _n2 _startx1 _startx2 _dx1 _dx2 }
		                   da dumps/dumphead2
		                   lines 1 1
		                   read '%g %g %g %g %g %g' \
		                       {_gam _a _R0 _Rin _Rout _hslope}
		                       set _realnstep=0 # some didn't have this, some did
		               }
		    }
		    #
		    if(_hslope==-1) { echo "error with hslope $myhostname $mydirname" }
		da dumps/$1
		lines 2 10000000
		#
		#     1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {ti tj x1 x2 r h rho u v1 v2 v3 \
		      B1 B2 B3 divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
		     v1m v1p v2m v2p gdet \
		    ju0 ju1 ju2 ju3 jau0 jau1 jau2 jau3 jbu0 jbu1 jbu2 jbu3 \
		    jd0 jd1 jd2 jd3 jad0 jad1 jad2 jad3 jbd0 jbd1 jbd2 jbd3 \
		    fu0 fu1 fu2 fu3 fu4 fu5 fau0 fau1 fau2 fau3 fau4 fau5 fbu0 fbu1 fbu2 fbu3 fbu4 fbu5 \
		    fd0 fd1 fd2 fd3 fd4 fd5 fad0 fad1 fad2 fad3 fad4 fad5 fbd0 fbd1 fbd2 fbd3 fbd4 fbd5 }
		    #
		set tx1=x1
		set tx2=x2
                gsetup
		if($DOGCALC) { gcalc }
		# gcalc
 		#
		abscompute
		#
		gammienew
		#
jrdptavg	2	# for reading tavg files
		# jrdptavg avgavg1040 1
		#
		da dumps/$1
		lines 1 1
		set _dt=-1
		read '%g %d %d %g %g %g %g %d %g %g %g %g %g %g %g %g' \
		    {_t _n1 _n2 _startx1 _startx2 _dx1 _dx2 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord}
		    if(_dt==-1) {\
		           set _hslope=-1
		           read '%g %d %d %g %g %g %g %d %g %g %g %g %g %g' \
		               {_t _n1 _n2 _startx1 _startx2 _dx1 _dx2 _realnstep _gam _a _R0 _Rin _Rout _hslope}
		               if(_hslope==-1)	{\
		                      read '%g %d %d %g %g %g %g' \
		                   {_t _n1 _n2 _startx1 _startx2 _dx1 _dx2 }
		                   da dumps/dumphead2
		                   lines 1 1
		                   read '%g %g %g %g %g %g' \
		                       {_gam _a _R0 _Rin _Rout _hslope}
		                       set _realnstep=0 # some didn't have this, some did
		               }
		    }
		    #
		    if(_hslope==-1) { echo "error with hslope $myhostname $mydirname" }
		da dumps/$1
		lines 2 10000000
		#
		# 329
		read '%d %d %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {ti tj x1 x2 r h gdet \
		     rhotavg utavg vtavg1 vtavg2 vtavg3 \
		     Btavg1 Btavg2 Btavg3 divbtavg \
		     uutavg0 uutavg1 uutavg2 uutavg3 udtavg0 udtavg1 udtavg2 udtavg3 \
		     butavg0 butavg1 butavg2 butavg3 bdtavg0 bdtavg1 bdtavg2 bdtavg3 \
		     vmtavg1 vptavg1 vmtavg2 vptavg2 \
		    rhoatavg uatavg vatavg1 vatavg2 vatavg3 \
		    Batavg1 Batavg2 Batavg3 divbatavg \
		    uuatavg0 uuatavg1 uuatavg2 uuatavg3 udatavg0 udatavg1 udatavg2 udatavg3 \
		    buatavg0 buatavg1 buatavg2 buatavg3 bdatavg0 bdatavg1 bdatavg2 bdatavg3 \
		    vmatavg1 vpatavg1 vmatavg2 vpatavg2 \
		     jutavg0 jutavg1 jutavg2 jutavg3 \
		     jdtavg0 jdtavg1 jdtavg2 jdtavg3 \
		     juatavg0 juatavg1 juatavg2 juatavg3 \
		     jdatavg0 jdatavg1 jdatavg2 jdatavg3 \
		    mfltavg0 mfltavg1 mfltavg2 mfltavg3 \
		    amfltavg0 amfltavg1 amfltavg2 amfltavg3 \
		    omega3tavg \
		    aomega3tavg \
		    futavg0 futavg1 futavg2 futavg3 futavg4 futavg5 \
		    fdtavg0 fdtavg1 fdtavg2 fdtavg3 fdtavg4 fdtavg5 \
		    fuatavg0 fuatavg1 fuatavg2 fuatavg3 fuatavg4 fuatavg5 \
		    fdatavg0 fdatavg1 fdatavg2 fdatavg3 fdatavg4 fdatavg5 \
		    Tud00tavgpart0 Tud01tavgpart0 Tud02tavgpart0 Tud03tavgpart0 \
		    Tud10tavgpart0 Tud11tavgpart0 Tud12tavgpart0 Tud13tavgpart0 \
		    Tud20tavgpart0 Tud21tavgpart0 Tud22tavgpart0 Tud23tavgpart0 \
		    Tud30tavgpart0 Tud31tavgpart0 Tud32tavgpart0 Tud33tavgpart0 \
		    Tud00tavgpart1 Tud01tavgpart1 Tud02tavgpart1 Tud03tavgpart1 \
		    Tud10tavgpart1 Tud11tavgpart1 Tud12tavgpart1 Tud13tavgpart1 \
		    Tud20tavgpart1 Tud21tavgpart1 Tud22tavgpart1 Tud23tavgpart1 \
		    Tud30tavgpart1 Tud31tavgpart1 Tud32tavgpart1 Tud33tavgpart1 \
		    Tud00tavgpart2 Tud01tavgpart2 Tud02tavgpart2 Tud03tavgpart2 \
		    Tud10tavgpart2 Tud11tavgpart2 Tud12tavgpart2 Tud13tavgpart2 \
		    Tud20tavgpart2 Tud21tavgpart2 Tud22tavgpart2 Tud23tavgpart2 \
		    Tud30tavgpart2 Tud31tavgpart2 Tud32tavgpart2 Tud33tavgpart2 \
		    Tud00tavgpart3 Tud01tavgpart3 Tud02tavgpart3 Tud03tavgpart3 \
		    Tud10tavgpart3 Tud11tavgpart3 Tud12tavgpart3 Tud13tavgpart3 \
		    Tud20tavgpart3 Tud21tavgpart3 Tud22tavgpart3 Tud23tavgpart3 \
		    Tud30tavgpart3 Tud31tavgpart3 Tud32tavgpart3 Tud33tavgpart3 \
		    Tud00tavgpart4 Tud01tavgpart4 Tud02tavgpart4 Tud03tavgpart4 \
		    Tud10tavgpart4 Tud11tavgpart4 Tud12tavgpart4 Tud13tavgpart4 \
		    Tud20tavgpart4 Tud21tavgpart4 Tud22tavgpart4 Tud23tavgpart4 \
		    Tud30tavgpart4 Tud31tavgpart4 Tud32tavgpart4 Tud33tavgpart4 \
		    Tud00tavgpart5 Tud01tavgpart5 Tud02tavgpart5 Tud03tavgpart5 \
		    Tud10tavgpart5 Tud11tavgpart5 Tud12tavgpart5 Tud13tavgpart5 \
		    Tud20tavgpart5 Tud21tavgpart5 Tud22tavgpart5 Tud23tavgpart5 \
		    Tud30tavgpart5 Tud31tavgpart5 Tud32tavgpart5 Tud33tavgpart5 \
		    Tud00tavgpart6 Tud01tavgpart6 Tud02tavgpart6 Tud03tavgpart6 \
		    Tud10tavgpart6 Tud11tavgpart6 Tud12tavgpart6 Tud13tavgpart6 \
		    Tud20tavgpart6 Tud21tavgpart6 Tud22tavgpart6 Tud23tavgpart6 \
		    Tud30tavgpart6 Tud31tavgpart6 Tud32tavgpart6 Tud33tavgpart6 \
		     Tud00atavgpart0 Tud01atavgpart0 Tud02atavgpart0 Tud03atavgpart0 \
		    Tud10atavgpart0 Tud11atavgpart0 Tud12atavgpart0 Tud13atavgpart0 \
		    Tud20atavgpart0 Tud21atavgpart0 Tud22atavgpart0 Tud23atavgpart0 \
		    Tud30atavgpart0 Tud31atavgpart0 Tud32atavgpart0 Tud33atavgpart0 \
		    Tud00atavgpart1 Tud01atavgpart1 Tud02atavgpart1 Tud03atavgpart1 \
		    Tud10atavgpart1 Tud11atavgpart1 Tud12atavgpart1 Tud13atavgpart1 \
		    Tud20atavgpart1 Tud21atavgpart1 Tud22atavgpart1 Tud23atavgpart1 \
		    Tud30atavgpart1 Tud31atavgpart1 Tud32atavgpart1 Tud33atavgpart1 \
		    Tud00atavgpart2 Tud01atavgpart2 Tud02atavgpart2 Tud03atavgpart2 \
		    Tud10atavgpart2 Tud11atavgpart2 Tud12atavgpart2 Tud13atavgpart2 \
		    Tud20atavgpart2 Tud21atavgpart2 Tud22atavgpart2 Tud23atavgpart2 \
		    Tud30atavgpart2 Tud31atavgpart2 Tud32atavgpart2 Tud33atavgpart2 \
		    Tud00atavgpart3 Tud01atavgpart3 Tud02atavgpart3 Tud03atavgpart3 \
		    Tud10atavgpart3 Tud11atavgpart3 Tud12atavgpart3 Tud13atavgpart3 \
		    Tud20atavgpart3 Tud21atavgpart3 Tud22atavgpart3 Tud23atavgpart3 \
		    Tud30atavgpart3 Tud31atavgpart3 Tud32atavgpart3 Tud33atavgpart3 \
		    Tud00atavgpart4 Tud01atavgpart4 Tud02atavgpart4 Tud03atavgpart4 \
		    Tud10atavgpart4 Tud11atavgpart4 Tud12atavgpart4 Tud13atavgpart4 \
		    Tud20atavgpart4 Tud21atavgpart4 Tud22atavgpart4 Tud23atavgpart4 \
		    Tud30atavgpart4 Tud31atavgpart4 Tud32atavgpart4 Tud33atavgpart4 \
		    Tud00atavgpart5 Tud01atavgpart5 Tud02atavgpart5 Tud03atavgpart5 \
		    Tud10atavgpart5 Tud11atavgpart5 Tud12atavgpart5 Tud13atavgpart5 \
		    Tud20atavgpart5 Tud21atavgpart5 Tud22atavgpart5 Tud23atavgpart5 \
		    Tud30atavgpart5 Tud31atavgpart5 Tud32atavgpart5 Tud33atavgpart5 \
		    Tud00atavgpart6 Tud01atavgpart6 Tud02atavgpart6 Tud03atavgpart6 \
		    Tud10atavgpart6 Tud11atavgpart6 Tud12atavgpart6 Tud13atavgpart6 \
		    Tud20atavgpart6 Tud21atavgpart6 Tud22atavgpart6 Tud23atavgpart6 \
		    Tud30atavgpart6 Tud31atavgpart6 Tud32atavgpart6 Tud33atavgpart6 }
		    #
		set tx1=x1
		set tx2=x2
		if($2==1){\
		       tavg2normal
		       gsetup
		       if($DOGCALC) { gcalc }
		       # gcalc
		    }
		    #
		    gammienew
 		#
tavg2normal    0 #
		set rho=rhotavg
		set u=utavg
		set v1=vtavg1
		set v2=vtavg2
		set v3=vtavg3		
		set B1=Btavg1
		set B2=Btavg2
		set B3=Btavg3
		set divb=divbtavg
		#
		set uu0=uutavg0
		set uu1=uutavg1
		set uu2=uutavg2
		set uu3=uutavg3
		set ud0=udtavg0
		set ud1=udtavg1
		set ud2=udtavg2
		set ud3=udtavg3
		#
		set bu0=butavg0
		set bu1=butavg1
		set bu2=butavg2
		set bu3=butavg3
		set bd0=bdtavg0
		set bd1=bdtavg1
		set bd2=bdtavg2
		set bd3=bdtavg3
		#
		set vm1=vmtavg1
		set vp1=vptavg1
		set vm2=vmtavg2
		set vp2=vptavg2
 
		   		set rhoa=rhoatavg
		set ua=uatavg
		set v1a=vatavg1
		set v2a=vatavg2
		set v3a=vatavg3
 
		   		set B1a=Batavg1
		set B2a=Batavg2
		set B3a=Batavg3
		set divba=divbatavg
 
		set uu0a=uuatavg0
		set uu1a=uuatavg1
		set uu2a=uuatavg2
		set uu3a=uuatavg3
		set ud0a=udatavg0
		set ud1a=udatavg1
		set ud2a=udatavg2
		set ud3a=udatavg3
 
		set bu0a=buatavg0
		set bu1a=buatavg1
		set bu2a=buatavg2
		set bu3a=buatavg3
		set bd0a=bdatavg0
		set bd1a=bdatavg1
		set bd2a=bdatavg2
		set bd3a=bdatavg3
 
		   		set vm1a=vmatavg1
		set vp1a=vpatavg1
		set vm2a=vmatavg2
		set vp2a=vpatavg2
 
		    		set ju0=jutavg0
		set ju1=jutavg1
		set ju2=jutavg2
		set ju3=jutavg3
 
		    		set jd0=jdtavg0
		set jd1=jdtavg1
		set jd2=jdtavg2
		set jd3=jdtavg3
 
		    		set ju0a=juatavg0
		set ju1a=juatavg1
		set ju2a=juatavg2
		set ju3a=juatavg3
 
		    		set jd0a=jdatavg0
		set jd1a=jdatavg1
		set jd2a=jdatavg2
		set jd3a=jdatavg3

		set mfl0=mfltavg0
		set mfl1=mfltavg1
		set mfl2=mfltavg2
		set mfl3=mfltavg3

		set amfl0=amfltavg0
		set amfl1=amfltavg1
		set amfl2=amfltavg2
		set amfl3=amfltavg3

		set mfl=mfl1
		set amfl=amfl1
		
		set omega3=omega3tavg
		set aomega3=aomega3tavg

		set fuu00=0*gdet
		set fuu11=0*gdet
		set fuu22=0*gdet
		set fuu33=0*gdet
		set afuu00=0*gdet
		set afuu11=0*gdet
		set afuu22=0*gdet
		set afuu33=0*gdet

		set fdd00=0*gdet
		set fdd11=0*gdet
		set fdd22=0*gdet
		set fdd33=0*gdet
		set afdd00=0*gdet
		set afdd11=0*gdet
		set afdd22=0*gdet
		set afdd33=0*gdet

		set fu0=futavg0 set fuu01=fu0 set fuu10=-fu0
		set fu1=futavg1 set fuu02=fu1 set fuu20=-fu1
		set fu2=futavg2 set fuu03=fu2 set fuu30=-fu2
		set fu3=futavg3 set fuu12=fu3 set fuu21=-fu3
		set fu4=futavg4 set fuu13=fu4 set fuu31=-fu4
		set fu5=futavg5 set fuu23=fu5 set fuu32=-fu5
 
		set fd0=fdtavg0 set fdd01=fd0 set fdd10=-fd0
		set fd1=fdtavg1 set fdd02=fd1 set fdd20=-fd1
		set fd2=fdtavg2 set fdd03=fd2 set fdd30=-fd2
		set fd3=fdtavg3 set fdd12=fd3 set fdd21=-fd3
		set fd4=fdtavg4 set fdd13=fd4 set fdd31=-fd4
		set fd5=fdtavg5 set fdd23=fd5 set fdd32=-fd5
 
		set fu0a=fuatavg0 set afuu01=fu0a set afuu10=-fu0a
		set fu1a=fuatavg1 set afuu02=fu1a set afuu20=-fu1a
		set fu2a=fuatavg2 set afuu03=fu2a set afuu30=-fu2a
		set fu3a=fuatavg3 set afuu12=fu3a set afuu21=-fu3a
		set fu4a=fuatavg4 set afuu13=fu4a set afuu31=-fu4a
		set fu5a=fuatavg5 set afuu23=fu5a set afuu32=-fu5a
		
		set fd0a=fdatavg0 set afdd01=fd0a set afdd10=-fd0a
		set fd1a=fdatavg1 set afdd02=fd1a set afdd20=-fd1a
		set fd2a=fdatavg2 set afdd03=fd2a set afdd30=-fd2a
		set fd3a=fdatavg3 set afdd12=fd3a set afdd21=-fd3a
		set fd4a=fdatavg4 set afdd13=fd4a set afdd31=-fd4a
		set fd5a=fdatavg5 set afdd23=fd5a set afdd32=-fd5a

		set omegaf1=fdd01/fdd13 # = ftr/frp
		set omegaf2=fdd02/fdd23 # = fth/fhp
		#
		set aomegaf1=afdd01/afdd13 # = ftr/frp
		set aomegaf2=afdd02/afdd23 # = fth/fhp
		#

		
		   		set Tud00part0=Tud00tavgpart0
		set Tud01part0=Tud01tavgpart0
		set Tud02part0=Tud02tavgpart0
		set Tud03part0=Tud03tavgpart0
 
		   		set Tud10part0=Tud10tavgpart0
		set Tud11part0=Tud11tavgpart0
		set Tud12part0=Tud12tavgpart0
		set Tud13part0=Tud13tavgpart0
 
		   		set Tud20part0=Tud20tavgpart0
		set Tud21part0=Tud21tavgpart0
		set Tud22part0=Tud22tavgpart0
		set Tud23part0=Tud23tavgpart0
 
		   		set Tud30part0=Tud30tavgpart0
		set Tud31part0=Tud31tavgpart0
		set Tud32part0=Tud32tavgpart0
		set Tud33part0=Tud33tavgpart0
 
		   		set Tud00part1=Tud00tavgpart1
		set Tud01part1=Tud01tavgpart1
		set Tud02part1=Tud02tavgpart1
		set Tud03part1=Tud03tavgpart1
 
		   		set Tud10part1=Tud10tavgpart1
		set Tud11part1=Tud11tavgpart1
		set Tud12part1=Tud12tavgpart1
		set Tud13part1=Tud13tavgpart1
 
		   		set Tud20part1=Tud20tavgpart1
		set Tud21part1=Tud21tavgpart1
		set Tud22part1=Tud22tavgpart1
		set Tud23part1=Tud23tavgpart1
 
		   		set Tud30part1=Tud30tavgpart1
		set Tud31part1=Tud31tavgpart1
		set Tud32part1=Tud32tavgpart1
		set Tud33part1=Tud33tavgpart1
 
		   		set Tud00part2=Tud00tavgpart2
		set Tud01part2=Tud01tavgpart2
		set Tud02part2=Tud02tavgpart2
		set Tud03part2=Tud03tavgpart2
 
		   		set Tud10part2=Tud10tavgpart2
		set Tud11part2=Tud11tavgpart2
		set Tud12part2=Tud12tavgpart2
		set Tud13part2=Tud13tavgpart2
 
		   		set Tud20part2=Tud20tavgpart2
		set Tud21part2=Tud21tavgpart2
		set Tud22part2=Tud22tavgpart2
		set Tud23part2=Tud23tavgpart2
 
		   		set Tud30part2=Tud30tavgpart2
		set Tud31part2=Tud31tavgpart2
		set Tud32part2=Tud32tavgpart2
		set Tud33part2=Tud33tavgpart2
 
		   		set Tud00part3=Tud00tavgpart3
		set Tud01part3=Tud01tavgpart3
		set Tud02part3=Tud02tavgpart3
		set Tud03part3=Tud03tavgpart3
 
		   		set Tud10part3=Tud10tavgpart3
		set Tud11part3=Tud11tavgpart3
		set Tud12part3=Tud12tavgpart3
		set Tud13part3=Tud13tavgpart3
 
		   		set Tud20part3=Tud20tavgpart3
		set Tud21part3=Tud21tavgpart3
		set Tud22part3=Tud22tavgpart3
		set Tud23part3=Tud23tavgpart3
 
		   		set Tud30part3=Tud30tavgpart3
		set Tud31part3=Tud31tavgpart3
		set Tud32part3=Tud32tavgpart3
		set Tud33part3=Tud33tavgpart3
 
		   		set Tud00part4=Tud00tavgpart4
		set Tud01part4=Tud01tavgpart4
		set Tud02part4=Tud02tavgpart4
		set Tud03part4=Tud03tavgpart4
 
		   		set Tud10part4=Tud10tavgpart4
		set Tud11part4=Tud11tavgpart4
		set Tud12part4=Tud12tavgpart4
		set Tud13part4=Tud13tavgpart4
 
		   		set Tud20part4=Tud20tavgpart4
		set Tud21part4=Tud21tavgpart4
		set Tud22part4=Tud22tavgpart4
		set Tud23part4=Tud23tavgpart4
 
		   		set Tud30part4=Tud30tavgpart4
		set Tud31part4=Tud31tavgpart4
		set Tud32part4=Tud32tavgpart4
		set Tud33part4=Tud33tavgpart4
 
		   		set Tud00part5=Tud00tavgpart5
		set Tud01part5=Tud01tavgpart5
		set Tud02part5=Tud02tavgpart5
		set Tud03part5=Tud03tavgpart5
 
		   		set Tud10part5=Tud10tavgpart5
		set Tud11part5=Tud11tavgpart5
		set Tud12part5=Tud12tavgpart5
		set Tud13part5=Tud13tavgpart5
 
		   		set Tud20part5=Tud20tavgpart5
		set Tud21part5=Tud21tavgpart5
		set Tud22part5=Tud22tavgpart5
		set Tud23part5=Tud23tavgpart5
 
		   		set Tud30part5=Tud30tavgpart5
		set Tud31part5=Tud31tavgpart5
		set Tud32part5=Tud32tavgpart5
		set Tud33part5=Tud33tavgpart5
 
		   		set Tud00part6=Tud00tavgpart6
		set Tud01part6=Tud01tavgpart6
		set Tud02part6=Tud02tavgpart6
		set Tud03part6=Tud03tavgpart6
 
		   		set Tud10part6=Tud10tavgpart6
		set Tud11part6=Tud11tavgpart6
		set Tud12part6=Tud12tavgpart6
		set Tud13part6=Tud13tavgpart6
 
		   		set Tud20part6=Tud20tavgpart6
		set Tud21part6=Tud21tavgpart6
		set Tud22part6=Tud22tavgpart6
		set Tud23part6=Tud23tavgpart6
 
		   		set Tud30part6=Tud30tavgpart6
		set Tud31part6=Tud31tavgpart6
		set Tud32part6=Tud32tavgpart6
		set Tud33part6=Tud33tavgpart6
 
		    		set Tud00part0a=Tud00atavgpart0
		set Tud01part0a=Tud01atavgpart0
		set Tud02part0a=Tud02atavgpart0
		set Tud03part0a=Tud03atavgpart0
 
		   		set Tud10part0a=Tud10atavgpart0
		set Tud11part0a=Tud11atavgpart0
		set Tud12part0a=Tud12atavgpart0
		set Tud13part0a=Tud13atavgpart0
 
		   		set Tud20part0a=Tud20atavgpart0
		set Tud21part0a=Tud21atavgpart0
		set Tud22part0a=Tud22atavgpart0
		set Tud23part0a=Tud23atavgpart0
 
		   		set Tud30part0a=Tud30atavgpart0
		set Tud31part0a=Tud31atavgpart0
		set Tud32part0a=Tud32atavgpart0
		set Tud33part0a=Tud33atavgpart0
 
		   		set Tud00part1a=Tud00atavgpart1
		set Tud01part1a=Tud01atavgpart1
		set Tud02part1a=Tud02atavgpart1
		set Tud03part1a=Tud03atavgpart1
 
		   		set Tud10part1a=Tud10atavgpart1
		set Tud11part1a=Tud11atavgpart1
		set Tud12part1a=Tud12atavgpart1
		set Tud13part1a=Tud13atavgpart1
 
		   		set Tud20part1a=Tud20atavgpart1
		set Tud21part1a=Tud21atavgpart1
		set Tud22part1a=Tud22atavgpart1
		set Tud23part1a=Tud23atavgpart1
 
		   		set Tud30part1a=Tud30atavgpart1
		set Tud31part1a=Tud31atavgpart1
		set Tud32part1a=Tud32atavgpart1
		set Tud33part1a=Tud33atavgpart1
 
		   		set Tud00part2a=Tud00atavgpart2
		set Tud01part2a=Tud01atavgpart2
		set Tud02part2a=Tud02atavgpart2
		set Tud03part2a=Tud03atavgpart2
 
		   		set Tud10part2a=Tud10atavgpart2
		set Tud11part2a=Tud11atavgpart2
		set Tud12part2a=Tud12atavgpart2
		set Tud13part2a=Tud13atavgpart2
 
		   		set Tud20part2a=Tud20atavgpart2
		set Tud21part2a=Tud21atavgpart2
		set Tud22part2a=Tud22atavgpart2
		set Tud23part2a=Tud23atavgpart2
 
		   		set Tud30part2a=Tud30atavgpart2
		set Tud31part2a=Tud31atavgpart2
		set Tud32part2a=Tud32atavgpart2
		set Tud33part2a=Tud33atavgpart2
 
		   		set Tud00part3a=Tud00atavgpart3
		set Tud01part3a=Tud01atavgpart3
		set Tud02part3a=Tud02atavgpart3
		set Tud03part3a=Tud03atavgpart3
 
		   		set Tud10part3a=Tud10atavgpart3
		set Tud11part3a=Tud11atavgpart3
		set Tud12part3a=Tud12atavgpart3
		set Tud13part3a=Tud13atavgpart3
 
		   		set Tud20part3a=Tud20atavgpart3
		set Tud21part3a=Tud21atavgpart3
		set Tud22part3a=Tud22atavgpart3
		set Tud23part3a=Tud23atavgpart3
 
		   		set Tud30part3a=Tud30atavgpart3
		set Tud31part3a=Tud31atavgpart3
		set Tud32part3a=Tud32atavgpart3
		set Tud33part3a=Tud33atavgpart3
 
		   		set Tud00part4a=Tud00atavgpart4
		set Tud01part4a=Tud01atavgpart4
		set Tud02part4a=Tud02atavgpart4
		set Tud03part4a=Tud03atavgpart4
 
		   		set Tud10part4a=Tud10atavgpart4
		set Tud11part4a=Tud11atavgpart4
		set Tud12part4a=Tud12atavgpart4
		set Tud13part4a=Tud13atavgpart4
 
		   		set Tud20part4a=Tud20atavgpart4
		set Tud21part4a=Tud21atavgpart4
		set Tud22part4a=Tud22atavgpart4
		set Tud23part4a=Tud23atavgpart4
 
		   		set Tud30part4a=Tud30atavgpart4
		set Tud31part4a=Tud31atavgpart4
		set Tud32part4a=Tud32atavgpart4
		set Tud33part4a=Tud33atavgpart4
 
		   		set Tud00part5a=Tud00atavgpart5
		set Tud01part5a=Tud01atavgpart5
		set Tud02part5a=Tud02atavgpart5
		set Tud03part5a=Tud03atavgpart5
 
		   		set Tud10part5a=Tud10atavgpart5
		set Tud11part5a=Tud11atavgpart5
		set Tud12part5a=Tud12atavgpart5
		set Tud13part5a=Tud13atavgpart5
 
		   		set Tud20part5a=Tud20atavgpart5
		set Tud21part5a=Tud21atavgpart5
		set Tud22part5a=Tud22atavgpart5
		set Tud23part5a=Tud23atavgpart5
 
		   		set Tud30part5a=Tud30atavgpart5
		set Tud31part5a=Tud31atavgpart5
		set Tud32part5a=Tud32atavgpart5
		set Tud33part5a=Tud33atavgpart5
 
		   		set Tud00part6a=Tud00atavgpart6
		set Tud01part6a=Tud01atavgpart6
		set Tud02part6a=Tud02atavgpart6
		set Tud03part6a=Tud03atavgpart6
 
		   		set Tud10part6a=Tud10atavgpart6
		set Tud11part6a=Tud11atavgpart6
		set Tud12part6a=Tud12atavgpart6
		set Tud13part6a=Tud13atavgpart6
 
		   		set Tud20part6a=Tud20atavgpart6
		set Tud21part6a=Tud21atavgpart6
		set Tud22part6a=Tud22atavgpart6
		set Tud23part6a=Tud23atavgpart6
 
		   		set Tud30part6a=Tud30atavgpart6
		set Tud31part6a=Tud31atavgpart6
		set Tud32part6a=Tud32atavgpart6
		set Tud33part6a=Tud33atavgpart6
		#		
		tudpart2whole 0
		tudpart2whole 1
		#
		set lfl=gdet*Tud13
		set efl=gdet*Tud10
		#
		set alfl=gdet*Tud13a
		set aefl=gdet*Tud10a
		#
		#
jrdp 1 #
		jrdp3d $1
		#
jrdp3d	1	#
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
		# 3*3+8+1+4*4+6+1=41
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {ti tj tk x1 x2 x3 r h ph rho u v1 v2 v3 \
		      B1 B2 B3 divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
		      v1m v1p v2m v2p v3m v3p gdet}
	        #
		set tx1=x1
		set tx2=x2
		set tx3=x3
                gsetup
		if($DOGCALC) { gcalc }
		# gcalc
		abscompute
		#
		gammienew
jrdpeos	1	#
		#
                # Must do:
		# gogrmhd
		# jre kazpostmatlab.m
		# gets whichdatatype and numextras
		rdjonheadernew eosextranew.head
                #rdjonheadernew eosnew.head
		#
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
		# 2
		#
                # 
		# MAXPARLIST = 9
		# 1 = 1
		# MAXNUMEXTRAS = 24
		# MAXPROCESSEDEXTRAS = 13
		#
                set readdata=1
                #
                if(whichdatatype!=4){\
                                     echo "jrdpeos assumes whichdatatype==4"
                                     set readdata=0
                                     }
                #
                if(numextras!=24){\
                                     echo "jrdpeos assumes numextras==24"
                                     set readdata=0
                                     }
                #
                if(readdata){\
		 read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {YE YNU0 YNU0OLD YNUOLD Height1 Height2 Height3 Height4 UNU PNU SNU PGAS IG JG KG \
		      temp \
		      qtautnueohcm      qtauanueohcm      qtautnuebarohcm      qtauanuebarohcm      qtautmuohcm      qtauamuohcm      ntautnueohcm      ntauanueohcm      ntautnuebarohcm      ntauanuebarohcm      ntautmuohcm      ntauamuohcm      unue0      unuebar0      unumu0      nnue0      nnuebar0      nnumu0      lambdatot      lambdaintot      tauphotonohcm      tauphotonabsohcm      nnueth0      nnuebarth0 \
                      qphoton qm graddotrhouyl tthermaltot tdifftot rho_nu p_nu s_nu ynulocal Ynuthermal Ynuthermal0 enu enue enuebar \
                    }
                }
	        #
jrdpraddump	1	#
		#
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
		# 44
		#
		 read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    { uru0 uru1 uru2 uru3 urd0 urd1 urd2 urd3 \
              kappa kappaes \
              tautot0 tautot1 tautot2 tautot3 tautotmax \
              prad0ff prad1ff prad2ff prad3ff \
              Gd0 Gd1 Gd2 Gd3 \
              Gdabs0 Gdabs1 Gdabs2 Gdabs3 \
              lambda \
              ErfLTE \
              Tgas Trad Tradff \
              vrmin1 vrmax1 vrmin21 vrmax21 \
              vrmin2 vrmax2 vrmin22 vrmax22 \
              vrmin3 vrmax3 vrmin23 vrmax23 \
            }
	        #            
jrdpvpot 1	#
		#
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
		#
		# 
		read '%g %g %g %g' \
		    { Ad0 Ad1 Ad2 Ad3 }
	        #

 		#
 		#
jrdp3du	1	#
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
                # 52
		set totalcolumns=3*3 + 8 + 3 + 8 + 1 + 4*4+6+1
                if(totalcolumns!=_numcolumns || dimen(nprdumplist)!=8 || dimen(nprlist)!=8){\
                 echo "Wrong format"
                 print {totalcolumns _numcolumns}
                }\
                else{\
                       read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
                       {ti tj tk x1 x2 x3 r h ph \
                        rho u v1 v2 v3 B1 B2 B3 \
                        p cs2 Sden \
                        U0 U1 U2 U3 U4 U5 U6 U7 \
                        divb \
                        uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
                        bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
                        v1m v1p v2m v2p v3m v3p gdet}
                       #
                       set tx1=x1
                       set tx2=x2
                       set tx3=x3
                       gsetup
                       if(_gam<0){\
                                  jrdpeos eos$1
                                 }
                         if($DOGCALC) { gcalc }
                           # gcalc
                           abscompute
                           #
                           gammienew
                           #
                           #
                           print {_is _ie _js _je _ks _ke}
                }
                #
                #
jrdpfailfloordu	1 # reads-in failfloordu???? files with ANY NPR!
		jrdpheader3d dumps/$1
                #
                gsetupfromheader
                #
		da dumps/$1
		lines 2 10000000
		#
		set totalcolumns=dimen(nprlist)
                if(totalcolumns!=_numcolumns){\
                 echo "Wrong format"
                 print {totalcolumns _numcolumns}
                }\
                else{\
                     define numcol (totalcolumns)
                     setupcolstring $numcol
                     #
		     # had to make below submacro or else SM messes up and doesn't create colstring correctly
		     #
		     subfailfloordu
                     #
                }
                #
                #
subfailfloordu 0 #
		echo "Getting dUintgen columns: $!!colstring"
		read {dUintgen $!!colstring}
		#
		# SM sucks, fails to setup colstring
		if(dimen(dUintgen)!=$numcol*$nx*$ny*$nz){
		   read {dUintgen $!!colstring}
		}
		#
		set iii = 0,($numcol*$nx*$ny*$nz-1)
		set indexdu=INT((iii%$($numcol))/1)
		set indexi =INT((iii%($numcol*$nx))/$numcol)
		set indexj =INT((iii%($numcol*$nx*$ny))/($numcol*$nx))
		set indexk =INT((iii%($numcol*$nx*$ny*$nz))/($numcol*$nx*$ny))
		#
		do iii=0,$numcol-1,1 {\
	         set dUint$iii = dUintgen if(indexdu==$iii)
                }  
		#  
		echo "Created $numcol versions of dUint? variables (e.g. dUint0).  Compare this with (e.g.) U0*gdet*dV when performing purely spatial integral."
		#
		#
setupcolstring 1 # setupcolstring $numcol
		define thecol $numcol
		set mystring='1-$thecol'
		define colstring (mystring)
		#
		#
jrdp3duentropy	1	# with NPRDUMP=8 even if doing entropy since entropy primitive not really used
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
                # 53
		set totalcolumns=3*3 + 8+3+9 + 1 + 4*4+6+1
                if(totalcolumns!=_numcolumns || dimen(nprdumplist)!=8 || dimen(nprlist)!=9){\
                 echo "Wrong format"
                 print {totalcolumns _numcolumns}
                }\
                else{\
                     read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
                     {ti tj tk x1 x2 x3 r h ph \
                      rho u v1 v2 v3 B1 B2 B3 \
                      p cs2 Sden \
                      U0 U1 U2 U3 U4 U5 U6 U7 U8 \
		      divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
		      v1m v1p v2m v2p v3m v3p gdet}
                     #
                     set tx1=x1
                     set tx2=x2
                     set tx3=x3
                     gsetup
                     if(_gam<0){\
                                jrdpeos eos$1
                               }
                       if($DOGCALC) { gcalc }
                         # gcalc
                         abscompute
                         #
                         gammienew
                }
 		#
jrdp3duentropyold	1	#
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
		# 3*3 + 9*2 + 3 + 1+4*4+6+1=44
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {ti tj tk x1 x2 x3 r h ph \
		       rho u v1 v2 v3 B1 B2 B3 entropy \
		       p cs2 Sden \
		       U0 U1 U2 U3 U4 U5 U6 U7 U8 \
		      divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
		      v1m v1p v2m v2p v3m v3p gdet}
	        #
		set tx1=x1
		set tx2=x2
		set tx3=x3
                gsetup
		if(_gam<0){\
		       jrdpeos eos$1
		       }
		if($DOGCALC) { gcalc }
		# gcalc
		abscompute
		#
		gammienew
 		#
                #
                #
                #
jrdp3dugrb	1	#
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
		# 57
                totalcolumns=3*3 + 10 + 3 + 11 + 1+4*4+6+1
                # currents give 20 more
                if(totalcolumns!=_numcolumns || dimen(nprdumplist)!=10 || dimen(nprlist)!=11){\
                 echo "Wrong format"
                 print {totalcolumns _numcolumns}
                }\
                else{\
                     read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
                     {ti tj tk x1 x2 x3 r h ph \
                      rho u v1 v2 v3 B1 B2 B3 yl ynu \
                      p cs2 Sden \
                      U0 U1 U2 U3 U4 U5 U6 U7 U8 U9 U10 \
		      divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
		      v1m v1p v2m v2p v3m v3p gdet}
                     #
                     set tx1=x1
                     set tx2=x2
                     set tx3=x3
                     gsetup
                     if(_gam<0){\
                                jrdpeos eos$1
                               }
                       if($DOGCALC) { gcalc }
                         # gcalc
                         abscompute
                         #
                         gammienew
                }
 		#
jrdp3duold	1	#
		jrdpheader3dold dumps/$1
		da dumps/$1
		lines 2 10000000
		#
		# 3*3 + 8*2 + 1+4*4+6+1=41
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {ti tj tk x1 x2 x3 r h ph \
		       rho u v1 v2 v3 B1 B2 B3 \
		       U0 U1 U2 U3 U4 U5 U6 U7 \
		      divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
		      v1m v1p v2m v2p v3m v3p gdet}
	        #
		set tx1=x1
		set tx2=x2
		set tx3=x3
                gsetup
		if($DOGCALC) { gcalc }
		# gcalc
		abscompute
		#
		gammienew
 		#
jrdpother	1	#
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
		# 8+18 = 26
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {rhoa ua v1a v2a v3a B1a B2a B3a \
		    aphicorn aphicent B1cent B1zeus B2face2 B2cent B2zeus omegafcent \
		    rhoface1 uuface1 u1face1 u2face1 u3face1 b1face1 b2face1 b3face1 \
		    vparface1 omegafface1 b1fluxctface1}
	        #
debugjon0     0 #
		#
		#
		jrdp3dudebug dump0001
		jrdpflux fluxdump0001
		#
		plc 0 emf1
		plc 0 (F27/gdet)
		#
		plc 0 emf2
		plc 0 (-F17/gdet)
		#
		plc 0 emf3
		plc 0 (F16/gdet)
		plc 0 (-F25/gdet)
		#
		#
		#
 		#
jrdp3dudebug	1	#
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
		# 3*3 + 8 + 3 + 8 + 1 + 4*4 + 3*2 + 1 = 52
                #
                # + 8*3*2 + 8 + 6*3 + 4*9 = 110
                # pstagrho at 101
                # total=162
                #
                # pbc[edgedir][B1,B2,B3][relevant odir u/d]
                # pvc[edgedir][U1,U2,U3][odir1][odir2]
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {ti tj tk x1 x2 x3 r h ph \
		       rho u v1 v2 v3 B1 B2 B3 \
		       p cs2 Sden \
		       U0 U1 U2 U3 U4 U5 U6 U7 \
		      divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
		      v1m v1p v2m v2p v3m v3p gdet \
                     gpl1rho gpl1u gpl1v1 gpl1v2 gpl1v3 gpl1B1 gpl1B2 gpl1B3 \
                     gpl2rho gpl2u gpl2v1 gpl2v2 gpl2v3 gpl2B1 gpl2B2 gpl2B3 \
                     gpl3rho gpl3u gpl3v1 gpl3v2 gpl3v3 gpl3B1 gpl3B2 gpl3B3 \
                     gpr1rho gpr1u gpr1v1 gpr1v2 gpr1v3 gpr1B1 gpr1B2 gpr1B3 \
                     gpr2rho gpr2u gpr2v1 gpr2v2 gpr2v3 gpr2B1 gpr2B2 gpr2B3 \
                     gpr3rho gpr3u gpr3v1 gpr3v2 gpr3v3 gpr3B1 gpr3B2 gpr3B3 \
                     pstagrho pstagu pstagv1 pstagv2 pstagv3 pstagB1 pstagB2 pstagB3 \
                     pbc11d pbc11u pbc12d pbc12u pbc13d pbc13u \
                     pbc21d pbc21u pbc22d pbc22u pbc23d pbc23u \
                     pbc31d pbc31u pbc32d pbc32u pbc33d pbc33u \
                     pvc11ld pvc11lu pvc11rd pvc11ru \
                     pvc12ld pvc12lu pvc12rd pvc12ru \
                     pvc13ld pvc13lu pvc13rd pvc13ru \
                     pvc21ld pvc21lu pvc21rd pvc21ru \
                     pvc22ld pvc22lu pvc22rd pvc22ru \
                     pvc23ld pvc23lu pvc23rd pvc23ru \
                     pvc31ld pvc31lu pvc31rd pvc31ru \
                     pvc32ld pvc32lu pvc32rd pvc32ru \
                     pvc33ld pvc33lu pvc33rd pvc33ru \
                    }
                    #
		    # EMF is negative gdet of electric field E_i
                    set emf1prim=B3*uu2/uu0 - B2*uu3/uu0
                    set emf2prim=B1*uu3/uu0 - B3*uu1/uu0
                    set emf3prim=B2*uu1/uu0 - B1*uu2/uu0
                    #
                    set emf1other=gpl1B3*uu2/uu0 - gpl1B2*uu3/uu0
                    set emf2other=gpl1B1*uu3/uu0 - gpl1B3*uu1/uu0
                    set emf3other=gpl1B2*uu1/uu0 - gpl1B1*uu2/uu0
                    #
                    set emf1=pbc13d*pvc12ld-pbc12d*pvc13ld
                    set emf2=pbc21d*pvc23ld-pbc23d*pvc21ld
                    set emf3=pbc32d*pvc31ld-pbc31d*pvc32ld
                    #
	        #
		set tx1=x1
		set tx2=x2
		set tx3=x3
                gsetup
		if(_gam<0){\
		       jrdpeos eos$1
		       }
		if($DOGCALC) { gcalc }
		# gcalc
		abscompute
		#
		gammienew
 		#
jrdpflux	1	# for fluxdump in harm
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
		# NPR*4 + NPR*3*(1+2+2) = 32 + 120 = 152 
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {\
		       dUg0 dUg1 dUg2 dUg3 dUg4 dUg5 dUg6 dUg7 \
		       dUr10 dUr11 dUr12 dUr13 dUr14 dUr15 dUr16 dUr17 \
		       dUr20 dUr21 dUr22 dUr23 dUr24 dUr25 dUr26 dUr27 \
		       dUr30 dUr31 dUr32 dUr33 dUr34 dUr35 dUr36 dUr37 \
		       F10 F11 F12 F13 F14 F15 F16 F17 \
		       F1l0 F1l1 F1l2 F1l3 F1l4 F1l5 F1l6 F1l7 \
		       F1r0 F1r1 F1r2 F1r3 F1r4 F1r5 F1r6 F1r7 \
		       p1l0 p1l1 p1l2 p1l3 p1l4 p1l5 p1l6 p1l7 \
		       p1r0 p1r1 p1r2 p1r3 p1r4 p1r5 p1r6 p1r7 \
		       F20 F21 F22 F23 F24 F25 F26 F27 \
		       F2l0 F2l1 F2l2 F2l3 F2l4 F2l5 F2l6 F2l7 \
		       F2r0 F2r1 F2r2 F2r3 F2r4 F2r5 F2r6 F2r7 \
		       p2l0 p2l1 p2l2 p2l3 p2l4 p2l5 p2l6 p2l7 \
		       p2r0 p2r1 p2r2 p2r3 p2r4 p2r5 p2r6 p2r7 \
		       F30 F31 F32 F33 F34 F35 F36 F37 \
		       F3l0 F3l1 F3l2 F3l3 F3l4 F3l5 F3l6 F3l7 \
		       F3r0 F3r1 F3r2 F3r3 F3r4 F3r5 F3r6 F3r7 \
		       p3l0 p3l1 p3l2 p3l3 p3l4 p3l5 p3l6 p3l7 \
		       p3r0 p3r1 p3r2 p3r3 p3r4 p3r5 p3r6 p3r7 \
		    }
	        #
jrdpfluxfull	1	# for fluxdump in harm when using jrdpcf3duentropy
		jrdpheader3d dumps/$1
		da dumps/$1
		lines 2 10000000
		#
                # NPR=9
		# NPR*4 + NPR*3*(1+2+2) = 171
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {\
		       dUg0 dUg1 dUg2 dUg3 dUg4 dUg5 dUg6 dUg7 dUg8\
		       dUr10 dUr11 dUr12 dUr13 dUr14 dUr15 dUr16 dUr17 dUr18 \
		       dUr20 dUr21 dUr22 dUr23 dUr24 dUr25 dUr26 dUr27 dUr28 \
		       dUr30 dUr31 dUr32 dUr33 dUr34 dUr35 dUr36 dUr37 dUr38 \
		       F10 F11 F12 F13 F14 F15 F16 F17 F18 \
		       F1l0 F1l1 F1l2 F1l3 F1l4 F1l5 F1l6 F1l7 F1l8 \
		       F1r0 F1r1 F1r2 F1r3 F1r4 F1r5 F1r6 F1r7 F1r8 \
		       p1l0 p1l1 p1l2 p1l3 p1l4 p1l5 p1l6 p1l7 p1l8 \
		       p1r0 p1r1 p1r2 p1r3 p1r4 p1r5 p1r6 p1r7 p1r8 \
		       F20 F21 F22 F23 F24 F25 F26 F27 F28 \
		       F2l0 F2l1 F2l2 F2l3 F2l4 F2l5 F2l6 F2l7 F2l8 \
		       F2r0 F2r1 F2r2 F2r3 F2r4 F2r5 F2r6 F2r7 F2r8 \
		       p2l0 p2l1 p2l2 p2l3 p2l4 p2l5 p2l6 p2l7 p2l8 \
		       p2r0 p2r1 p2r2 p2r3 p2r4 p2r5 p2r6 p2r7 p2r8 \
		       F30 F31 F32 F33 F34 F35 F36 F37 F38 \
		       F3l0 F3l1 F3l2 F3l3 F3l4 F3l5 F3l6 F3l7 F3l8 \
		       F3r0 F3r1 F3r2 F3r3 F3r4 F3r5 F3r6 F3r7 F3r8 \
		       p3l0 p3l1 p3l2 p3l3 p3l4 p3l5 p3l6 p3l7 p3l8 \
		       p3r0 p3r1 p3r2 p3r3 p3r4 p3r5 p3r6 p3r7 p3r8 \
		    }
	        #
 		#
jrdp2d	1	#
		jrdpheader2d $1
		da dumps/$1
		lines 2 10000000
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {ti tj x1 x2 r h rho u v1 v2 v3 \
		      B1 B2 B3 divb \
		      uu0 uu1 uu2 uu3 ud0 ud1 ud2 ud3 \
		      bu0 bu1 bu2 bu3 bd0 bd1 bd2 bd3 \
		      v1m v1p v2m v2p gdet}
	        #
		set tx1=x1
		set tx2=x2
                gsetup
		if($DOGCALC) { gcalc }
		# gcalc
		abscompute
		#
		gammienew2d
 		#
jrdpheader 1    #
		jrdpheader3d dumps/$1
		#
		#
jrdpunits 0  #
		da 0_units.dat
		lines 1 1
                read '%d' {rho0unitstype}
                lines 2 2
		read '%g %g %g' {Munit Lunit Tunit}
		lines 3 3
		read '%g %g %g %g' {Mfactor Jfactor Mcgs rhodisk}
		lines 4 4
		read '%g %g %g %g %g %g %g %g' {rhounit rhomassunit Vunit mdotunit energyunit Pressureunit Tempunit Bunit}
		    #
		    #
		    #
jrdpheader3do 1  # assume directory put in name
		#da dumps/$1
		da $1
		lines 1 1
                # 30
		read '%g %d %d %d %g %g %g %g %g %g %d %g %g %g %g %g %g %g %d %g %g %d %d %d %d %d %d %d %d %d' \
		    {_t _n1 _n2 _n3 _startx1 _startx2 _startx3 _dx1 _dx2 _dx3 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord _MBH _QBH _is _ie _js _je _ks _ke _whichdump _whichdumpversion _numcolumns}
		    #
                    # also read-in nprlist data
                    jrdpnprlist
		    #
                    gsetupfromheader
                    gcalcheader
		    #
jrdpheader3dsasha 1  # assume directory put in name
                jrdpheader3do2 $1
jrdpheader3do2 1  # assume directory put in name
		#da dumps/$1
		da $1
		lines 1 1
                # 31
		read '%g %d %d %d %g %g %g %g %g %g %d %g %g %g %g %g %g %g %d %g %g %g %d %d %d %d %d %d %d %d %d' \
		    {_t _n1 _n2 _n3 _startx1 _startx2 _startx3 _dx1 _dx2 _dx3 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord _MBH _QBH _EP3 _is _ie _js _je _ks _ke _whichdump _whichdumpversion _numcolumns}
		    #
                    # also read-in nprlist data
                    jrdpnprlist
		    #
                    gsetupfromheader
                    gcalcheader
		    #
jrdpheader3d 1  # assume directory put in name
		#da dumps/$1
		da $1
		lines 1 1
                # 32
		read '%g %d %d %d %g %g %g %g %g %g %d %g %g %g %g %g %g %g %d %g %g %g %g %d %d %d %d %d %d %d %d %d' \
		    {_t _n1 _n2 _n3 _startx1 _startx2 _startx3 _dx1 _dx2 _dx3 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord _MBH _QBH _EP3 _THETAROT _is _ie _js _je _ks _ke _whichdump _whichdumpversion _numcolumns}
		    #
                    # also read-in nprlist data
                    jrdpnprlist
		    #
                    gsetupfromheader
                    gcalcheader
		    #
jrdpnprlist  0      #
                    da nprlistinfo.dat
                    lines 1 1
                    read '%d %d' {_nprlistlines _nprlistversion}
                    read row nprlist 2
                    read row npr2interplist 3
                    read row npr2notinterplist 4
                    read row nprboundlist 5
                    read row nprfluxboundlist 6
                    read row nprdumplist 7
                    read row nprinvertlist 8
                    #
                    #
jrdpheader3dold 1  #
		#da dumps/$1
		da $1
		lines 1 1
		read '%g %d %d %d %g %g %g %g %g %g %d %g %g %g %g %g %g %g %d' \
		    {_t _n1 _n2 _n3 _startx1 _startx2 _startx3 _dx1 _dx2 _dx3 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord}
		    #
		    #
                    gsetupfromheader
                    gcalcheader
		    #
jrdpheader2d 1    #
		da dumps/$1
		lines 1 1
		set _dt=-1
		read '%g %d %d %g %g %g %g %d %g %g %g %g %g %g %g %g' \
		    {_t _n1 _n2 _startx1 _startx2 _dx1 _dx2 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord}
		    if(_dt==-1) {\
		           set _hslope=-1
		           read '%g %d %d %g %g %g %g %d %g %g %g %g %g %g' \
		               {_t _n1 _n2 _startx1 _startx2 _dx1 _dx2 _realnstep _gam _a _R0 _Rin _Rout _hslope}
		               if(_hslope==-1)	{\
		                      read '%g %d %d %g %g %g %g' \
		                   {_t _n1 _n2 _startx1 _startx2 _dx1 _dx2 }
		                   da dumps/dumphead2
		                   lines 1 1
		                   read '%g %g %g %g %g %g' \
		                       {_gam _a _R0 _Rin _Rout _hslope}
		                       set _realnstep=0 # some didn't have this, some did
		               }
		    }
		    #
		    if(_hslope==-1) { echo "error with hslope $myhostname $mydirname" }
		    #
                    gsetupfromheader
                    gcalcheader
		    #
jrdp1col 2	#
		echo "jrdp1col"
		jrdpheader $1
		#
		da dumps/$1
		lines 2 10000000
		#
		read '%g' {temptemp}
		#
		set $2=temptemp
	        #
jrdp1ci    2  #
		echo "jrdp1ci"
		#
		#
		jrdpheader2d $1
		da $idumpsdir/$1
		lines 2 10000000
                #
                read '%g' {temptemp}
                #
                set $2=temptemp
                #
                gsetup
                define coord (1)
                define nx (_n1)
                define ny (_n2)
                echo $nx $ny
                define dx (_dx1)
                define dy (_dx2)
                set iii=0,$nx*$ny-1,1
                set ti=INT(iii%$nx)
                set tj=INT(iii/$nx)
                set j=tj
                set i=ti
                set k=iii/($nx*$ny)
                set x1=_startx1+_dx1*ti
                set x2=_startx2+_dx2*tj
                set x12=_startx1+_dx1*(ti+0.5)
                set x22=_startx2+_dx2*(tj+0.5)
                set r=x1
                set h=x2
                set tx1=x1
                set tx2=x2
                define nz (1)
                set k=1,$nx*$ny,1
                set k=k*0
		set gdet=gdet*0+1.0
                define interp (0)
                define Sx (x1[0])
                define Sy (x2[0])
		# x1[dimen(x1)-1] is not outer edge of box!
		#define Lx (x1[dimen(x1)-1]-x1[0])
                #define Ly (x2[dimen(x2)-1]-x2[0])
                #
		define Lx ($dx*$nx)
                define Ly ($dy*$ny)
                #
jrdp3d1ci    2  #
		echo "jrdp3d1ci"
		#
		#
		jrdpheader3d $idumpsdir/$1
		da $idumpsdir/$1
		lines 2 10000000
                #
                read '%g' {temptemp}
                #
                set $2=temptemp
                #
                gsetup
                define coord (1)
                define nx (_n1)
                define ny (_n2)
                define nz (_n3)
                echo $nx $ny $nz
                define dx (_dx1)
                define dy (_dx2)
                define dz (_dx3)
                set iii=0,$nx*$ny*$nz-1,1
                set ti=INT(iii%$nx)
                set tj=INT(iii/$nx)
                set tk=INT(iii/($nx*$ny))
                set i=ti
                set j=tj
		set k=tk
		#set k=iii/($nx*$ny)
                set x1=_startx1+_dx1*ti
                set x2=_startx2+_dx2*tj
		set x3=_startx3+_dx3*tk
                set x12=_startx1+_dx1*(ti+0.5)
                set x22=_startx2+_dx2*(tj+0.5)
                set x32=_startx3+_dx3*(tk+0.5)
                set r=x1
                set h=x2
                set p=x3
                set tx1=x1
                set tx2=x2
                set tx3=x3
		set gdet=gdet*0+1.0
                define interp (0)
                define Sx (x1[0])
                define Sy (x2[0])
                define Sz (x3[0])
		# x1[dimen(x1)-1] is not outer edge of box!
		#define Lx (x1[dimen(x1)-1]-x1[0])
                #define Ly (x2[dimen(x2)-1]-x2[0])
                #
		define Lx ($dx*$nx)
                define Ly ($dy*$ny)
                define Lz ($dz*$nz)
                #
jrdp1ci2    2  # special version of reading interpolation (see fieldcalci)
		echo "jrdp1ci2"
		#
		set _defcoord=-1
		set _hslope=-1
		da dumps/$1
                lines 1 1
                read '%g %d %d %g %g %g %g %d %g %g %g %g %g %g %g %d' \
                    {_t _n1 _n2 _startx1 _startx2 _dx1 _dx2 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord}
                if(_hslope==-1) {\
                 read '%g %d %d %g %g %g %g' \
                        {_t _n1 _n2 _startx1 _startx2 _dx1 _dx2 }
                        set _realnstep=0
                        set _gam=4.0/3.0
                        set _a=0.5
                        set _R0=0
                        set _Rin=1.96
                        set _Rout=80
                        set _hslope=0.2
                     }
                lines 2 100000000
                #
                read '%g' {temptemp}
                #
                set $2=temptemp
                #
                gsetup
                define nx (_n1)
                define ny (_n2)
                echo $nx $ny
                define dx (_dx1)
                define dy (_dx2)
                set iii=0,$nx*$ny-1,1
                set ti=INT(iii%$nx)
                set tj=INT(iii/$nx)
                set j=tj
                set i=ti
                set k=iii/($nx*$ny)
                set x1=_startx1+_dx1*ti
                set x2=_startx2+_dx2*tj
                set x12=x1
                set x22=x2
                set r=x1
                set h=x2
                set tx1=x1
                set tx2=x2
                define nz (1)
                set k=1,$nx*$ny,1
                set k=k*0
                #
		#
jrdpdebug 1 #
		jrdpdebug3d $1
		#
jrdpdebug2d   1   #
		jrdpheader2d $1
		jrdpdebuggen $1
		#
jrdpdebug3d   1   #
		jrdpheader3d dumps/$1
		jrdpdebuggen $1
		#
jrdpdebuggen 1  #
		#
		da dumps/$1
		lines 2 10000000
		#
                # 2 sections correspond to (1) (e.g. fail0) original full counter (2) (e.g. fsfail0)
                #
                # rows shown below in formatted way are TSCALE:
		# ALLTS 0
		# ENERTS 1
		# IMAGETS 2
		# DEBUGTS 3
                #
   #
                # columns are as in global.nondepnmemonics.h:
                #define COUNTUTOPRIMFAILCONV 0 // if failed to converge
                #define COUNTFLOORACT 1 // if floor activated
                #define COUNTLIMITGAMMAACT 2 // if Gamma limiter activated
                #define COUNTINFLOWACT 3 // if inflow check activated
                #define COUNTUTOPRIMFAILRHONEG 4
                #define COUNTUTOPRIMFAILUNEG 5
                #define COUNTUTOPRIMFAILRHOUNEG 6
                #define COUNTGAMMAPERC 7 // see fixup_checksolution()
                #define COUNTUPERC 8 // see fixup_checksolution()
                #define COUNTENTROPY 9
                #define COUNTCOLD 10
                #define COUNTEOSLOOKUPFAIL 11
                #define COUNTBOUND1 12 // see bounds.tools.c (used when boundary code actually affects active zone values)
                #define COUNTBOUND2 13
                #define COUNTONESTEP 14
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {\
                    nmfail0 nmfloor0 nmlimitgamma0 nminflow0 nmfailrho0 nmfailu0 nmfailrhou0 nmprecgam0 nmprecu0 nmtoentropy0 nmtocold0 nmeosfail0 nmcb10 nmcb20 nmcos0 \
		    nmfail1 nmfloor1 nmlimitgamma1 nminflow1 nmfailrho1 nmfailu1 nmfailrhou1 nmprecgam1 nmprecu1 nmtoentropy1 nmtocold1 nmeosfail1 nmcb11 nmcb21 nmcos1 \
		    nmfail2 nmfloor2 nmlimitgamma2 nminflow2 nmfailrho2 nmfailu2 nmfailrhou2 nmprecgam2 nmprecu2 nmtoentropy2 nmtocold2 nmeosfail2 nmcb12 nmcb22 nmcos2 \
		    nmfail3 nmfloor3 nmlimitgamma3 nminflow3 nmfailrho3 nmfailu3 nmfailrhou3 nmprecgam3 nmprecu3 nmtoentropy3 nmtocold3 nmeosfail3 nmcb13 nmcb23 nmcos3 \
                    fsfail0 fsfloor0 fslimitgamma0 fsinflow0 fsfailrho0 fsfailu0 fsfailrhou0 fsprecgam0 fsprecu0 fstoentropy0 fstocold0 fseosfail0 fscb10 fscb20 fscos0 \
		    fsfail1 fsfloor1 fslimitgamma1 fsinflow1 fsfailrho1 fsfailu1 fsfailrhou1 fsprecgam1 fsprecu1 fstoentropy1 fstocold1 fseosfail1 fscb11 fscb21 fscos1 \
		    fsfail2 fsfloor2 fslimitgamma2 fsinflow2 fsfailrho2 fsfailu2 fsfailrhou2 fsprecgam2 fsprecu2 fstoentropy2 fstocold2 fseosfail2 fscb12 fscb22 fscos2 \
		    fsfail3 fsfloor3 fslimitgamma3 fsinflow3 fsfailrho3 fsfailu3 fsfailrhou3 fsprecgam3 fsprecu3 fstoentropy3 fstocold3 fseosfail3 fscb13 fscb23 fscos3 \
                    }
		#
		#
                echo "Begin debug computations"
                debuggencompute 1
                debuggencompute 2
                echo "End debug computations"
                #
                #
debuggencompute 1 #                
                #
                #
                if($1==1){\
                          set it='nm'
                          }
                #
                if($1==2){\
                          set it='fs'
                          }
                #
                # set it='fs'
                #set it=$1
                #
                define fsit (it)
                #
		# shows where *ever* failed or not
		set lg1"$!!fsit"fail=lg("$!!fsit"fail0+1)
		set lg1"$!!fsit"tot=lg("$!!fsit"fail0+"$!!fsit"failrho0+"$!!fsit"failu0+"$!!fsit"failrhou0+1)
		#
		set lg1"$!!fsit"precgam=lg("$!!fsit"precgam0+1)
		set lg1"$!!fsit"precu=lg("$!!fsit"precu0+1)
		#
		set "$!!fsit"failtot0="$!!fsit"fail0 + "$!!fsit"failrho0 + "$!!fsit"failu0 + "$!!fsit"failrhou0
		set "$!!fsit"failtot1="$!!fsit"fail1 + "$!!fsit"failrho1 + "$!!fsit"failu1 + "$!!fsit"failrhou1
		set "$!!fsit"failtot2="$!!fsit"fail2 + "$!!fsit"failrho2 + "$!!fsit"failu2 + "$!!fsit"failrhou2
		set "$!!fsit"failtot3="$!!fsit"fail3 + "$!!fsit"failrho3 + "$!!fsit"failu3 + "$!!fsit"failrhou3
		#
		set lg"$!!fsit"ftot0=lg("$!!fsit"failtot0+1)
		set lg"$!!fsit"ftot1=lg("$!!fsit"failtot1+1)
		set lg"$!!fsit"ftot2=lg("$!!fsit"failtot2+1)
		set lg"$!!fsit"ftot3=lg("$!!fsit"failtot3+1)
		#
		set "$!!fsit"failtot0sum=SUM("$!!fsit"failtot0)
		set "$!!fsit"failtot1sum=SUM("$!!fsit"failtot1)
		set "$!!fsit"failtot2sum=SUM("$!!fsit"failtot2)
		set "$!!fsit"failtot3sum=SUM("$!!fsit"failtot3)
		#
                # print didn't like direct use of "$!!fsit"var
                set toprint1="$!!fsit"failtot0sum
                set toprint2="$!!fsit"failtot1sum
                set toprint3="$!!fsit"failtot2sum
                set toprint4="$!!fsit"failtot3sum
                echo "toprint? is failtot?sum"
		print {toprint1 toprint2 toprint3 toprint4}
		#
		# absolute totals
		set "$!!fsit"dtot0="$!!fsit"fail0+"$!!fsit"floor0+"$!!fsit"limitgamma0+"$!!fsit"failrho0+"$!!fsit"failu0+"$!!fsit"failrhou0+"$!!fsit"precgam0+"$!!fsit"precu0
		set "$!!fsit"dtot1="$!!fsit"fail1+"$!!fsit"floor1+"$!!fsit"limitgamma1+"$!!fsit"failrho1+"$!!fsit"failu1+"$!!fsit"failrhou1+"$!!fsit"precgam1+"$!!fsit"precu1
		set "$!!fsit"dtot2="$!!fsit"fail2+"$!!fsit"floor2+"$!!fsit"limitgamma2+"$!!fsit"failrho2+"$!!fsit"failu2+"$!!fsit"failrhou2+"$!!fsit"precgam2+"$!!fsit"precu2
		set "$!!fsit"dtot3="$!!fsit"fail3+"$!!fsit"floor3+"$!!fsit"limitgamma3+"$!!fsit"failrho3+"$!!fsit"failu3+"$!!fsit"failrhou3+"$!!fsit"precgam3+"$!!fsit"precu3
		#
		set lg"$!!fsit"dtot0=lg("$!!fsit"dtot0+1)
		set lg"$!!fsit"dtot1=lg("$!!fsit"dtot1+1)
		set lg"$!!fsit"dtot2=lg("$!!fsit"dtot2+1)
		set lg"$!!fsit"dtot3=lg("$!!fsit"dtot3+1)
		#
		set "$!!fsit"dtot0sum=SUM("$!!fsit"dtot0)
		set "$!!fsit"dtot1sum=SUM("$!!fsit"dtot1)
		set "$!!fsit"dtot2sum=SUM("$!!fsit"dtot2)
		set "$!!fsit"dtot3sum=SUM("$!!fsit"dtot3)
		#
		set toprint1="$!!fsit"dtot0sum
                set toprint2="$!!fsit"dtot1sum
                set toprint3="$!!fsit"dtot2sum
                set toprint4="$!!fsit"dtot3sum
                #
                echo "toprint? is dtot?sum"
                #
		print {toprint1 toprint2 toprint3 toprint4}
		#
		#
jrdpdebugold3   1   #
		jrdpheader $1
		da dumps/$1
		lines 2 10000000
		#
		#
		# ALLTS 0
		# ENERTS 1
		# IMAGETS 2
		# DEBUGTS 3
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {fail0 floor0 limitgamma0 inflow0 failrho0 failu0 failrhou0 \
		       fail1 floor1 limitgamma1 inflow1 failrho1 failu1 failrhou1 \
		    fail2 floor2 limitgamma2 inflow2 failrho2 failu2 failrhou2 \
		    fail3 floor3 limitgamma3 inflow3 failrho3 failu3 failrhou3 }
		#
		# shows where *ever* failed or not
		set lg1fail=lg(fail0+1)
		set lg1tot=lg(fail0+failrho0+failu0+failrhou0+1)
		#
jrdpdebugold2   1   #
		jrdpheader $1
		da dumps/$1
		lines 2 10000000
		#
		#
		# ALLTS 0
		# ENERTS 1
		# IMAGETS 2
		# DEBUGTS 3
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {fail0 floor0 limitgamma0 inflow0 \
		       fail1 floor1 limitgamma1 inflow1 \
		    fail2 floor2 limitgamma2 inflow2 \
		    fail3 floor3 limitgamma3 inflow3 }
		#
		# shows where *ever* failed or not
		set lg1fail=lg(fail0+1)
		#
jrdpdebugold1   1   #
		jrdpheader $1
		da dumps/$1
		lines 2 10000000
		read {fail 1 flooract 2 limitgammaact 3 inflowact 4}
		#
		# shows where *ever* failed or not
		set lgfail=lg(fail)
		set lgflooract=lg(flooract)
		set lglimitgammaact=lg(limitgammaact)
		set lginflowactact=lg(inflowact)
		#
		# shows number of counts if count>0 in log
		set lg1fail=lg(fail+1)
		set lg1flooract=lg(flooract+1)
		set lg1limitgammaact=lg(limitgammaact+1)
		set lg1inflowactact=lg(inflowact+1)
		#
jrdpdebugold0   1   #
		da dumps/$1
		lines 1 10000000
		read {fail 1 flooract 2 limitgammaact 3 inflowact 4}
		#
		# shows where *ever* failed or not
		set lgfail=lg(fail)
		set lgflooract=lg(flooract)
		set lglimitgammaact=lg(limitgammaact)
		set lginflowactact=lg(inflowact)
		#
		# shows number of counts if count>0 in log
		set lg1fail=lg(fail+1)
		set lg1flooract=lg(flooract+1)
		set lg1limitgammaact=lg(limitgammaact+1)
		set lg1inflowactact=lg(inflowact+1)
		#
rdrdump         1
		da dumps/$1
		lines 1 1
		# read header
		lines 2 10000000
		read {rho2 1 u2 2 u2r 3 u2h 4 u2p 5 b2r 6 b2h 7 b2p 8}
		#
gsetupfromheader  0 # grid stuff only from jrdp3dheader contents
                #
                # for jon
		set _mag=1
		define nx (_n1)
		define ny (_n2)
		define nz (_n3)
		#
		define n1 (_n1)
		define n2 (_n2)
		define n3 (_n3)
		define startx1 (_startx1)
		define startx2 (_startx2)
		define startx3 (_startx3)
		define dx1 (_dx1)
		define dx2 (_dx2)
		define dx3 (_dx3)
		define stopx1 ($startx1 + $n1*$dx1)
		define stopx2 ($startx2 + $n2*$dx2)
		define stopx3 ($startx3 + $n3*$dx3)
                #
		# auxiliary info.
		set a=_a
                set R0=_R0
                set Rin=_Rin
                set Rout=_Rout
		set hslope=_hslope
		#
gsetupgrid    0 # grid stuff
		# makes assumption about grid
		set ii=0,_n1*_n2-1,1
                set dr=$dx1*exp(tx1)
                set dh=pi*$dx2*(1+(1-hslope)*cos(2*pi*tx2))
		set dp=2.0*pi*$dx3
                #
gsetup  0       #
		gsetupfromheader
		gsetupgrid
		#
gcalc           0 # physics stuff
		#
		gcalcbasic
		gcalcmore
		#
gcalcbasic      0 # physics stuff
		#
		# for below, otherwise assume read-in pressure is correct
		# used to keep changes minimal with new jrdp3du reading of pressure
		#
		if(_gam>0){\
		  define gam (_gam)
		  echo "assuming gam = " $gam
		  set p = ($gam - 1.)*u
		  set WW = rho + u + p
		  #
		  set cs2 = $gam*p/WW
		  set K = p*rho**(-$gam)
		}
		#
		if(_gam<0){\
		       # $gam should never be used
		       #define gam (_gam)
		  echo "Using file-defined EOS values"
		  # below probably not right
		  set K = Sden
		}
		#
gcalcheader 0   #                
		#set _rhor = 1+sqrt(1-a**2)
		set _rhor = _MBH + sqrt(_MBH**2 - _a**2)
		define rhor (_rhor)
		#
		if(a>=0.0){\
		 riscocalc 0 risco # assumes stuff always goes positive
		 riscocalc 1 risco2 # assumes stuff always goes positive
		}
		if(a<0.0){\
		 riscocalc 1 risco # assumes stuff always goes positive
		 riscocalc 0 risco2 # assumes stuff always goes positive
		}
		riscocalc 0 riscoprograde
		riscocalc 1 riscoretrograde
		elinfcalc risco tdeinfisco tdlinfisco
		#
		#
gcalcmore       0     #              
		set omega3=uu3/uu0
		set omegak=1/(r**(3/2)+a)
		set omega3ok=omega3/omegak
		set einf=-ud0
		set linf=ud3
		set delta=r**2-2*r+a**2
		set omegas=(a*sin(h)-sqrt(delta))/((r**2+a**2)*sin(h)-sqrt(delta)*a*sin(h)**2)
		#
		set bsq = bu0*bd0 + bu1*bd1 + bu2*bd2 + bu3*bd3
		set bsq0 = bu0*bd0
		set bsq1 = bu1*bd1
		set bsq2 = bu2*bd2
		set bsq3 = bu3*bd3
		set ptot = p + 0.5*bsq
		#
		set WW = rho + u + p
		set EF = bsq + WW
		set val2 = bsq/EF
		set cms2 = cs2 + val2 - cs2*val2
		#
		#
		#
		# the below is only correct for defcoord==0 and KSCOORDS
		#set dxdxp1=(r-R0)
        set dxdxp1=dxdxp11
		#set dxdxp2=pi+(1-hslope)*pi*cos(2*pi*tx2)
        set dxdxp2=dxdxp22
		set ksuu1=uu1*dxdxp11
		set ksbu1=bu1*dxdxp11
		set ksuu2=uu2*dxdxp22
		set ksbu2=bu2*dxdxp22
		# only for KS/KSP (given KS, computes in KS and returns in KSP)
		#
                #
                #(((u+p)*uu0*ud0+p)/(Tud10+rho*uu0))
                #
                #
		# generally true ...
		set cs=sqrt(cs2)
		set va=sqrt(val2)
		set up=sqrt(gv311*uu1**2+2*gv312*uu1*uu2+gv322*uu2**2)
		set Machcs=up/cs
		set Machvacs=up/sqrt(cms2)
		set Machva=up/va
		#
		fastvp
		sonicvp
		alfvenvp
		#
		#
		set lbsq = lg(bsq + 1.e-20)
		set lrho = lg(rho)
		set lu = lg(u)
		set lv2 = lg(abs(v2) + 1.e-20)
		set ldivb = lg(abs(divb) + 1.e-20)
		set ibeta = 0.5*bsq/p
        set ibetatot = (0.5*bsq/(($gam-1)*u+prad0ff))
		set libeta = lg(abs(ibeta) + 1.e-20)
		#
		set brel = 0.5*bsq/rho
		set lbrel = lg(abs(brel)+1.e-20)
		#
		set rv1 = r*v1
		# mass, energy, and L-fluxes
		# area and dV have NO gdets
		set area=$dx2*$dx3
		set dV=$dx1*$dx2*$dx3
                # mass flux
		mass_flux mfl 1
		set mflux=mfl*area # not to integrate over, just sum
		set mflux1=mflux if(ti==0)
		set mflux1=SUM(mflux1)
		set mflux0=mflux if(ti==$nx-1)
		set mflux0=SUM(mflux0)
		# energy flux (em and ma)
		set eflem1 = ( bsq*uu1*ud0  )
		set eflem2 = ( - bu1*bd0 )
                set eflem  = eflem1+eflem2
		set eflma = ( (rho+p+u)*uu1*ud0 )
		set efl0=eflem+eflma
		set efl=efl0*gdet
		set eflux=efl*area
		set eflux1=eflux if(ti==0)
		set eflux1=SUM(eflux1)
		# angular momentum flux (em and ma)
		set lflem = ( bsq*uu1*ud3 - bu1*bd3 )
		set lflma = ( (rho+p+u)*uu1*ud3 )
		set lfl0=lflem+lflma
		set lfl=lfl0*gdet
		set lflux=lfl*area
		set lflux1=lflux if(ti==0)
		set lflux1=SUM(lflux1)
		#
		# fluxes, including conserved quantities
		do ii=0,3 {
		 set flux0$ii=rho*uu$ii
		 mhd_calc flux1$ii 0 $ii
		 set flux1$ii=flux1$ii+flux0$ii
		 mhd_calc flux2$ii 1 $ii
		 mhd_calc flux3$ii 2 $ii
		 mhd_calc flux4$ii 3 $ii
		 dualb flux5$ii 1 $ii
		 dualb flux6$ii 2 $ii
		 dualb flux7$ii 3 $ii
		}
		#
		set efl2=-(omega3*lfl+(einf-linf*omega3)*mfl)
		set girat=efl/efl2
abscompute   0  #
		# absolute value calcs (so can read in or compute)
		set rhoa=ABS(rho)
		set ua=ABS(u)
		#
		set va1=ABS(v1)
		set va2=ABS(v2)
		set va3=ABS(v3)
		#
		set Ba1=ABS(B1)
		set Ba2=ABS(B2)
		set Ba3=ABS(B3)
		set divba=ABS(divb)
		#
		set uua0=ABS(uu0)
		set uua1=ABS(uu1)
		set uua2=ABS(uu2)
		set uua3=ABS(uu3)
		set uda0=ABS(ud0)
		set uda1=ABS(ud1)
		set uda2=ABS(ud2)
		set uda3=ABS(ud3)
		#
		set bua0=ABS(bu0)
		set bua1=ABS(bu1)
		set bua2=ABS(bu2)
		set bua3=ABS(bu3)
		set bda0=ABS(bd0)
		set bda1=ABS(bd1)
		set bda2=ABS(bd2)
		set bda3=ABS(bd3)
		#
		set vma1=ABS(v1m)
		set vpa1=ABS(v1p)
		set vma2=ABS(v2m)
		set vpa2=ABS(v2p)
		#
		set jua0=ABS(ju0)
		set jua1=ABS(ju1)
		set jua2=ABS(ju2)
		set jua3=ABS(ju3)
		#
		set jda0=ABS(jd0)
		set jda1=ABS(jd1)
		set jda2=ABS(jd2)
		set jda3=ABS(jd3)
		#
		set fua0=ABS(fu0)
		set fua1=ABS(fu1)
		set fua2=ABS(fu2)
		set fua3=ABS(fu3)
		set fua4=ABS(fu4)
		set fua5=ABS(fu5)
		#
		set afuu01=fua0
		set afuu02=fua1
		set afuu03=fua2
		set afuu12=fua3
		set afuu13=fua4
		set afuu23=fua5
		#
		set fda0=ABS(fd0)
		set fda1=ABS(fd1)
		set fda2=ABS(fd2)
		set fda3=ABS(fd3)
		set fda4=ABS(fd4)
		set fda5=ABS(fd5)
		#
		set afdd01=fda0
		set afdd02=fda1
		set afdd03=fda2
		set afdd12=fda3
		set afdd13=fda4
		set afdd23=fda5
		#
		#
crossfield1      0
		# setlimits $rhor (1.01*$rhor) 0 pi 0 1 plflim 0 x2 r h ptot 0
		# setlimits 25 25.05 0 pi 0 1 plflim 0 x2 r h Tud22 0
		# 
		set t0=gdet*Tud20
		set t1=gdet*Tud21
		set t2=gdet*Tud22
		set t3=gdet*Tud23
		#
		define myti (0)
		set newx2=x2 if(ti==$myti)
		set newh=h if(ti==$myti)
		#
		set newt0=t0 if(ti==$myti)
		set newt1=t1 if(ti==$myti)
		set newt2=t2 if(ti==$myti)
		set newt3=t3 if(ti==$myti)
		#
		der newx2 newt0 dnewx2 dt0
		der newx2 newt1 dnewx2 dt1
		der newx2 newt2 dnewx2 dt2
		der newx2 newt3 dnewx2 dt3
		#
		ctype default ltype 0
		erase
		limits 0 3.14 -100 100
		box
		ctype default ltype 0 plo 0 newh dt0
		ctype red ltype 0 plo 0 newh dt1
		ctype blue ltype 0 plo 0 newh dt2
		ctype green ltype 0 plo 0 newh dt3
		#
stresscalc      1
		#
		#
		if(($1==0)||($1==1)){\
		# Tud 
		do ii=0,3 {
		 Tcalcud Tud0$ii 0 $ii
		 Tcalcud Tud1$ii 1 $ii
		 Tcalcud Tud2$ii 2 $ii
		 Tcalcud Tud3$ii 3 $ii
		}
		}
		#    
		#       
		if(($1==0)||($1==2)){\
		# Tuu
		do ii=0,3 {
		 Tcalcuu Tuu0$ii 0 $ii
		 Tcalcuu Tuu1$ii 1 $ii
		 Tcalcuu Tuu2$ii 2 $ii
		 Tcalcuu Tuu3$ii 3 $ii
		}
		}
		if(($1==0)||($1==3)){\
		#    
		# Tdd
		do ii=0,3 {
		 Tcalcdd Tdd0$ii 0 $ii
		 Tcalcdd Tdd1$ii 1 $ii
		 Tcalcdd Tdd2$ii 2 $ii
		 Tcalcdd Tdd3$ii 3 $ii
		}
		}
fullstress 0    #
		stresscalc 0
		stresscalc 1
		stresscalc 2
		stresscalc 3		
		#    
ergocalc1       0 # requires: fullstress
		#
		set diffomegaf=(ABS(omegaf2)<2) ? (omegaf2-omegahvsr) : 0
		set diffomegaf2=(ABS(omegaf2)<2) ? omegaf2*(omegaf2-omegahvsr) : 0
		# get momentum con-vector as by static observer
		set pu0=-Tuu00
		set pu1=-Tuu10
		set pu2=-Tuu20
		set pu3=-Tuu30
		# get energy-momentum co-vector as by static observer
		set pd0=-Tdd00
		set pd1=-Tdd10
		set pd2=-Tdd20
		set pd3=-Tdd30
		#
		# get energy-momentum vector as by a comoving observer
		set pcu0=-(Tuu00*ud0+Tuu01*ud1+Tuu02*ud2+Tuu03*ud3)
		set pcu1=-(Tuu10*ud0+Tuu11*ud1+Tuu12*ud2+Tuu13*ud3)
		set pcu2=-(Tuu20*ud0+Tuu21*ud1+Tuu22*ud2+Tuu23*ud3)
		set pcu3=-(Tuu30*ud0+Tuu31*ud1+Tuu32*ud2+Tuu33*ud3)
		# get energy-momentum vector as by a comoving observer
		set pcd0=-(Tdd00*uu0+Tdd01*uu1+Tdd02*uu2+Tdd03*uu3)
		set pcd1=-(Tdd10*uu0+Tdd11*uu1+Tdd12*uu2+Tdd13*uu3)
		set pcd2=-(Tdd20*uu0+Tdd21*uu1+Tdd22*uu2+Tdd23*uu3)
		set pcd3=-(Tdd30*uu0+Tdd31*uu1+Tdd32*uu2+Tdd33*uu3)
		#
		# energy per baryon at infinity
		set EINF=-Tud00/(rho*uu0)
		set EINFMA=-Tud00MA/(rho*uu0)
		set EINFEM=-Tud00EM/(rho*uu0)
		#
		set fakeEINF=-ud0
		set fakeLINF=ud3
		#
		# angular momentum per baryon at infinity
		set LINF=Tud03/(rho*uu0)
		set LINFMA=Tud03MA/(rho*uu0)
		set LINFEM=Tud03EM/(rho*uu0)
		#
		#
		#
		# energy as measured by the comoving observer
		# E=-p.u (YES!)
		# same as (rho+u+bsq)
		set EC=-(pcu0*ud0+pcu1*ud1+pcu2*ud2+pcu3*ud3)
		#
		# energy as measured by comoving observer
		computeenrest ENREST
		computeenrest2 ENREST2
		computeenrest3 ENREST3
		#
		# also rest mass-energy, well for particle, for fluid is comoving energy (EC)
		set mu=sqrt(-(pcd0*pcu0+pcd1*pcu1+pcd2*pcu2+pcd3*pcu3))
		#
		# only for particle
		set Lz=pd3
		#
		# Carter's constant (only for particle)
		#
		set LL=pd2**2+cos(h)**2*(a**2*(mu**2-EINF**2)+Lz**2/sin(h)**2)
		set KK=LL+(Lz-a*EINF)**2
		#
tsq   0         #
		set mytsq=Tdd00*Tdd00+Tdd11*Tdd11+Tdd22*Tdd22+Tdd33*Tdd33+2*(Tdd01*Tuu01+Tdd02*Tuu02+Tdd03*Tuu03+Tdd13*Tuu13+Tdd23*Tuu23+Tdd12*Tuu12)
		set mytsqEM=Tdd00EM*Tuu00EM+Tdd11EM*Tuu11EM+Tdd22EM*Tuu22EM+Tdd33EM*Tuu33EM+2*(Tdd01EM*Tuu01EM+Tdd02EM*Tuu02EM+Tdd03EM*Tuu03EM+Tdd13EM*Tuu13EM+Tdd23EM*Tuu23EM+Tdd12EM*Tuu12EM)
		set mytsqMA=Tdd00MA*Tuu00MA+Tdd11MA*Tuu11MA+Tdd22MA*Tuu22MA+Tdd33MA*Tuu33MA+2*(Tdd01MA*Tuu01MA+Tdd02MA*Tuu02MA+Tdd03MA*Tuu03MA+Tdd13MA*Tuu13MA+Tdd23MA*Tuu23MA+Tdd12MA*Tuu12MA)		
		#
elinfcalc  3     # einfcalc risco einf linf
		if(a<0.9999999){\
		 set $2=(1-2/$1+a/($1)**(3/2))/(1-3/$1+2*a/($1)**(3/2))**(1/2)
		 set $3=(sqrt($1)*($1**2-2*a*sqrt($1)+a**2))/($1*($1**2-3*$1+2*a*sqrt($1))**(1/2))
		}\
		else{\
		        if($1<2.0){\
		        # einf
		               set $2=0.57735
		               # linf
		               set $3=0.0
		            }\
		                   else{\
		                      # einf
		                      set $2=0.946729
		                      # linf
		                      set $3=4.2339
		                   }
		                }
		
                #
riscocalc 2     # risco which(inner=0, outer=1) answer
		# riscocalc 1 risco
		if($1==0){ set sign=1 } else { set sign=-1 }
		#
		set Z1 = 1. + (1. - a*a)**(1./3.)*((1. + a)**(1./3.) + (1. - a)**(1./3.))
		set Z2 = sqrt(3.*a*a + Z1*Z1)
		set $2=3. + Z2-sign*sqrt((3. - Z1)*(3. + Z1 + 2.*Z2))
                #
jsq        0    #
		#
		#
		# P.U=0 check
		#
		set pdotu0=gv300*uu0+ud0*ud0*uu0+\
		           gv301*uu1+ud0*ud1*uu1+\
		           gv302*uu2+ud0*ud2*uu2+\
		           gv303*uu3+ud0*ud3*uu3
		# below not too small!
		#set it=LG(ABS(pdotu1)+1E-15)
		set pdotu1=gv310*uu0+ud1*ud0*uu0+\
		           gv311*uu1+ud1*ud1*uu1+\
		           gv312*uu2+ud1*ud2*uu2+\
		           gv313*uu3+ud1*ud3*uu3
		set crap1=ud1*ud0*uu0+\
		           ud1*ud1*uu1+\
		           ud1*ud2*uu2+\
		           ud1*ud3*uu3
		set crap2=gv310*uu0+\
		           gv311*uu1+\
		           gv312*uu2+\
		           gv313*uu3
		set pdotu2=gv320*uu0+ud2*ud0*uu0+\
		           gv321*uu1+ud2*ud1*uu1+\
		           gv322*uu2+ud2*ud2*uu2+\
		           gv323*uu3+ud2*ud3*uu3
		set pdotu3=gv330*uu0+ud3*ud0*uu0+\
		           gv331*uu1+ud3*ud1*uu1+\
		           gv332*uu2+ud3*ud2*uu2+\
		           gv333*uu3+ud3*ud3*uu3
		    #
		#
		set pdotj0d=gv300*ju0+ud0*ud0*ju0+\
		           gv301*ju1+ud0*ud1*ju1+\
		           gv302*ju2+ud0*ud2*ju2+\
		           gv303*ju3+ud0*ud3*ju3
		set pdotj1d=gv310*ju0+ud1*ud0*ju0+\
		           gv311*ju1+ud1*ud1*ju1+\
		           gv312*ju2+ud1*ud2*ju2+\
		           gv313*ju3+ud1*ud3*ju3
		set pdotj2d=gv320*ju0+ud2*ud0*ju0+\
		           gv321*ju1+ud2*ud1*ju1+\
		           gv322*ju2+ud2*ud2*ju2+\
		           gv323*ju3+ud2*ud3*ju3
		set pdotj3d=gv330*ju0+ud3*ud0*ju0+\
		           gv331*ju1+ud3*ud1*ju1+\
		           gv332*ju2+ud3*ud2*ju2+\
		           gv333*ju3+ud3*ud3*ju3
		    #
		set pdotj0u=gn300*jd0+uu0*uu0*jd0+\
		           gn301*jd1+uu0*uu1*jd1+\
		           gn302*jd2+uu0*uu2*jd2+\
		           gn303*jd3+uu0*uu3*jd3
		set pdotj1u=gn310*jd0+uu1*uu0*jd0+\
		           gn311*jd1+uu1*uu1*jd1+\
		           gn312*jd2+uu1*uu2*jd2+\
		           gn313*jd3+uu1*uu3*jd3
		set pdotj2u=gn320*jd0+uu2*uu0*jd0+\
		           gn321*jd1+uu2*uu1*jd1+\
		           gn322*jd2+uu2*uu2*jd2+\
		           gn323*jd3+uu2*uu3*jd3
		set pdotj3u=gn330*jd0+uu3*uu0*jd0+\
		           gn331*jd1+uu3*uu1*jd1+\
		           gn332*jd2+uu3*uu2*jd2+\
		           gn333*jd3+uu3*uu3*jd3
		    #
		    set god=pdotj0d*pdotj0u+\
		        pdotj1d*pdotj1u+\
		        pdotj2d*pdotj2u+\
		        pdotj3d*pdotj3u
		    set god1=god/rho**2
		#
		set E1=bu2*uu3-bu3*uu2
		set E2=bu3*uu1-bu1*uu3
		set E3=-bu2*uu1+bu1*uu2
		set edotbfake=-gdet/4*(E1*B1+E2*B2+E3*B3)
		do jj=0,3 {
		   dualb fsuu0$jj 0 $jj
		   dualb fsuu1$jj 1 $jj
		   dualb fsuu2$jj 2 $jj
		   dualb fsuu3$jj 3 $jj
		}
		set edotb=fdd01*fsuu01+fdd02*fsuu02+fdd03*fsuu03+ \
		    fdd10*fsuu10+fdd12*fsuu12+fdd13*fsuu13+ \
		    fdd20*fsuu20+fdd21*fsuu21+fdd23*fsuu23+ \
		    fdd30*fsuu30+fdd31*fsuu31+fdd32*fsuu32
		    #

		#
		# B^i = *F^{it}
		# NOT FINISHED 4 lines below
		#set fsdd00=gcov00*fsuu00+gcov01*fsuu01+gcov02*fsuu02+gcov03*fsuu03
		#set fsdd01=gcov10*fsuu01+gcov11*fsuu01+gcov02*fsuu02+gcov03*fsuu03
		#set fsdd02=gcov20*fsuu02+gcov21*fsuu01+gcov02*fsuu02+gcov03*fsuu03
		#set fsdd03=gcov30*fsuu03+gcov31*fsuu01+gcov02*fsuu02+gcov03*fsuu03
		#
		set Bu0=fsuu00
		set Bu1=fsuu10
		set Bu2=fsuu20
		set Bu3=fsuu30
		#
		set fsq=2*(fdd01*fuu01+fdd02*fuu02+fdd03*fuu03+fdd13*fuu13+fdd23*fuu23+fdd12*fuu12)
		set fdotu0=fdd01*uu1+fdd02*uu2+fdd03*uu3
		set fdotu1=-fdd01*uu0+fdd12*uu2+fdd13*uu3
		set fdotu2=-fdd02*uu0-fdd12*uu1+fdd23*uu3
		set fdotu3=-fdd03*uu0-fdd13*uu1-fdd23*uu2
		#
		# compute the force-free condition (is it 0 somewhere?)
		set jsq=ju0*jd0+ju1*jd1+ju2*jd2+ju3*jd3
		set jdotfd0=(ju0*fdd00+ju1*fdd10+ju2*fdd20+ju3*fdd30)
		set jdotfd1=(ju0*fdd01+ju1*fdd11+ju2*fdd21+ju3*fdd31)
		set jdotfd2=(ju0*fdd02+ju1*fdd12+ju2*fdd22+ju3*fdd32)
		set jdotfd3=(ju0*fdd03+ju1*fdd13+ju2*fdd23+ju3*fdd33)
		#       
		set jdotfu0=(jd0*fuu00+jd1*fuu10+jd2*fuu20+jd3*fuu30)
		set jdotfu1=(jd0*fuu01+jd1*fuu11+jd2*fuu21+jd3*fuu31)
		set jdotfu2=(jd0*fuu02+jd1*fuu12+jd2*fuu22+jd3*fuu32)
		set jdotfu3=(jd0*fuu03+jd1*fuu13+jd2*fuu23+jd3*fuu33)
		set ffracnum=jdotfd0*jdotfu0+jdotfd1*jdotfu1+jdotfd2*jdotfu2+jdotfd3*jdotfu3
		set ffrac=ffracnum/(jsq*fsq)
		set zeta=lg(ABS(ffrac))
		#
		#
		set rhoq=-(ud0*ju0+ud1*ju1+ud2*ju2+ud3*ju3)
		#
		#
faraday   0  #
		# these are native values according to HARM
		set fdd00=0*gdet
		set fdd11=0*gdet
		set fdd22=0*gdet
		set fdd33=0*gdet
		set fdd01=gdet*(uu2*bu3-uu3*bu2) # f_tr
		set fdd10=-fdd01
		set fdd02=gdet*(uu3*bu1-uu1*bu3) # f_th
		set fdd20=-fdd02
		set fdd03=gdet*(uu1*bu2-uu2*bu1) # f_tp
		set fdd30=-fdd03
		set fdd13=gdet*(uu2*bu0-uu0*bu2) # f_rp = gdet*B2
		set fdd31=-fdd13
		set fdd23=gdet*(uu0*bu1-uu1*bu0) # f_hp = gdet*B1
		set fdd32=-fdd23
		set fdd12=gdet*(uu0*bu3-uu3*bu0) # f_rh = gdet*B3
		set fdd21=-fdd12
		#
		set fuu00=0*gdet
		set fuu11=0*gdet
		set fuu22=0*gdet
		set fuu33=0*gdet
		set fuu01=-1/gdet*(ud2*bd3-ud3*bd2) # f^tr
		set fuu10=-fuu01
		set fuu02=-1/gdet*(ud3*bd1-ud1*bd3) # f^th
		set fuu20=-fuu02
		set fuu03=-1/gdet*(ud1*bd2-ud2*bd1) # f^tp
		set fuu30=-fuu03
		set fuu13=-1/gdet*(ud2*bd0-ud0*bd2) # f^rp
		set fuu31=-fuu13
		set fuu23=-1/gdet*(ud0*bd1-ud1*bd0) # f^hp
		set fuu32=-fuu23
		set fuu12=-1/gdet*(ud0*bd3-ud3*bd0) # f^rh
		set fuu21=-fuu12
		#
		# added after jrdptavg so no calculations depend on the absolute value, just read or compute it here
		if(1){\
		set afdd00=fdd00
		set afdd11=fdd11
		set afdd22=fdd22
		set afdd33=fdd33
		set afdd01=fdd01
		set afdd10=fdd10
		set afdd02=fdd02
		set afdd20=fdd20
		set afdd03=fdd03
		set afdd30=fdd30
		set afdd13=fdd13
		set afdd31=fdd31
		set afdd23=fdd23
		set afdd32=fdd32
		set afdd12=fdd12
		set afdd21=fdd21
		#
		set afuu00=fuu00
		set afuu11=fuu11
		set afuu22=fuu22
		set afuu33=fuu33
		set afuu01=fuu01
		set afuu10=fuu10
		set afuu02=fuu02
		set afuu20=fuu20
		set afuu03=fuu03
		set afuu30=fuu30
		set afuu13=fuu13
		set afuu31=fuu31
		set afuu23=fuu23
		set afuu32=fuu32
		set afuu12=fuu12
		set afuu21=fuu21
		}
		#
		if(0){\
		set afdd00=ABS(fdd00)
		set afdd11=ABS(fdd11)
		set afdd22=ABS(fdd22)
		set afdd33=ABS(fdd33)
		set afdd01=ABS(fdd01)
		set afdd10=ABS(fdd10)
		set afdd02=ABS(fdd02)
		set afdd20=ABS(fdd20)
		set afdd03=ABS(fdd03)
		set afdd30=ABS(fdd30)
		set afdd13=ABS(fdd13)
		set afdd31=ABS(fdd31)
		set afdd23=ABS(fdd23)
		set afdd32=ABS(fdd32)
		set afdd12=ABS(fdd12)
		set afdd21=ABS(fdd21)
		#
		set afuu00=ABS(fuu00)
		set afuu11=ABS(fuu11)
		set afuu22=ABS(fuu22)
		set afuu33=ABS(fuu33)
		set afuu01=ABS(fuu01)
		set afuu10=ABS(fuu10)
		set afuu02=ABS(fuu02)
		set afuu20=ABS(fuu20)
		set afuu03=ABS(fuu03)
		set afuu30=ABS(fuu30)
		set afuu13=ABS(fuu13)
		set afuu31=ABS(fuu31)
		set afuu23=ABS(fuu23)
		set afuu32=ABS(fuu32)
		set afuu12=ABS(fuu12)
		set afuu21=ABS(fuu21)
		}
		#
		# these 2 are equal in degen electrodynamics when d/dt=d/dphi->0
		set omegaf1=fdd01/fdd13 # = ftr/frp
		set omegaf2=fdd02/fdd23 # = fth/fhp
                set omegaf=(abs(fdd01)+abs(fdd02))/(abs(fdd13)+abs(fdd23))
		#
		set aomegaf1=afdd01/afdd13 # = ftr/frp
		set aomegaf2=afdd02/afdd23 # = fth/fhp
		#
		#
		# these are HARM+d/dt->0
		#set fdd01=gdet*(uu2/uu1*(bu3*uu1-bu1*uu3)) # f_tr
		#set fdd02=gdet*(uu3*bu1-uu1*bu3) # f_th
		#set fdd03=0 # f_tp
		#set fdd13=gdet*((-bu1*uu0+bu0*uu1)*uu2/uu1) # f_rp = gdet*B2 (only modified one)
		#set fdd23=gdet*(uu0*bu1-uu1*bu0) # f_hp = gdet*B1
		#set fdd12=gdet*(uu0*bu3-uu3*bu0) # f_rh = gdet*B3
		#
		#
setbztdd00 0 #
		# assumes d/dt->0 and d/dphi->0 and E.B=0
		bzeflux
		set bztdd00=(2*B1**2*omegaf2**2*(a**2	+ 2*r**2 + a**2*cos(2*h))*sin(h)**2 + 2*a*B2**2*omegaf2**2*(a**2 + 2*r**2 + a**2*cos(2*h))*sin(h)**2 + \
		  4*B2**2*omegaf2**2*r*(a**2 + 2*r**2 + a**2*cos(2*h))*sin(h)**2 + \
		  2*B2**2*omegaf2**2*(a**2 + (-2 + r)*r)*(a**2 + 2*r**2 + a**2*cos(2*h))*sin(h)**2 + \
		  ((a**2 + 2*(-2 + r)*r + a**2*cos(2*h))*(-16*B1*B3*(a - 2*omegaf2*r)*sin(h)**2 + 8*B3**2*(a**2 + (-2 + r)*r)*sin(h)**2 + \
		  B1**2*(8 - 4*omegaf2**2*(a**2 + 2*r*(2 + r) + a**2*cos(2*h))*sin(h)**2) + \
		  4*B2**2*(a**2 - 4*r + 2*r**2 + a**2*cos(2*h) + 8*a*omegaf2*r*sin(h)**2 - \
		  omegaf2**2*(a**4 + 2*r**4 + a**2*r*(2 + 3*r) + a**2*(a**2 + (-2 + r)*r)*cos(2*h))*sin(h)**2)))/ \
		  (4.*(a**2 + 2*r**2 + a**2*cos(2*h))))/4.
		  #
bzeflux         #
		faraday
		#
		set rp=1+sqrt(1-a**2)
		set omegah=a/(rp**2+a**2)
		set omegahvsr=a/(r**2+a**2)
		set diffomega=ud3-omegahvsr
		#
		set Delta=r**2-2*r+a**2
		set Sigma0=r**2+a**2
		set Sigma=r**2+a**2*cos(h)**2
		#
		set Sigmaks=Sigma0**2-a**2*Delta*sin(h)**2
		set rhoks=sqrt(r**2+a**2*cos(h)**2)
		#
		#
		set htest=pi*tx2+1/2*(1-hslope)*sin(2*pi*tx2)
		set gdetbl=Sigma**2*sin(h)**2
		set gdetks=rhoks**2*ABS(sin(h))
		set gdetksp=gdetks*(r-R0)*ABS(pi+(1-hslope)*pi*cos(2*pi*tx2))
		#
		set bzfromt=gdet*(bsq*uu1*ud0-bu1*bd0)
		# ks
		set bzfromfks=-gdet*fdd02*(-2*r*fdd02+a*fdd23+(2*r-rhoks**2-a**2*sin(h)**2)*fdd12)/rhoks**4
		set bzfromfks=gdetks*B1**2*omegaf1*(omegaf1-omegah)*sin(h)**2*(rp**2+a**2)
		set bzfromfksp0=(rp-R0)*B1**2*omegaf2*(omegaf2-omegah)*sin(h)**2*(rp**2+a**2)
		# ksp
		set E=exp(1.0)
		set M=1
		set bzfromfksp=gdet*(fdd02*(a*fdd23*(-r + R0) - 2*M*r*(fdd12 - fdd02*r + fdd02*R0) + fdd12*rhoks**2 + a**2*fdd12*sin(h)**2))/(pi**2*(r - R0)**2*rhoks**4*(-1 + (-1 + hslope)*cos(2*pi*tx2))**2)
		#
		# this is as of 7/15/2003
		# this fits very well with eflem (i.e. no gdet)
		set M=1
		set bzksp=B1*omegaf2*sin(h)**2 *( \
		    B1*(r-R0)*(-a+2*M*r*omegaf2) + \
		    B3*Delta)
		#
		#
		#
		#set bzfromfbl=-gdet*fdd02*(-2*r*fdd02+a*fdd23+(2*r-rhoks**2-a**2*sin(h)**2)*fdd12)/rhoks**4
		#
		set bzfrombz77r=-(1/(r-R0))*fdd02*fdd12*Delta/Sigma**2
		# not transformed yet
		#set bzfrombz77h=fdd01*fdd12*Delta/Sigma**2
		# the below is transformed from bl -> ksp
		# this fits very well with bzfromt (i.e. with gdet)
		set bzwithbc=-((r-R0))*omegaf2*(omegah-omegaf2)*fdd23**2*Sigma0/Sigma**2*gdetbl/gdetksp
		#
mass_flux       2 # mass_flux name dir
		define dir ($2)
		set $1=rho*uu$dir
		set $1=$1*gdet
mhd_calc        3 # mhd_calc name comp dir
		# T^{dir}_{comp}
		define comp ($2)
		define dir ($3)
		set w=p+rho+u
		set eta=w+bsq
		set deltas=($comp==$dir) ? 1 : 0
		define delta (deltas)
		set $1=eta*uu$dir * ud$comp + ptot*deltas-bu$dir * bd$comp
		set $1=$1*gdet
		#
Tcalcud      3 # Tcalc name dir comp
		# T^{dir}_{comp}
		define comp ($3)
		define dir ($2)
		set w=p+rho+u
		set eta=w+bsq
		set deltas=($comp==$dir) ? 1 : 0
		define delta (deltas)
		set $1=eta*uu$dir * ud$comp + ptot*deltas-bu$dir * bd$comp
		#
		# below pressure term was missing for TT term -- never used till recently
		set $1EM=bsq*uu$dir * ud$comp - bu$dir * bd$comp + (bsq*0.5)*deltas
		set $1MA=w*uu$dir * ud$comp + p*deltas
		#
		set $1part0=p*uu$dir*ud$comp    # MA
		set $1part1=rho*uu$dir*ud$comp  # MA
		set $1part2=u*uu$dir*ud$comp    # MA
		set $1part3=bsq*uu$dir*ud$comp  # EM
		set $1part4=p*deltas            # MA
		set $1part5=(bsq*0.5)*deltas    # EM
		set $1part6=-bu$dir*bd$comp     # EM
		#
Tcalcuu      3 # Tcalcuu name comp dir
		# T^{dir comp}
		define comp ($2)
		define dir ($3)
		set w=p+rho+u
		set eta=w+bsq
		#define myg ('$dir''$comp')
		set $1=eta*uu$dir * uu$comp + ptot*gn3$3$2 -bu$dir * bu$comp + bsq*uu$dir*uu$comp
		set $1EM=bsq*uu$dir * uu$comp - bu$dir * bu$comp
		set $1MA=w*uu$dir * uu$comp + p*gn3$3$2
		set $1part0=p*uu$dir*uu$comp
		set $1part1=rho*uu$dir*uu$comp
		set $1part2=u*uu$dir*uu$comp
		set $1part3=bsq*uu$dir*uu$comp
		set $1part4=p*gn3$3$2
		set $1part5=(bsq*0.5)*gn3$3$2
		set $1part6=-bu$dir*bu$comp
		#
Tcalcdd      3 # Tcalcdd name comp dir
		# T_{dir comp}
		define comp ($2)
		define dir ($3)
		set w=p+rho+u
		set eta=w+bsq
		set $1=eta*ud$dir * ud$comp + ptot*gv3$3$2-bd$dir * bd$comp
		set $1EM=bsq*ud$dir * ud$comp - bd$dir * bd$comp + (bsq*0.5)*gv3$3$2
		set $1MA=w*ud$dir * ud$comp + p*gv3$3$2
		set $1part0=p*ud$dir*ud$comp
		set $1part1=rho*ud$dir*ud$comp
		set $1part2=u*ud$dir*ud$comp
		set $1part3=bsq*ud$dir*ud$comp
		set $1part4=p*gv3$3$2
		set $1part5=(bsq*0.5)*gv3$3$2
		set $1part6=-bd$dir*bd$comp
		#
computeenrest 1   # computeenrest ENREST
		set volume=$dx1*$dx2*2*pi*gdet
		set $1=0
		do ii=0,3 {
		   do jj=0,3 {
		      subenrest $1 $ii $jj
		   }
		}
		set $1=$1*volume
		#
subenrest  3    #
		set $1=$1+Tuu$2$3 * ud$2 * ud$3
		#
computeenrest2 1   # computeenrest2 ENREST2
		set volume=$dx1*$dx2*2*pi*gdet
		set $1=0
		do ii=0,3 {
		   do jj=0,3 {
		      subenrest2 $1 $ii $jj
		   }
		}
		set $1=$1*volume
		#
subenrest2  3    #
		set $1=$1+Tud$2$3 * ud$2 * uu$3
		#
computeenrest3 1   # computeenrest3 ENREST3
		set volume=$dx1*$dx2*2*pi*gdet
		set $1=0
		do ii=0,3 {
		   do jj=0,3 {
		      subenrest3 $1 $ii $jj
		   }
		}
		set $1=$1*volume
		#
subenrest3  3    #
		set $1=$1+Tdd$2$3 * uu$2 * uu$3
		#
raise   2       # raise toraise gotraised
		# assumes toraise0,1,2,3 exists
		define zero ('0')
		define one ('1')
		define two ('2')
		define three ('3')
		#
		set $2$zero=gn300*$1$zero+gn301*$1$one+gn302*$1$two+gn303*$1$three
		set $2$one=gn310*$1$zero+gn311*$1$one+gn312*$1$two+gn313*$1$three
		set $2$two=gn320*$1$zero+gn321*$1$one+gn322*$1$two+gn323*$1$three
		set $2$three=gn330*$1$zero+gn331*$1$one+gn332*$1$two+gn333*$1$three
		#
lower   2       # lower tolower gotlowered
		# assumes tolower0,1,2,3 exists
		define zero ('0')
		define one ('1')
		define two ('2')
		define three ('3')
		#
		set $2$zero=gv300*$1$zero+gv301*$1$one+gv302*$1$two+gv303*$1$three
		set $2$one=gv310*$1$zero+gv311*$1$one+gv312*$1$two+gv313*$1$three
		set $2$two=gv320*$1$zero+gv321*$1$one+gv322*$1$two+gv323*$1$three
		set $2$three=gv330*$1$zero+gv331*$1$one+gv332*$1$two+gv333*$1$three
		#
dualb           3 # dualb name comp dir
                define comp ($2)
		define dir ($3)
		set $1=bu$comp * uu$dir - bu$dir * uu$comp
		set $1=$1*gdet
consvol         2 #
		set volume=$dx1*$dx2*2*pi*gdet
		set $1 = SUM($2*volume)
		define tempconsvol ($1)
		echo $tempconsvol
		#
qsq             0  #
		set qsq = gv311*v1*v1+gv322*v2*v2+gv333*v3*v3+2*(gv312*v1*v2+gv313*v1*v3+gv323*v2*v3)
		#
		set qsq1 = gv311*v1p*v1p+gv322*v2*v2+gv333*v3*v3+2*(gv312*v1p*v2+gv313*v1p*v3+gv323*v2*v3)
		set qsq2 = gv311*v1*v1+gv322*v2p*v2p+gv333*v3*v3+2*(gv312*v1*v2p+gv313*v1*v3+gv323*v2p*v3)
		set qsq3 = gv311*v1p*v1p+gv322*v2p*v2p+gv333*v3*v3+2*(gv312*v1p*v2p+gv313*v1p*v3+gv323*v2p*v3)
		set qsq4 = gv311*v1m*v1m+gv322*v2*v2+gv333*v3*v3+2*(gv312*v1m*v2+gv313*v1m*v3+gv323*v2*v3)
		set qsq5 = gv311*v1*v1+gv322*v2m*v2m+gv333*v3*v3+2*(gv312*v1*v2m+gv313*v1*v3+gv323*v2m*v3)
		set qsq6 = gv311*v1m*v1m+gv322*v2m*v2m+gv333*v3*v3+2*(gv312*v1m*v2m+gv313*v1m*v3+gv323*v2m*v3)
		set gammaf = sqrt(1+qsq)
		#
		set alpha=1.0/sqrt(-gn300)
		set betau1=gn301*alpha**2
		set betau2=gn302*alpha**2
		set betau3=gn303*alpha**2
		set normuu0=1/alpha
		set normuu1=-betau1/alpha
		set normuu2=-betau2/alpha
		set normuu3=-betau3/alpha
		#
fline         3 # fline B1 B2 aphi
		set da=-$2*gdet*$dx1
		set db=$1*gdet*$dx2
		set $3=0,$nx*$ny-1,1
		set $3=$3*0+1
		set $3=-da[$nx*$ny-1]*$3
		set result1=0,$nx-1,1
		do iii=0,$nx-1,1 {
		   set tempit=-da if((tj==0)&&(ti>=$iii))
		 set result1[$iii]=SUM(tempit)
		}
		do iii=0,$nx*$ny-1,1 {
		 set indexi=INT($iii%$nx)
		 set indexj=INT(($iii%($nx*$ny))/$nx)
		 set indexk=INT($iii/($nx*$ny))
		 define tempi (indexi)
		 define tempj (indexj)
		 define tempk (indexk)
		 echo $tempi $tempj
		 #
		 set result2=db if((ti==$tempi)&&(tj<=$tempj))
		 set $3[$iii]=$3[$iii]+result1[$tempi]
		 set $3[$iii]=$3[$iii]+SUM(result2)
		}
		#
		print {n}
		#
		#
vertline  1
		set myx=0,1,1
		set myx=$1+myx*1E-5
		set myy=0,1,1
		set myy[0]=-1000
		set myy[1]=1000
		connect myx myy
dhpcalc   2   # dhpalc router answer
		set strength=0
		set whichvar=lbrel
		set use1=((whichvar>strength-1E-2)&&(whichvar<strength+1E-2)&&(r<$1)&&(h>pi/2)) ? 1 : 0
		set use2=((whichvar>strength-1E-2)&&(whichvar<strength+1E-2)&&(r<$1)&&(h<pi/2)) ? 1 : 0
		set temp1=pi/2-ABS(pi/2-SUM(h*gdet*area*use1)/SUM(gdet*area*use1))
		set temp2=pi/2-ABS(pi/2-SUM(h*gdet*area*use2)/SUM(gdet*area*use2))
		set $2=(temp1+temp2)*0.5
		set temptempdhp=$2
		print {temptempdhp}
rhouumincalc 4  #
		# assumes simple atmosphere
		joncalc3 1 2 ($rhor) (1.1*$rhor) 0.1 lrho lrhoin
		joncalc3 1 2 (_Rout*0.9) (_Rout*0.99) 0.1 lrho lrhoout
		set $3=(lrhoout-lrhoin)/(lg(_Rout)-lg($rhor))
		set $1=lrhoin
		#
		joncalc3 1 2 ($rhor) (1.1*$rhor) 0.1 lu luin
		joncalc3 1 2 (_Rout*0.9) (_Rout*0.99) 0.1 lu luout
		set $4=(luout-luin)/(lg(_Rout)-lg($rhor))
		set $2=luin
		print {rhomin uumin nrho nuu}
		#
		#
fieldcollcalc 5   # fieldcollcalc aphi newh rat pdh ratavg
		#
		set $2=0,$ny-1,1
		set $2=$2*0
		set $3=$2
		#
		#
		do tempii=0,$ny-1,1 {
		   set $2[$tempii]=h[$tempii*$nx+0]
		   set myaphi=$1[$tempii*$nx+0]
		   #
		 # find the j for a given aphi
		 define tempi (0)
		 while { $tempi<$ny } {\
		        if($1[$tempi*$nx+$nx-1]>=myaphi) { break }
		        define tempi ($tempi+1)
		 }
		 set isel=$tempi
		 #print {isel}
		 if(isel==$ny) { set isel=$ny-1 }
		 # above assumes going from pole which is near aphi=0 and rises
		 # now have theta outer
		 set mythetaout=h[isel*$nx+0]
		 set $3[$tempii]=mythetaout/$2[$tempii]
		}
		set use=(newh<$4) ? 1 : 0
		set myvol=gdet*dV if(ti==0)
		set $5=SUM(use*myvol*$3)/SUM(use*myvol)
		#
		#
getfline     0  #
		!scp metric:research/grmhdcodes/newgrmhdmpi/smcalc metric:research/grmhdcodes/newgrmhdmpi/iinterp ~/sm/
		#
fieldcalcavg 3  #start end aphitavg          # time average
		#
		avgtimeg2 'dump' $1 $2
		define print_noheader (1)
                print "dumps/forfldump" {_t _n1 _n2 _n3 _startx1 _startx2 _startx3 _dx1 _dx2 _dx3 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord}
		print + "dumps/forfldump" {ti tj tk btimex btimey btimez gdet}
                # then run:
                !$!HOME/bin/smcalc 1 1 0 $nx $ny $nz ./dumps/forfldump ./dumps/tavgfl
		#
		da ./dumps/tavgfl
		lines 2 100000000
		read {aphitavgtemp 1}
		set $3=aphitavgtemp
		#
		#
fieldcalc 2	#dumpnum aphi
		#
		# computes A_\phi
		#
		define print_noheader (1)
                print "dumps/forfldump" '%21.15g %d %d %d %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %d %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %d\n' \
		    {_t _n1 _n2 _n3 _startx1 _startx2 _startx3 _dx1 _dx2 _dx3 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord}
                print + "dumps/forfldump" '%d %d %d %21.15g %21.15g %21.15g %21.15g\n' {ti tj tk B1 B2 B3 gdet}
		#!$!HOME/bin/smcalc 1 1 0 $nx $ny $nz ./dumps/forfldump ./dumps/fl$1
                !~/bin/smcalc 1 1 0 $nx $ny $nz ./dumps/forfldump ./dumps/fl$1
		da ./dumps/fl$1
		lines 2 100000000		
		read {aphitemp 1}
		set $2=aphitemp
		#
		#
ficalc 1	# ficalc 0.75
		#
		# computes PPM reduction parameter
		#
		define print_noheader (1)
                print "dumps/forficalcdump" '%21.15g %d %d %d %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %d %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %d\n' \
                {_t _n1 _n2 _n3 _startx1 _startx2 _startx3 _dx1 _dx2 _dx3 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord}
                #
                print + "dumps/forficalcdump" '%d %d %d %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
                    {ti tj tk rho u v1 v2 v3 B1 B2 B3 ptot gdet}
                #
		!$!HOME/bin/smcalc 10 4 0 $1 $nx $ny $nz ./dumps/forficalcdump ./dumps/ficalc
		da ./dumps/ficalc
		lines 2 100000000		
		read '%g %g %g' {ficalc1 ficalc2 ficalc3}
		#
		#
fieldtcalc 2	#dumpnum aphi
		#
		# computes A_t
		faraday
		#
		define print_noheader (1)
                print "dumps/forfldump" '%21.15g %d %d %d %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %d %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %d\n' \
                {_t _n1 _n2 _n3 _startx1 _startx2 _startx3 _dx1 _dx2 _dx3 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord}
                #
		    set B1omegaf2=B1*omegaf2
		    set B2omegaf2=B2*omegaf2
		    set B3omegaf2=B3*omegaf2
		    #
                print + "dumps/forfldump" '%d %d %d %21.15g %21.15g %21.15g %21.15g\n' {ti tj tk B1omegaf2 B2omegaf2 B3omegaf2 gdet}
		!$!HOME/bin/smcalc 1 1 0 $nx $ny $nz ./dumps/forfldump ./dumps/fl$1
		da ./dumps/fl$1
		lines 2 100000000		
		read {aphitemp 1}
		set $2=aphitemp
		#
		#
fieldcalci 4	#dumpnum aphi $nx $ny
		#
		interpsingle B1 $3 $4 0 0 2
		interpsingle B2 $3 $4 0 0 2
		interpsingle B3 $3 $4 0 0 2
		interpsingle gdet $3 $4 0 0 2
		jrdp1ci2 iB1 iB1
		jrdp1ci2 iB2 iB2
		jrdp1ci2 iB3 iB3
		jrdp1ci2 igdet igdet
		#
		define print_noheader (1)
                print "dumps/forfldump" '%21.15g %d %d %d %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %d %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %d\n' \
                {_t _n1 _n2 _n3 _startx1 _startx2 _startx3 _dx1 _dx2 _dx3 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord}
                #
                print + "dumps/forfldump" '%d %d %d %21.15g %21.15g %21.15g %21.15g\n' {ti tj tk iB1 iB2 iB3 igdet}
		!$!HOME/bin/smcalc 1 1 0 $nx $ny $nz ./dumps/forfldump ./dumps/fl$1
		da ./dumps/fl$1
		lines 2 100000000		
		read {aphitemp 1}
		set $2=aphitemp
		#
		#
dercalc 3	# dercalc 0 it itd
		# dercalc type it itd
		#
		define print_noheader (1)
		# 16 terms
                print "dumps/forder" '%21.15g %d %d %d %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %d %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %d\n' \
		    {_t _n1 _n2 _n3 _startx1 _startx2 _startx3 _dx1 _dx2 _dx3 _realnstep _gam _a _R0 _Rin _Rout _hslope _dt _defcoord}
		set sendtemp=$2
                print + "dumps/forder" '%d %d %d %21.15g\n' {ti tj tk sendtemp}
		!$!HOME/bin/smcalc 1 2 $1 $nx $ny $nz ./dumps/forder ./dumps/$3
		da ./dumps/$3
		lines 2 100000000		
		read {dertempx 1 dertempy 2 dertempz 3}
		set $3x=dertempx
		set $3y=dertempy
		set $3z=dertempz
		#
plcergo 17      # as with plc
		if($?3 == 1) { define tobebits ($3) } else { define tobebits (0x0) }
                if('$tobebits'=='000') {
                 set thebits=0x0
                }
                if('$tobebits'!='000') {
                 set thebits=0x$tobebits
                }
		#
		#set rinner=_Rin
		set router=2.8
		#set router=_Rout
		set hinner=0.1
		#set hinner=0
		set houter=0.9
		#set houter=pi
		#
		set rergo=1+sqrt(1-a**2*cos(h)**2)
		set zeroergo=r-rergo
		set zerohorizon=r-$rhor
                set rhorminus = 1-sqrt(1-a**2)
		set zerohorizoninner=r-rhorminus
		#
                if(thebits & 0x001) {
		 plc 0 r $3 $4 $5 $6 $7
		 set rnewfun=newfun
		 plc 0 zeroergo $3 $4 $5 $6 $7
		 set ergonewfun=newfun
		 plc 0 zerohorizon $3 $4 $5 $6 $7
		 set hornewfun=newfun
		 plc 0 zerohorizoninner $3 $4 $5 $6 $7
		 set hornewfuninner=newfun
		 plc $1 $2 $3 $4 $5 $6 $7
		 set funnewfun=newfun
		}
                if(!(thebits & 0x001)) {
                 if((thebits & 0x010)||(thebits & 0x100)) {\
		  plc 0 r $3
		  set rnewfun=newfun
		  plc 0 zeroergo $3
		  set ergonewfun=newfun
		  plc 0 zerohorizon $3
		  set hornewfun=newfun
		  plc 0 zerohorizoninner $3
		  set hornewfuninner=newfun
		  plc $1 $2 $3
		  set funnewfun=newfun
		 }\
		      else{
		  plc 0 r
		  set rnewfun=newfun
		  plc 0 zerohorizon
		  set hornewfun=newfun
		  plc 0 zerohorizoninner
		  set hornewfuninner=newfun
		  plc 0 zeroergo
		  set ergonewfun=newfun
		  plc $1 $2
		  set funnewfun=newfun
		 }
		}
		#
		define mymin ($min)
		define mymax ($max)
		plcergo2
		#
plcergo2        0
		#
		ctype default
		erase
		box
		#
		limits $txl $txh $tyl $tyh
		image ($rnx,$rny) $txl $txh $tyl $tyh
		set image[ix,iy] = funnewfun
		set lev=-1E-25,1E-25,2E-25
		levels lev
		ctype blue contour
		#
		set image[ix,iy] = funnewfun
		set lev=0,$mymax,($mymax-$mymin)/$cres
		levels lev
		ctype red contour
		#
		#
		set image[ix,iy] = funnewfun
		set lev=$mymin,0,($mymax-$mymin)/$cres
		levels lev
		ctype default contour
		#
		set image[ix,iy] = rnewfun
		set lev=-2E-25,0,2E-25
		levels lev
		ctype cyan contour		
		#
		set image[ix,iy] = hornewfun
		set lev=1E-25,1E-25,2E-25
		levels lev
		ctype yellow contour		
		#
		set image[ix,iy] = hornewfuninner
		set lev=1E-25,1E-25,2E-25
		levels lev
		ctype yellow contour		
		#
		set image[ix,iy] = ergonewfun
		set lev=1E-25,1E-25,2E-25
		levels lev
		ctype green contour		
		#
plcergo3        0
		#
		if(($rnx!=$nx)||($rny!=$ny)){\
		       set radius=sqrt(reallyx**2+reallyy**2)
		       set radiusergo=1+sqrt(1-a**2*(reallyy/radius)**2)
		       set otherzeroergo=radius-radiusergo
		    }
		if(($rnx==$nx)&&($rny==$ny)){\
		       set radius=sqrt(x12**2+x22**2)
		       set radiusergo=1+sqrt(1-a**2*(x22/radius)**2)
		       set otherzeroergo=radius-radiusergo
		    }
		    #
		set lev=-1E-25,1E-25,2E-25
		levels lev
		#ctype blue contour
		lweight 8
		ctype cyan
		ltype 2 contour
		lweight 3
		#
		set image[ix,iy] = radius
		set lev=($rhor),($rhor+1E-5),2E-5
		levels lev
		#ctype cyan contour
		lweight 6
		ctype blue
		ltype 0 contour
		lweight 3
		#
		set image[ix,iy] = otherzeroergo
		set lev=1E-3,1E-3,2E-3
		levels lev
		#ctype green contour
		lweight 6
		ctype blue
		ltype 0 contour
		lweight 3
		#
plc0 17      # as with plc
		if($?3 == 1) { define tobebits ($3) } else { define tobebits (0x0) }
                if('$tobebits'=='000') {
                 set thebits=0x0
                }
                if('$tobebits'!='000') {
                 set thebits=0x$tobebits
                }
		#
		#
                if(thebits & 0x001) {
		 plc $1 $2 $3 $4 $5 $6 $7
		}
                if(!(thebits & 0x001)) {
                 if((thebits & 0x010)||(thebits & 0x100)) {\
		  plc $1 $2 $3
		 }\
		      else{
		  plc $1 $2
		 }
		}
		#
		#set lev=-1E-25,1E-25,2E-25
		set lev=-1E-40,1E-40,2E-40
		levels lev
		ctype blue
		contour
		#
		# animate plc in HARM
agplc 17	# animplc 'dump' r 000 <0 0 0 0>
                if($?3 == 0) { define numsend (2) }\
                else{\
                  if($?4 == 1) { define numsend (4) } else { define numsend 3 }
                }
                #defaults
		#define PLANE (3)
		#define WHICHLEV (0)
		#set constlevelshit=0
		#
                do ii=startanim,endanim,$ANIMSKIP {
                  set h1=$1
		  set h2=sprintf('%04d',$ii) set _fname=h1+h2
                  define filename (_fname)
                    #
                    set h1='fluxdump' set _fname=h1+h2
                    define filenameflux (_fname)
                    #
		  set h1='debug' set _fname=h1+h2
                  define filenamedebug (_fname)
                    #
		  set h1='vpotdump' set _fname=h1+h2
                  define filenamevpot (_fname)
                    #
                    #
		  #jrdp2d $filename
		  #define coord 1
                  #jrdpcf3duold $filename
		  #
		  #jrdppenna $filename
		  #
		  # GRB STUFF
		  #echo $filename $filenameflux $filenamedebug
                  #jrdp3du $filename
                  #jrdpflux $filenameflux
                  #jrdpdebug $filenamedebug
                    #
                    #jrdpcf3duentropy $filename
                    #jrdpflux $filenameflux
                    #jrdpdebug $filenamedebug
                    #jrdpvpot $filenamevpot
                    #
                    #
                    #jrdprad $filename
                    jrdprad2 $filename
                    #
                    if(0){\
                     define POSCONTCOLOR "cyan"
                     define NEGCONTCOLOR "cyan"
                     plc 0 nsin 001 3 10 0.8 2.3
		     define POSCONTCOLOR "red"
		     define NEGCONTCOLOR "default"
                    }
                  #
                  #
                    #fieldcalc 0 aphi
		  #jre mode2.m
		  #alfvenvp
		  #interpsingle aphi 128 128 -2.5 2.5 -2.5 2.5
		  #readinterp aphi
		  #define CONSTLEVELS 1
                    #faraday
		  #device postencap $filename.$ii
                  if($numsend==2){ plc0  0 $2 $3}\
                  else{\
                   if($numsend==3){  plc0  0 $2 $3}\
                   else{\
                    if($numsend==4){ plc0  0 $2 $3 $4 $5 $6 $7}
                   }
                  }
		  #
		  #device X11
		  # show zero contours
		  #if(1){\
		  #       set lev=-1E-15,1E-15,2E-15
		  #       levels lev
		  #       ctype blue contour
		  #    }
                  #delay loop
                  #set jj=0
                  #while {jj<1} {set jj=jj+1}
		}
		#
		# animate pls in HARM
agzplc 17	# animplc 'dump' r 000 <0 0 0 0>
		#
                if($?3 == 0) { define numsend (2) }\
                else{\
                  if($?4 == 1) { define numsend (4) } else { define numsend 3 }
                }
		#
                #defaults
		set startanim=0
                # assume any plane
                if($PLANE==1){ set endanim=$nx-1 }
                if($PLANE==2){ set endanim=$ny-1 }
                if($PLANE==3){ set endanim=$nz-1 }
		#define PLANE (3)
		#define WHICHLEV (0)
                set h1=$1
		set constlevelshit=0
		#
		define ii (0)
		#do ii=startanim,endanim,$ANIMSKIP {
		while{1==1}{\
		        set iitemp=$ii
		  print '%d\n' {iitemp}
		  define WHICHLEV ($ii)
		  #
                  if($numsend==2){ plc0  0 $2}\
                  else{\
                   if($numsend==3){  plc0  0 $2 $3}\
                   else{\
                    if($numsend==4){ plc0  0 $2 $3 $4 $5 $6 $7}
                   }
                  }
		  set iitemp=$ii+1
		  define ii (iitemp)
		  if($ii==endanim){ define ii (startanim) }
                  #delay loop
                  set jj=0
                  while {jj<10000} {set jj=jj+1}
		  #
		}
		#
		# animate pls in HARM
agpl  18	# agpl 'dump' r fun 000 <0 0 0 0>
                if($?4 == 0) { define numsend (2) }\
                else{\
                  if($?5 == 1) { define numsend (4) } else { define numsend 3 }
                }
                #defaults
		define PLANE (3)
		define WHICHLEV (0)
                set h1=$1
		set h1gdump='gdump'
		set h1debug='debug'
		set h1eosdump='eosdump'
		#
                do ii=startanim,endanim,$ANIMSKIP {
		   set h2=sprintf('%04d',$ii)
		   set _fname=h1+h2
		   set _fnamedebug=h1debug+h2
		   set _fnamegdump=h1gdump+h2
		   set _fnameeosdump=h1eosdump+h2
                  define filename (_fname)
                  define filenameeosdump (_fnameeosdump)
                  define filenamedebug (_fnamedebug)
                  define filenamegdump (_fnamegdump)
		  #jrdp2d $filename
		  #
          # pre-radiation, but with entropy, but no currents
          #jrdp3duentropy $filename
          # with radiation
          #jrdprad $filename
          # with radiation but no currents but with entropy
          jrdprad2 $filename
                  #jrdpraddump rad$filename
		  # NEW
                  #jrdpall $ii
                  #jrdp3du $filename
                  #define arg (h2)
                  #jrdpallgrb $arg
		  #
		  # OLD
		  #jrdp3duold $filename
		  #
		  # GENERAL
		  #grid3d $filenamegdump
                  #
		  #set dphidt = c000*gv300 + c100*gv301 + c200*gv302 + c300*gv303
		  #
                  #jrdpdebug $filenamedebug
                  #faraday
		  ctype default
		  #set hor=sqrt(cs2)/(r*omega3)
		  #stresscalc 1
		  #lweight 3 
                  if($numsend==2){ pl  0 $2 $3}\
                  else{\
                   if($numsend==3){  pl  0 $2 $3 $4}\
                   else{\
                    if($numsend==4){ pl  0 $2 $3 $4 $5 $6 $7 $8}
                   }
                  }
		  #
		  #jrdp3du ../../run.laxf/dumps/$filename
		  #faraday
		  #set hor=sqrt(cs2)/(r*omega3)
		  #stresscalc 1
		  #lweight 3
		  #ctype red
                  #if($numsend==2){ pl  0 $2 $3}\
                  #else{\
                  # if($numsend==3){  pl  0 $2 $3 $4}\
                  # else{\
                  #  if($numsend==4){ pl  0 $2 $3 $4 $5 $6 $7 $8}
                  # }
                  #}
		  #
		  #
		  #lweight 5
		  #points $2 $3
		  #lweight 3
		  #
                  #
                  # ctype red
                  #plo 0 $2 fail0
                  #
		  #set god=$3
		  #set myfit=2.0*god[0]*(r/r[0])**(-5/4)
		  #set myfit=0.1*(r/r[0])**(-5/4)
		  #ctype red pl 0 $2 myfit 1110
		  #ctype default
		  #lweight 5 points $2 $3
                  #delay loop
		  #set jj=0
		  #while {jj<10000} {set jj=jj+1}
		  #!sleep .5s
		}
		#
		# animate pls in HARM
agpldeath  18	# agpl 'dump' r fun 000 <0 0 0 0>
                if($?4 == 0) { define numsend (2) }\
                else{\
                  if($?5 == 1) { define numsend (4) } else { define numsend 3 }
                }
                #defaults
		define PLANE (3)
		define WHICHLEV (0)
                set h1=$1
		#
                do ii=startanim,endanim,$ANIMSKIP {
		   set h2=sprintf('%04d',$ii) set _fname=h1+h2
                  define filename (_fname)
		  #jrdp2d $filename
		  #jrdp3du $filename
		  jrdp3duold $filename
		  faraday
		  ctype default
		  #
		  #
		  #device postencap $filename
		  #
		  #set hor=sqrt(cs2)/(r*omega3)
		  #stresscalc 1
		  #lweight 3
		  #
		  #
		  #
		  define myti (-35+_t)
		  define mytf (10+_t)
		  ctype default pl 0 r omegaf2 0001 $myti $mytf -.01 .05
		  ctype blue pl 0 r (-B3*r**2/1.0) 0011 $myti $mytf -.01 .05
		  #ctype cyan pl 0 r (uu3/10.0) 0011 $myti $mytf -.01 .05
		  ctype cyan pl 0 r (LG(uu1*sqrt(gv311))/100.0) 0011 $myti $mytf -.01 .05
		  ctype magenta pl 0 r ((LG(1+r*0.3))/100.0) 0011 $myti $mytf -.01 .05
		  #
		  ctype red pl 0 r (LG(uu0)/100) 0011 $myti $mytf -.01 .05
		  #
		  #
		  ctype default vertline (_t-2*pi/0.3)
		  ctype default vertline (_t)
		  #
		  #jrdp3du ../../run.laxf/dumps/$filename
		  #faraday
		  #set hor=sqrt(cs2)/(r*omega3)
		  #stresscalc 1
		  #lweight 3
		  #ctype red
                  #if($numsend==2){ pl  0 $2 $3}\
                  #else{\
                  # if($numsend==3){  pl  0 $2 $3 $4}\
                  # else{\
                  #  if($numsend==4){ pl  0 $2 $3 $4 $5 $6 $7 $8}
                  # }
                  #}
		  #
		  #
		  #set god=$3
		  #set myfit=2.0*god[0]*(r/r[0])**(-5/4)
		  #set myfit=0.1*(r/r[0])**(-5/4)
		  #ctype red pl 0 $2 myfit 1110
		  #ctype default
		  #lweight 5 points $2 $3
                  #delay loop
		  #set jj=0
		  #while {jj<10000} {set jj=jj+1}
		  #!sleep .5s#
		  #
		  #
		  #device X11
		  #
		}
		#
		# animate pls in HARM
agpls 17	# animplc 'dump' r 000 <0 0 0 0>
                if($?3 == 0) { define numsend (2) }\
                else{\
                  if($?4 == 1) { define numsend (4) } else { define numsend 3 }
                }
                #defaults
		define PLANE (3)
		define WHICHLEV (0)
                set h1=$1
                do ii=startanim,endanim,$ANIMSKIP {
		   set h2=sprintf('%04d',$ii) set _fname=h1+h2
                  define filename (_fname)
		  #jrdpbz $filename
		  #jrdpcf2d $filename
		  jrdp3du $filename
		  #faraday
		  
		   
                  if($numsend==2){ pls  0 $2}\
                  else{\
                   if($numsend==3){  pls  0 $2 $3}\
                   else{\
                    if($numsend==4){ pls  0 $2 $3 $4 $5 $6 $7}
                   }
                  }
                  #delay loop
                  #set jj=0
                  #while {jj<1} {set jj=jj+1}
		}
		#
aggpl  18	# agpl 'dump' r fun 000 <0 0 0 0>
                if($?4 == 0) { define numsend (2) }\
                else{\
                  if($?5 == 1) { define numsend (4) } else { define numsend 3 }
                }
                #defaults
		define PLANE (3)
		define WHICHLEV (0)
                set h1=$1
		#
                do ii=startanim,endanim,$ANIMSKIP {
		   set h2=sprintf('%04d',$ii) set _fname=h1+h2
                  define filename (_fname)
		  #jrdp2d $filename
		  grid3d $filename
		  #faraday
		  ctype default
		  #set hor=sqrt(cs2)/(r*omega3)
		  #stresscalc 1
		  #lweight 3 
                  if($numsend==2){ pl  0 $2 $3}\
                  else{\
                   if($numsend==3){  pl  0 $2 $3 $4}\
                   else{\
                    if($numsend==4){ pl  0 $2 $3 $4 $5 $6 $7 $8}
                   }
                  }
		  #
		  #jrdp3du ../../run.laxf/dumps/$filename
		  #faraday
		  #set hor=sqrt(cs2)/(r*omega3)
		  #stresscalc 1
		  #lweight 3
		  #ctype red
                  #if($numsend==2){ pl  0 $2 $3}\
                  #else{\
                  # if($numsend==3){  pl  0 $2 $3 $4}\
                  # else{\
                  #  if($numsend==4){ pl  0 $2 $3 $4 $5 $6 $7 $8}
                  # }
                  #}
		  #
		  #
		  #set god=$3
		  #set myfit=2.0*god[0]*(r/r[0])**(-5/4)
		  #set myfit=0.1*(r/r[0])**(-5/4)
		  #ctype red pl 0 $2 myfit 1110
		  #ctype default
		  #lweight 5 points $2 $3
                  #delay loop
		  #set jj=0
		  #while {jj<10000} {set jj=jj+1}
		  #!sleep .5s
		}
		#
		# animate pls in HARM
agplcomp  18	# agpl 'dump' r fun 000 <0 0 0 0>
                if($?4 == 0) { define numsend (2) }\
                else{\
                  if($?5 == 1) { define numsend (4) } else { define numsend 3 }
                }
                #defaults
		define PLANE (3)
		define WHICHLEV (0)
                set h1=$1
		set h1gdump='gdump'
		set h1eosdump='eosdump'
		#
                do ii=startanim,endanim,$ANIMSKIP {
		   set h2=sprintf('%04d',$ii)
		   set _fname=h1+h2
		   set _fnamegdump=h1gdump+h2
		   set _fnameeosdump=h1eosdump+h2
                  define filename (_fname)
                  define filenameeosdump (_fnameeosdump)
                  define filenamegdump (_fnamegdump)
		  #jrdp2d $filename
		  #
		  # NEW
                  #jrdpall $ii
                  jrdp3du $filename
		  #
		  #
		  faraday
		  ctype default
                  #
                  if($numsend==2){ pl  0 $2 $3}\
                  else{\
                   if($numsend==3){  pl  0 $2 $3 $4}\
                   else{\
                    if($numsend==4){ pl  0 $2 $3 $4 $5 $6 $7 $8}
                   }
                  }
		  #
		  #
		  jrdp3du ../../../makedir.test106_unsplit/run/dumps/$filename
		  #
		  ctype red
		  if($numsend==2){ pl  0 $2 $3 0010}\
                  else{\
                   if($numsend==3){  pl  0 $2 $3 $4}\
                   else{\
                    if($numsend==4){ pl  0 $2 $3 $4 $5 $6 $7 $8}
                   }
                  }
		  #
                  #delay loop
		  #set jj=0
		  #while {jj<10000} {set jj=jj+1}
		  !sleep .5s
		}
		#
		#
		#
		#
		#
agpldiff  18	# agpl 'dump' r fun 000 <0 0 0 0>
                if($?4 == 0) { define numsend (2) }\
                else{\
                  if($?5 == 1) { define numsend (4) } else { define numsend 3 }
                }
                #defaults
		define PLANE (3)
		define WHICHLEV (0)
                set h1=$1
		set h1gdump='gdump'
		set h1eosdump='eosdump'
		#
                do ii=startanim,endanim,$ANIMSKIP {
		   set h2=sprintf('%04d',$ii)
		   set _fname=h1+h2
		   set _fnamegdump=h1gdump+h2
		   set _fnameeosdump=h1eosdump+h2
                  define filename (_fname)
                  define filenameeosdump (_fnameeosdump)
                  define filenamegdump (_fnamegdump)
		  #jrdp2d $filename
		  #
		  # NEW
                  #jrdpall $ii
          #        jrdp3du $filename
                   jrdprad $filename
		  #
		  #
		  faraday
		  ctype default
                    #
                    #
                    set first=$3
                  #
		  #
		  #
		  #jrdp3du ../../../makedir.test106_unsplit/run/dumps/$filename
                    jrdprad dump0000
                    #
                    #
                    set second=$3
		  #
                    #
                    set diff=first-second
                    #
		  ctype default
		  if($numsend==2){ pl  0 $2 diff}\
                  else{\
                   if($numsend==3){  pl  0 $2 diff $4}\
                   else{\
                    if($numsend==4){ pl  0 $2 diff $4 $5 $6 $7 $8}
                   }
                  }
		  #
          #        set h1debug='debug'
		  #set _fnamedebug=h1debug+h2
          #        define filenamedebug (_fnamedebug)
          #        jrdpdebug $filenamedebug
          #        ctype red
          #        plo 0 $2 fail0
          #        #
          #        #
          #        #delay loop
		  #set jj=0
		  #while {jj<10000} {set jj=jj+1}
		  !sleep .5s
		}
		#
		#
		#
		#
		#
pldiff  19	# pldiff 'dump0000' 'dump0001' r var  000 <0 0 0 0>
                if($?5 == 0) { define numsend (2) }\
                else{\
                  if($?6 == 1) { define numsend (4) } else { define numsend 3 }
                }
                #defaults
		  define PLANE (3)
		  define WHICHLEV (0)
          define filename ($1)
          jrdprad $filename
		  faraday
		  ctype default
          set first=$4
          define filename ($2)
          jrdprad $filename
          set second=$4
          set diff=first-second
          #
		  ctype default
		  if($numsend==2){ pl  0 $3 diff}\
                  else{\
                   if($numsend==3){  pl  0 $3 diff $5}\
                   else{\
                    if($numsend==4){ pl  0 $3 diff $5 $6 $7 $8 $9}
                   }
                  }
		  #while {jj<10000} {set jj=jj+1}
		  !sleep .5s
		
		#
		#
		#
		#
		#
jrdprestart 1   #
		#
		da $1
		lines 2 100000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {rho u v1 v2 v3 B1 B2 B3 U0 U1 U2 U3 U4 U5 U6 U7} 
		#
		#
jrdprestart2 1   #
		#
		da $1
		lines 2 100000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' {rrho ru rv1 rv2 rv3 \
                            rB1 rB2 rB3 rprad0 rprad1 rprad2 rprad3 rsug rU0 rU1 rU2 rU3 rU4 rU5 rU6 rU7 rU8 rU9 rU10 rU11 rU12 rvpot0 rvpot1 rvpot2 rvpot3 rfaild0 \
                            rfaild1 rfaild2 rfaild3 rfaild4 rfaild5 rfaild6 rfaild7 rfaild8 rfaild9 rfaild10 rfaild11 rfaild12} 
		#
		#
diffrestart 0 #
        #
        set diffrho=((rho-rrho)/(abs(rho)+abs(rrho)))
        set diffu=((u-ru)/(abs(u)+abs(ru)))
        set diffv1=((v1-rv1)/(abs(v1)+abs(rv1)))
        set diffv2=((v2-rv2)/(abs(v2)+abs(rv2)))
        set diffv3=((v3-rv3)/(abs(v3)+abs(rv3)))
        set diffB1=((B1-rB1)/(abs(B1)+abs(rB1)))
        set diffB2=((B2-rB2)/(abs(B2)+abs(rB2)))
        set diffB3=((B3-rB3)/(abs(B3)+abs(rB3)))
		#
jrdplogperf 1   # jrdplogperf 0_logperf.grmhd.out
		#
		da $1
		lines 3 10000000
		read '%g %g %d %g %g %g %g %g %d %g %g %g %g %g %g' {tperf ete nperf wt zc tzc tuhr eff lete lnperf lwt lzc ltzc ltuhr leff}
		#
		#
jrdplogstep 1   # jrdplogstep 0_logstep.grmhd.out
		#
		da $1
		lines 3 10000000
		read '%g %g %g %d %d %g' {tstep dtstep courstep nstepstep realnstepstep strokesperzone}
		#
		#
