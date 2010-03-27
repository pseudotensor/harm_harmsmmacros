loadrmac1  0    #
		gogrmhd
		jre kaz.m
		jre grbmodel.m
		jre reconnection_norad.m
		#
renocoolplc1  0 #
		# gogrmhd
		# jre kaz.m
		# jre grbmodel.m
		#
		# CHANGE:
		#1) setupplc
		#2) readnocoolblock?
		#3) AND inside which file to read
		#
		set nothing=S*0
		#
		#readnocoolblock1
		#setupplc 100 67 1 S sigma nothing
                #setupplc 100 72 1 S sigma nothing
                #setupplc 100 69 1 S sigma nothing
		#
                #readnocoolblock2
                #setupplc 100 70 1 S sigma nothing
                #setupplc 100 100 1 S sigma nothing
		#setupplc 150 150 1 S sigma nothing
		#
		readnocoolblock3
                setupplc 150 150 1 S sigma nothing
		#
		#
		#
		define x1label "S"
		define x2label "\sigma"
		define PLANE 3
		define WHICHLEV 0
		#
		setgrbconsts
		#
		getit1 1
		getit1 2
		getit1 3
		getit1 4
		getit1 5
		#
		#
fixupdata 0     #
		define missing_data (7.13321362362E-16)
		define largevalue (1E30)
		set d=(abs(d)>$largevalue ? $missing_data : d)
		set ux=(abs(ux)>$largevalue ? $missing_data : ux)
		set rhoc=(abs(rhoc)>$largevalue ? $missing_data : rhoc)
		set iec=(abs(iec)>$largevalue ? $missing_data : iec)
		set rhoout=(abs(rhoout)>$largevalue ? $missing_data : rhoout)
		set ieout=(abs(ieout)>$largevalue ? $missing_data : ieout)
		set Bx=(abs(Bx)>$largevalue ? $missing_data : Bx)
		set uy=(abs(uy)>$largevalue ? $missing_data : uy)
		set Bzc=(abs(Bzc)>$largevalue ? $missing_data : Bzc)
		set Bzout=(abs(Bzout)>$largevalue ? $missing_data : Bzout)
		#
setratios 0	#
		#
		set drat=(d==$missing_data ? $missing_data : d/dnonrel)
		set uxrat=(ux==$missing_data ? $missing_data : ux/uxnonrel)
		set rhocrat=(rhoc==$missing_data ? $missing_data : rhoc/rhocnonrel)
		set iecrat=(iec==$missing_data ? $missing_data : iec/iecnonrel)
		set rhooutrat=(rhoout==$missing_data ? $missing_data : rhoout/rhooutnonrel)
		set ieoutrat=(ieout==$missing_data ? $missing_data : ieout/ieoutnonrel)
		set Bxrat=(Bx==$missing_data ? $missing_data : Bx/Bxnonrel)
		set uyrat=(uy==$missing_data ? $missing_data : uy/uynonrel)
		set Bzcrat=(Bzc==$missing_data ? $missing_data : Bzc/Bzcnonrel)
		set Bzoutrat=(Bzout==$missing_data ? $missing_data : Bzout/Bzoutnonrel)
		#
		set dmrat=(d==$missing_data ? $missing_data : d/dmixed)
		set uxmrat=(ux==$missing_data ? $missing_data : ux/uxmixed)
		set rhocmrat=(rhoc==$missing_data ? $missing_data : rhoc/rhocmixed)
		set iecmrat=(iec==$missing_data ? $missing_data : iec/iecmixed)
		set rhooutmrat=(rhoout==$missing_data ? $missing_data : rhoout/rhooutmixed)
		set ieoutmrat=(ieout==$missing_data ? $missing_data : ieout/ieoutmixed)
		set Bxmrat=(Bx==$missing_data ? $missing_data : Bx/Bxmixed)
		set uymrat=(uy==$missing_data ? $missing_data : uy/uymixed)
		set Bzcmrat=(Bzc==$missing_data ? $missing_data : Bzc/Bzcmixed)
		set Bzoutmrat=(Bzout==$missing_data ? $missing_data : Bzout/Bzoutmixed)
		#
		#
readnocoolblock1   0       #
		#
                da spdata_100._100._1.e-10_1.e10_100._1.e15.dat
		#
		lines 1 10000000
		#
		# 2*2+1 + 8*3 = 29
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {tj ti sigma S error \
                     dnonrel uxnonrel rhocnonrel iecnonrel rhooutnonrel ieoutnonrel Bxnonrel uynonrel \
                     d ux rhoc iec rhoout ieout Bx uy \
                     drat uxrat rhocrat iecrat rhooutrat ieoutrat Bxrat uyrat \
                    }
		    #
		    set Bzc=d*0
		    set Bzout=Bzc
		    set Bzcnonrel=d*0
		    set Bzoutnonrel=Bzc
		    set Bzcmixed=d*0
		    set Bzoutmixed=Bzc
                    #
		    fixupdata
		    setratios
		    #
                    computeblock
                    #
readnocoolblock2   0       #
		#
                #da tempspdata_100._100._1.e-10_1.e10_1_100_1_100_100._1.e25.dat
		da 1e25case/spdata_100._100._1.e-10_1.e10_1_100_1_100_100._1.e25.dat
		#da 1e25case/spdata_1guide__150._150._1.e-10_1.e10_1_150_1_150_10._1.e25.dat
		#
		lines 1 10000000
		#
		# 2*2+1 + 8*4 = 37
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {tj ti sigma S error \
                     dnonrel uxnonrel rhocnonrel iecnonrel rhooutnonrel ieoutnonrel Bxnonrel uynonrel \
                     dmixed uxmixed rhocmixed iecmixed rhooutmixed ieoutmixed Bxmixed uymixed \
                     d ux rhoc iec rhoout ieout Bx uy \
                     drat uxrat rhocrat iecrat rhooutrat ieoutrat Bxrat uyrat \
                    }
                    #
		    set Bzc=d*0
		    set Bzout=Bzc
		    set Bzcnonrel=d*0
		    set Bzoutnonrel=Bzc
		    set Bzcmixed=d*0
		    set Bzoutmixed=Bzc
		    #
		    fixupdata
		    setratios
		    #
                    computeblock
readnocoolblock3   0       #
		#
                da 1e25case/guide0.dat
		#da 1e25case/guide1.dat
		#
		lines 1 10000000
		#
		# 2*2+1 + 10*3 = 35
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {tj ti sigma S error \
                     dnonrel uxnonrel rhocnonrel iecnonrel rhooutnonrel ieoutnonrel Bxnonrel uynonrel Bzcnonrel Bzoutnonrel \
                     dmixed uxmixed rhocmixed iecmixed rhooutmixed ieoutmixed Bxmixed uymixed Bzcmixed Bzoutmixed \
                     d ux rhoc iec rhoout ieout Bx uy Bzc Bzout \
                    }
                    #
		    fixupdata
		    setratios
                    #
                    computeblock
                    #
computeblock 0      #
    		    # sets units
 		    set c=1
		    set rhobvalue=1.0+ti*0
		    set Lpnum=1.0+ti*0
		    set ievalue=0+ti*0
		    set pvalue=0+ti*0
		    #
		    # NOTchoice physics
		    set UginfixedT=ievalue
		    # sigma = b^2/(8pi) / (rho0 c^2)
		    set bgauss=sqrt(8*pi*sigma*rhobvalue*c**2)
		    set vaold=c*bgauss/sqrt(4*pi*(rhobvalue*c**2+ievalue+pvalue+bgauss**2/(4*pi)))
		    #
		    set rhobvalue=ti*0+1
		    set bsq=sigma*8*pi*rhobvalue
		    #
		    set va=sqrt(bsq/(bsq+rhobvalue))
		    #
		    # S = Lva/eta -> eta = va/S
		    #set eta=va/S
		    # d = sqrt(eta L/va) = sqrt(1/S)
		    set simpled=1/sqrt(S)/(0.6)/0.991
		    set simplevr=va/sqrt(S)/5.94609
                    #
                    #
                    # set gamma^2 = 1/sqrt(1-(v/c)^2) = \sqrt{1+u^2}
                    set gammax=sqrt(1+ux**2)
                    set gammay=sqrt(1+uy**2)
                    set vx=ux/gammax
                    set vy=uy/gammay
                    #
		    #
		#
addcolumn 0     #head -1 spdata_100._100._1.e-10_1.e10_100._1.e15.dat | wc
		# 28 columns
		awk '{ for (x=1;x<=4;x++) { printf "%s ", $x}} {printf "0 "} {for (x=5;x<=28;x++) { printf "%s ", $x}}  {printf "\n"}' spdata_100._100._1.e-10_1.e10_100._1.e15.dat > test.dat
		#
showsharp0 0     #
		set sharp = (150*sigma>S**(1/4) ? 1 : 0)
		plc 0 sharp 010
		#
showsharp1 0    #
		#
		set sharp = (8*sigma>S**(3/5) ? 1 : 0)
		#set sharp = (10*sigma>S**(1/2) ? 1 : 0)
		#set sharp = (1*sigma>S**(1/3) ? 1 : 0)
		plc 0 sharp 010
		#
		#
showsharps 0    #
		showsharp0
		showsharp1
		#
		#signtouse = {-1, 1, 1, -1, 1, 1, 1, -1};
		#signtouse = {1, -1, -1, -1, -1, -1, -1, 1}; for mixedrel upper sigma
		#drat uxrat rhocrat iecrat rhooutrat ieoutrat Bxrat uyrat
showit 2        #
		# showit <whichvar #> <whichrel: 0=nonrel 1=mixedrel>
		# showit 1 0
		# showit 4 0
		#
		#plc 0 (LG(-1*(drat-1))) 001 1E2 1E8 1 1E3
		#
		define POSCONTCOLOR default
		define NEGCONTCOLOR default
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
                showdata $1 $2 0
		#
		showcutsswaths
		#
                # for image cursor:
		define POSCONTCOLOR default
		define NEGCONTCOLOR default
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
                showdata $1 $2 1
                #
		#
showcutsswaths 0 #
                #
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR cyan
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		showsharps
                #
		define POSCONTCOLOR green
		define NEGCONTCOLOR green
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		setswath0
		plc 0 swath0 010
                #
		define POSCONTCOLOR magenta
		define NEGCONTCOLOR magenta
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		setswath1
		plc 0 swath1 010
                #
		define POSCONTCOLOR yellow
		define NEGCONTCOLOR yellow
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		setswathbadbottom
		plc 0 swathbottom 010
                #
		define POSCONTCOLOR blue
		define NEGCONTCOLOR blue
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		setswathbadtop
		plc 0 swathtop 010
                #
		define POSCONTCOLOR red
		define NEGCONTCOLOR red
		define BOXCOLOR default
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		setswathbadmiddlenonrel
		plc 0 swathmiddlenonrel 010
		#
		#
showdata 3      #
		if($2==0){ showdatanonrel $1 $3}
		if($2==1){ showdatamixed  $1 $3}
		#
		#
showdatanonrel 2      # sign for "d" only valid for sigma>0.5 and outside small S - high \sigma wedge
		if($2==0){ define overlayit (000) }
		if($2==1){ define overlayit (010) }
		#
		if($1==1){ plc 0 (LG(1E-15+ABS(-1*(drat-1)))) $overlayit}
		if($1==2){ plc 0 (LG(1E-15+ABS(+1*(uxrat-1)))) $overlayit }
		if($1==3){ plc 0 (LG(1E-15+ABS(+1*(rhocrat-1)))) $overlayit}
		if($1==4){ plc 0 (LG(1E-15+ABS(-1*(iecrat-1)))) $overlayit}
		if($1==5){ plc 0 (LG(1E-15+ABS(+1*(rhooutrat-1)))) $overlayit}
		if($1==6){ plc 0 (LG(1E-15+ABS(+1*(ieoutrat-1)))) $overlayit}
		if($1==7){ plc 0 (LG(1E-15+ABS(+1*(Bxrat-1)))) $overlayit}
		if($1==8){ plc 0 (LG(1E-15+ABS(-1*(uyrat-1)))) $overlayit}
               #
               #
showdatamixed 2      #
		if($2==0){ define overlayit (000) }
		if($2==1){ define overlayit (010) }
		#
		if($1==1){ plc 0 (LG(1E-15+ABS(+1*(dmrat-1)))) $overlayit}
		if($1==2){ plc 0 (LG(1E-15+ABS(+1*(uxmrat-1)))) $overlayit }
		if($1==3){ plc 0 (LG(1E-15+ABS(+1*(rhocmrat-1)))) $overlayit}
		if($1==4){ plc 0 (LG(1E-15+ABS(-1*(iecmrat-1)))) $overlayit}
		if($1==5){ plc 0 (LG(1E-15+ABS(+1*(rhooutmrat-1)))) $overlayit}
		if($1==6){ plc 0 (LG(1E-15+ABS(+1*(ieoutmrat-1)))) $overlayit}
		if($1==7){ plc 0 (LG(1E-15+ABS(+1*(Bxmrat-1)))) $overlayit}
		if($1==8){ plc 0 (LG(1E-15+ABS(-1*(uymrat-1)))) $overlayit}
               #
               #
setswath0old 0    #
		set swath0a = (100*(4)*sigma>S**((1/4+3/5)/2) && 100*(1/1.5)*sigma<S**(3/5) ? 1 : 0)
		#set swath0b = (sigma<0.01 && sigma>1E-7 && 1*sigma>S**(-1) ? 1 : 0)
		set swath0b = (sigma<0.1 && sigma>1E-7 && (1/10)*sigma>S**(-1) && (1/1000)*sigma<S**(-1) ? 1 : 0)
		#
		#
		set swath0=swath0a+swath0b
		#
setswath0   0   #
		#set swath0a = (100*(4)*sigma>S**((1/4+3/5)/2) && 100*(1/1.5)*sigma<S**(3/5) ? 1 : 0)
		set swath0 = ((1/10)*sigma>S**(-1) && 100*(1/1.5)*sigma<S**(3/5) ? 1 : 0)
		#
                #
setswath1 0    #
		# what's beyond swath0
		set swath1 = (sigma<1E3 &&  100*(1/1.5)*sigma>S**(3/5) ? 1 : 0)
		#
setswathbadbottom 0    #
		# for non-rel ratio for bad region
		set swathbottom = (error==0 && 0.5*sigma>S**(-1) && sigma<0.01 ? 1 : 0)
		#
setswathbadmiddlenonrel 0    #
		# for both non-rel and mixedrel ratio for bad region in middle
		set swathmiddlenonrel=(error==0 && 0.5*sigma>S**(-1) & sigma>=0.001 && sigma<10 ? 1 : 0)
		#
setswathbadtop 0    #
		# for mixed ratio for bad region
		set swathtop = (error==0 && 1E4*sigma<S**(4/5) && sigma>=0.5 ? 1 : 0)
		#
setcut0  0     #
		#set cut0 = (1*sigma>S**(3/5) ? 1 : 0)
		#set cut0 = (10*sigma>S**(4/5) ? 1 : 0)
		#set cut0 = (150*sigma>S**(1/4) ? 1 : 0)
		#set cut0 = (100*sigma>S**((1/4+3/5)/2) ? 1 : 0)
showcut0 0     #
		set cut0 = (50*sigma>S**(4/5) ? 1 : 0) plc 0 cut0 010
		#
		#set cut1 = (10*sigma>S**(1) ? 1 : 0) plc 0 cut1 010
		#
		#set cut1 = (45*sigma>S**(1) ? 1 : 0) plc 0 cut1 010
		#
		#set cut2 = (10*sigma>S**(6/4) ? 1 : 0) plc 0 cut2 010
		#
		#set cut3 = (2*sigma>S**(3/5) ? 1 : 0) plc 0 cut3 010
		#
		#set cut3 = (8*sigma>S**(3/5) ? 1 : 0) plc 0 cut3 010
		#
		set cut3 = (10*sigma>S**(3/2) ? 1 : 0) plc 0 cut3 010
                #
showcut1 0    #
		#
		#set cut1 = (8*sigma>S**(3/5) ? 1 : 0)
		#set cut1 = (10*sigma>S**(1/2) ? 1 : 0)
		#set cut1 = (1*sigma>S**(1/3) ? 1 : 0)
		#plc 0 cut1 010
		#
lucut1 0        #                
		#
		set cut3 = (sigma>S ? 1 : 0) plc 0 cut3 010
                #
                #
showcuts 0    #
		showcut0
		showcut1
		#
setupget 1      # produces same final variable names (not rat and mrat) for easy output
		#
		if($1==0){\
		#
		set myti=ti if(myuse)
		set mytj=tj if(myuse)
		set myS=S if(myuse)
		set mysigma=sigma if(myuse)
		set mydrat=drat if(myuse)
		set myuxrat=uxrat if(myuse)
		set myrhocrat=rhocrat if(myuse)
		set myiecrat=iecrat if(myuse)
		set myrhooutrat=rhooutrat if(myuse)
		set myieoutrat=ieoutrat if(myuse)
		set myBxrat=Bxrat if(myuse)
		set myuyrat=uyrat if(myuse)
		#
		set mmydrat=mydrat-1
		set mmyuxrat=myuxrat-1
		set mmyrhocrat=myrhocrat-1
		set mmyiecrat=myiecrat-1
		set mmyrhooutrat=myrhooutrat-1
		set mmyieoutrat=myieoutrat-1
		set mmyBxrat=myBxrat-1
		set mmyuyrat=myuyrat-1
		#
		}
		#
		if($1==1){\
		#
		set myti=ti if(myuse)
		set mytj=tj if(myuse)
		set myS=S if(myuse)
		set mysigma=sigma if(myuse)
		set mydrat=dmrat if(myuse)
		set myuxrat=uxmrat if(myuse)
		set myrhocrat=rhocmrat if(myuse)
		set myiecrat=iecmrat if(myuse)
		set myrhooutrat=rhooutmrat if(myuse)
		set myieoutrat=ieoutmrat if(myuse)
		set myBxrat=Bxmrat if(myuse)
		set myuyrat=uymrat if(myuse)
		#
		set mmydrat=mydrat-1
		set mmyuxrat=myuxrat-1
		set mmyrhocrat=myrhocrat-1
		set mmyiecrat=myiecrat-1
		set mmyrhooutrat=myrhooutrat-1
		set mmyieoutrat=myieoutrat-1
		set mmyBxrat=myBxrat-1
		set mmyuyrat=myuyrat-1
		#
		}
		#
		#
		#
getit1 1        #		
		# CHOOSE FOR WHICH CUT FITTING
		#
		set sss=''
		#
                if($1==1){\
                  setswath0
		  set myuse=swath0
  		  setupget 0
		  define name "cut1nonrel"
		  print data.$name.dat 'indatacut1nonrel=' {sss}
		}
		#
                if($1==2){\
		  setswath1
		  set myuse=swath1
  		  setupget 0
		  define name "cut2nonrel"
		  print data.$name.dat 'indatacut2nonrel=' {sss}
                }
		#
                if($1==3){\
                  setswathbadbottom
		  set myuse=swathbottom
  		  setupget 0
		  define name "cut3nonrel"
		  print data.$name.dat 'indatacut3nonrel=' {sss}
		}
		#
                if($1==4){\
                  setswathbadtop
		  set myuse=swathtop
  		  setupget 1
		  define name "cut1mixedrel"
		  print data.$name.dat 'indatacut1mixedrel=' {sss}
		}
		#
                if($1==5){\
                  setswathbadmiddlenonrel
		  set myuse=swathmiddlenonrel
  		  setupget 0
		  define name "cut4nonrel"
		  print data.$name.dat 'indatacut4nonrel=' {sss}
		}
		#
		define print_noheader 1
		print + data.$name.dat '{' {sss}
		#
		print + data.$name.dat '{%21.15g, %21.15g, %21.15g, %21.15g, %21.15g, %21.15g, %21.15g, %21.15g, %21.15g, %21.15g, %21.15g, %21.15g},' \
		    {myti mytj myS mysigma mmydrat mmyuxrat mmyrhocrat mmyiecrat mmyrhooutrat mmyieoutrat mmyBxrat mmyuyrat}
		print + data.$name.dat '};' {sss}
		#
		! sh sci2mma data.$name.dat
		! mv data.$name.dat data.$name.dat.backup
		! sed 's/},};/}};/g' data.$name.dat.backup > data.$name.dat
		! rm -rf data.$name.dat.backup
		#
		#
		#
		#
		#
		###############################################
		#
		# OLD FITTING STUFF BELOW -- now using mathematica
		#
		###############################################
		#
tryfits1  0     #
		#
		# lower by sigma/2
		define x1label "\sigma"
		define x2label "mydrat"
		ctype default pl 0 mysigma mydrat 1100
		ctype red points (LG(mysigma)) (LG(mydrat))
		set fit=1/(1+(mysigma)**(2/5))**(1/3)
		ctype red pl 0 mysigma fit 1110
		#
		
		#
tryfits0   0    #		
		#
		# lower by sigma/2
		define x1label "\sigma"
		define x2label "mydrat"
		ctype default pl 0 mysigma mydrat 1100
		ctype red points (LG(mysigma)) (LG(mydrat))
		set fit=1/(1+(mysigma)**(2/5))**(1/3)
		ctype red pl 0 mysigma fit 1110
		#
		# higher by bit
		ctype default pl 0 mysigma myuxrat 1100
		ctype red points (LG(mysigma)) (LG(myuxrat))
		set fit=0
		#
		# higher by sigma/2
		ctype default pl 0 mysigma myrhocrat 1100
		ctype red points (LG(mysigma)) (LG(myrhocrat))
		set fit=0
		#
		# bit lower
		ctype default pl 0 mysigma myiecrat 1100
		ctype red points (LG(mysigma)) (LG(myiecrat))
		set fit=0
		#
		# higher by \sigma/5
		ctype default pl 0 mysigma (myrhooutrat-1) 1100
		ctype red points (LG(mysigma)) (LG(myrhooutrat-1))
		set lfit1=(lg(mysigma)- (-2.57538))*(1.0) -2.12698
		set fit1=10**lfit1
		set lfit2=(lg(mysigma)- (1.08423))*(0.53) +0.58847
		set fit2=10**lfit2
		set npow=2
		set fit=(1/(1/fit1**npow+1/fit2**npow))**(1/npow)
		#
		ctype red pl 0 mysigma fit 1110
		ctype green pl 0 mysigma fit1 1110
		ctype blue pl 0 mysigma fit2 1110
		#
		#
		ctype default pl 0 mysigma myieoutrat 1100
		ctype red points (LG(mysigma)) (LG(myieoutrat))
		set fit=(1+7.0*mysigma**(spow/npow))**npow
		ctype red pl 0 mysigma fit 1110
		#
		#
		# higher by ~sigma
		ctype default pl 0 mysigma myBxrat 1100
		ctype red points (LG(mysigma)) (LG(myBxrat))
		set fit=0
		#set npow=2/5
		#set fit=(1+(mysigma)**(2/5/npow))**npow
		set fit=1+mysigma**(3/5)
		set fit=exp(mysigma)
		set npow=0.54
		set spow=0.54
		set fit=(1+7.0*mysigma**(spow/npow))**npow
		set fit=(1+(mysigma*7.0)**(spow/npow))**npow
		#set fit=1+mysigma**spow
		ctype red pl 0 mysigma fit 1110
		set fit=1+ 1.8*mysigma**0.7
                ctype green pl 0 mysigma fit 1110
		#
		# lower
	        ctype default pl 0 mysigma myuyrat 1100
		ctype red points (LG(mysigma)) (LG(myuyrat))
		set fit=0
		set fit=1/(1+7.0*mysigma**(spow/npow))**npow
		ctype red pl 0 mysigma fit 1110
		#
		#		
		#

