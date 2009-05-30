 # comp zones only
 # if((k>=0)&&(k<$nz-4)&&(j>=0)&&(j<$ny-4)&&(i>=0)&&(i<$nx-4))
 # all zones
 # if((k>=-2)&&(k<$nz-2)&&(j>=-2)&&(j<$ny-2)&&(i>=-2)&&(i<$nx-2))
 # cut through E0,2,8,10
 # E8,E10
 # if((k>=5)&&(k<$nz-2)&&(j>=-2)&&(j<$ny-2)&&(i>=5)&&(i<$nx-7))
 # E0,E2
 # if((k>=-2)&&(k<$nz-7)&&(j>=-2)&&(j<$ny-2)&&(i>=5)&&(i<$nx-7))
 # cut through E4,5,6,7
 # if((k>=5)&&(k<$nz-7)&&(j>=-2)&&(j<$ny-2)&&(i>=-2)&&(i<$nx-2))
 #
 # if((k>=-2)&&(k<$nz-2)&&(j==$ny/3)&&(i>=-2)&&(i<$nx-2))
 # cut through E3,1,11,9
 # if((k>=-2)&&(k<$nz-2)&&(j>=7)&&(j<=$ny-9)&&(i>=-2)&&(i<$nx-2))
 #
 # if((k==-2)&&(j==$ny/3)&&(i>=-2)&&(i<$nx-2))
 # see other macros: ~/sm/smstart
 #                   /usr/local/lib/sm/macro
 # typical start call:
 # re twod.m gpa 0 rdraft
 # if using older no-ver/type files, then specify type/version manually.
 # define grandpa 1
 # e.g.:
 # define fileversion 1
 # define filetype 3
 #
 #// file versions numbers(use sm for backwards compat)
 #define PVER 6
 #define GRIDVER 2
 #define DVER 1    // dumps same as for pdumps, adumps
 #define FLVER 2
 #define NPVER 2
 #define AVG1DVER 2
 #define AVG2DVER 2
 #define ENERVER 5
 #define LOSSVER 5
 #define SPVER   1
 #define TSVER   1
 #define LOGDTVER 1
 #define STEPVER 1
 #define PERFVER 3
 #define ADVER DVER
 #define PDVER DVER
 #define CALCVER 1
 #// type designations for sm automagical read in correct format for similar things
 #define PTYPE     1 // global par file
 #define GRIDTYPE  2
 #define DTYPE     3 // dump
 #define FLTYPE    4 // floor
 #define NPTYPE    5 // np
 #define AVG2DTYPE 6
 #define AVG1DTYPE 7
 #define ENERTYPE  8
 #define LOSSTYPE  9
 #define SPTYPE    10
 #define TSTYPE    11
 #define LOGDTTYPE 12 
 #define STEPTYPE  13
 #define PERFTYPE  14
 #define ADTYPE    15 // same as dump except filename
 #define PDTYPE    16 // same as dump except filename
 #define CALCTYPE  17 // arbitrary calcs during pp
 #define EXPANDTYPE 50 // used to signify doing pp expansion
 #define NPCOMPUTETYPE 33 // used to signify want to compute np before output
 #
 # ctype default rd dump0001.dat 0 rd adump0001.dat 2 set vxdiff=v0x-v2x pllim 0 x1 vxdiff 150 1100 -1E-10 1E-10
 # ctype red rd dump0001.dat 0 rd adump0001.dat 2 set vxdiff=v0x-v2x plo 0 x1 vxdiff
 # ctype blue rd dump0001.dat 0 rd adump0001.dat 2 set vxdiff=v0x-v2x plo 0 x1 vxdiff
 # ctype green rd dump0001.dat 0 rd adump0001.dat 2 set vxdiff=v0x-v2x plo 0 x1 vxdiff
 # ctype cyan rd dump0001.dat 0 rd adump0001.dat 2 set vxdiff=v0x-v2x plo 0 x1 vxdiff
                   #xla $2
                   #yla $3
                   # relocate (15000 31500)
                   # cp *.m /us1/jon/ndata25
                   # rd /us1/jon/ndata25/0_loss.dat
                   # der t min1 tdn25 min1dn25
                   # ctype blue plo null tdn25 min1dn25
                   # ctype red plo null tdn16 (mx3in1dn16/min1dn16)
                   # relocate (15000 31500)
                   # ctype default label n17 n16 n25 \dot{M}(t)
                   # device postencap /us1/jon/compare/dot/n17n16n25mdot.eps
                   # device postscript
                   # define interp (0) set _gam=(5/3) define gam (_gam) set wgam=1
                   # label n17 n16 n25 \dot{M}(t)
                   #label Mass Accretion rate vs. time
                   #xla tc^3/GM
                   #xla freq GM/c^3
  		   #yla \dot{M}/\dot{M}_{inj}
                   #yla (M/M_{inj})^2
		   #yla \dot{M}_{in} \rho_0 R_0^3 c^3/GM
                   # cp *.m /us1/jon/f8
                   # cat /us1/jon/f8/0_numdumps.dat
                   # device postencap /us1/jon/compare/n28rho.eps
                   # device postscript
                   #
                   #label Power Spectrum of \dot{M_{in}}/\dot{M_{inj}}
                   #label Power Spectrum of \dot{M_{in}}
                   #xla t*GM/c^3
                   #xla Frequency*c^3/GM
                   #yla \dot{M_{in}}/\dot{M_{inj}}
                   #yla Power*(c^2/GM)^2
                   #yla \dot{M_{in}} \rho_0 R_0^3
                   #xla $2
                   #yla $3
                   #
                #lweight 2
                #limits 0 23.1 -23.1 23.1
                #xla Rc^2/GM
                #yla zc^2/GM
                #yla \theta
                #
		#read {x 1 y 2 r 3}
                # ticksize -1 0 0 0
                # device postencap /us1/jon/compare/a1all/1d/r1d1.eps
                # pl 0 x2 en1d1
                # pl 0 (LG(x1)) en1d1
                # relocate (10383 31500) label \rho(\theta)
                # device X11
                #
                # global test functions for injection runs:
                # derived from r=1.05rg..20rg injection runs on alphadog/wiseguy
                # set testrho=exp(-(x2-3.14159*0.5)**2/(0.4**2))*0.012*(x1-2)**(.4)
                # K=en/rho^gam
                # set test1ok=exp(-(x2-3.14159*0.5)**2/(0.5**2))*2.33*(x1-2)**(.51)
                # solve this for en
                # set testen=(1/test1ok)*testrho**($gam)
                # set testvx=-(-.56*LG(x1-2)+.87)**(1/0.25)

                # set testvy=.6*sin(((x2-0.2)/2.75)*2*3.14159)*(-0.4*(LG((x1-2)/(17))))
                # set testvz=(-.6*LG(x1-2)+1.06)*exp(-(x2-3.14159*0.5)**2/(0.7**2))
                
                # set testvz = 1.2512*(x1-2)**(-.571305)*exp(-(x2-3.14159*0.5)**2/(0.7**2))


                #device postencap god.eps
                #device ppm filename.ppm
drawmline  4      #
                  lweight $PLOTLWEIGHT
                  relocate ($1 $2)
                  set _temp1x=$1+(($3-$1)/4)
                  set _temp2x=$1+2*(($3-$1)/4)
                  set _temp3x=$1+3*(($3-$1)/4)
                  set _temp4x=$1+4*(($3-$1)/4)
                  define temp1x (_temp1x) 
                  define temp2x (_temp2x) 
                  define temp3x (_temp3x) 
                  define temp4x (_temp4x) 
                  set _temp1y=$2+(($4-$2)/4)
                  set _temp2y=$2+2*(($4-$2)/4)
                  set _temp3y=$2+3*(($4-$2)/4)
                  set _temp4y=$2+4*(($4-$2)/4)
                  define temp1y (_temp1y) 
                  define temp2y (_temp2y) 
                  define temp3y (_temp3y) 
                  define temp4y (_temp4y) 
                  draw ( $temp1x $temp1y )
                  draw ( $temp2x $temp2y )
                  draw ( $temp3x $temp3y )
                  draw ( $temp4x $temp4y )
                  lweight $NORMLWEIGHT
                  #
mylegend   4      # (e.g. mylegend 3 a01 a02 a03)
                  define legendtype (1)
                  if($1>=1){\
		   if($legendtype==1){\
                    relocate (7500 29000)
                    label $2
                    ltype 0
                    drawmline 10000 29400 11000 29400
		   }
		   if($legendtype==2){\
                    relocate (10000 24000)
                    label $2
		   }
		  }
                  if($1>=2){\
		   if($legendtype==1){\
                    relocate (7500 28000)
                    label $3
                    ltype 3
                    drawmline 10000 28400 11000 28400
		   }
		   if($legendtype==2){\
                    relocate (23000 11000)
                    label $3
		   }
		  }
                  if($1>=3){\
		   if($legendtype==1){\
                    relocate (7500 27000)
                    label $4
                    ltype 4
                    drawmline 10000 27400 11000 27400
		   }
		   if($legendtype==2){\
                    relocate (10000 11500)
                    label $4
		   }
		  }
                  #
speclim1   2      #
                  erase
                  limits $1 $2
                  box
                  #
speclim2   4      #
                  erase
                  limits $1 $2 $3 $4
                  box
                  #
justpllim  6      # just plot (e.g. justpllim 2 a01 a02 0 a01 a01)
                  mdotpl $1 $2 $3 $4 $5 $6
                  emdotpl $1 $2 $3 $4 $5 $6
                  mx3mdotpl $1 $2 $3 $4 $5 $6
                  #                  
dotalllim  6      # do full dot stuff (e.g. dotalllim 2 a01 a02 0 a01 a01)
                  set goldentemp=0
                  dotdo $1 $2 $3 $4
                  justpllim $1 $2 $3 $4 $5 $6
setlim     8      # set limits for dotallslim
                  # <tl,th,mdotlmdoth,emdotl,emdoth,mx3mdotl,mx3mdoth>
                  set lim=0,7,1
                  set lim[0]=$1
                  set lim[1]=$2
                  set lim[2]=$3
                  set lim[3]=$4
                  set lim[4]=$5
                  set lim[5]=$6
                  set lim[6]=$7
                  set lim[7]=$8
                  #
justplslim  4     # just plot (e.g. justplslim 2 a01 a02 0)
                  set goldentemp=1  # passed var
                  set tlim=0,1,1
                  set mlim=0,1,1
                  set emlim=0,1,1
                  set mx3mlim=0,1,1
                  set tlim[0]=lim[0]
                  set tlim[1]=lim[1]
                  set mlim[0]=lim[2]
                  set mlim[1]=lim[3]
                  set emlim[0]=lim[4]
                  set emlim[1]=lim[5]
                  set mx3mlim[0]=lim[6]
                  set mx3mlim[1]=lim[7]
                  mdotpl $1 $2 $3 $4 tlim mlim 
                  emdotpl $1 $2 $3 $4 tlim emlim
                  mx3mdotpl $1 $2 $3 $4 tlim mx3mlim
                  set goldentemp=0
                  #
dotallslim 4      # do full dot stuff (e.g. dotalllim1 2 a01 a02 0
                  # assumes lim[8] is set with limits
                  dotdo $1 $2 $3 $4
                  justplslim $1 $2 $3 $4
                  #
justpl    4       # just plot (e.g. justpl 2 a01 a02 0)
                  set goldentemp=0
                  mdotpl $1 $2 $3 $4 $2 $2
                  emdotpl $1 $2 $3 $4 $2 $2
                  mx3mdotpl $1 $2 $3 $4 $2 $2
                  #
dotall     4      # do full dot stuff (e.g. dotall 2 a01 a02 0)
                  # limits based upon first entry for both x/y
                  set goldentemp=0
                  dotdo $1 $2 $3 $4
                  justpl $1 $2 $3 $4
                  #
redloss    0      # reduce mdot/edot/mx3dot to managable size
                  define AUTOREDUCE (500)
                  # autoreduce size to 5000 points max
                  set lossdimen=INT(dimen(t)/$AUTOREDUCE)
                  if(lossdimen>1){\
                        set factor=lossdimen
                        reduce t min1 tr min1r factor
                        reduce t ein1 tr ein1r factor
                        reduce t mx3in1 tr mx3in1r factor
                  }\
                  else{\
                        set min1r=min1
                        set ein1r=ein1
                        set mx3in1r=mx3in1
                        set tr=t
                  }
                  #
dotdo     4       # upto 3 compares
                  # (e.g. dotdo 2 a01 a02 0)
                  # (e.g. dotdo 3 a01 a02 a03)
                   if($1>=1){\
                     rd /us1/jon/$2/0_loss.dat
                     redloss
                     der tr min1r td$2 min1d$2
                     der tr ein1r td$2 ein1d$2
                     der tr mx3in1r td$2 mx3in1d$2
                   }
                   if($1>=2){\
                     rd /us1/jon/$3/0_loss.dat
                     redloss
                     der tr min1r td$3 min1d$3
                     der tr ein1r td$3 ein1d$3
                     der tr mx3in1r td$3 mx3in1d$3
                   }
                   if($1>=3){\
                     rd /us1/jon/$4/0_loss.dat
                     redloss
                     der tr min1r td$4 min1d$4
                     der tr ein1r td$4 ein1d$4
                     der tr mx3in1r td$4 mx3in1d$4
                   }
                   #
mdotpl     6       # upto 3 compares
                   do kk=0,10,1{
                    set min1da06[$kk]=min1da06[11]
                   }
		   if($ploverlay==0){\
                     LOCATION 5000 31000 3500 31000
		   }
                   # (e.g. mdotpl 3 a01 a02 a03 a01 a02)
                   define CONVT1 (1)
                   #define CONVT1 (7960)
                   define CONVT2 (1)
                   #define CONVT2 (7960)
                   define CONVT3 (1)
                   #                   
                   #define CONV1 (8040.2)
                   define CONV1 (1)
                   #define CONV2 (8040.2)
                   define CONV2 (1)
                   define CONV3 (1)
                   do kk=0,$PRINTTO,1{
		      if($ploverlay==0){\
                    if($kk==1){\
                     if($1==1){\
                       device postencap /us1/jon/compare/dot/$2mdot.eps
                     }
                     if($1==2){\
                       device postencap /us1/jon/compare/dot/$2$3mdot.eps
                     }
                     if($1==3){\
                       device postencap /us1/jon/compare/dot/$2$3$4mdot.eps
                     }
                    }
                    ctype default
                    if(goldentemp==1){\
		           speclim1 $5 $6
                    }\
                    else{\
    	              if('$5'=='$2'){ define CTL ($CONVT1) }
                      if('$5'=='$3'){ define CTL ($CONVT2) }
                      if('$5'=='$4'){ define CTL ($CONVT3) }
                      if('$6'=='$2'){ define CFL ($CONV1) }
                      if('$6'=='$3'){ define CFL ($CONV2) }
                      if('$6'=='$4'){ define CFL ($CONV3) }
                      speclim1 ($CTL*td$5) ($CFL*min1d$6)
                    }
                    # new units
		           xla t c^3/GM
		           # new units injection
		           yla \dot{M}/\dot{M}_{inj}
                    if(!($finaldraft)){\
                     relocate (15000 31500)
                     if($1==1){\
                        ctype default label $2 \dot{M}/\dot{M}_{inj}
                     }
                     if($1==2){\
                        ctype default label $2 $3 \dot{M}/\dot{M}_{inj}
                     }
                     if($1==3){\
                        ctype default label $2 $3 $4 \dot{M}/\dot{M}_{inj}
                     }
		    }\
                    else{\
		            if($ploverlay==0){\
		            mylegend $1 $2 $3 $4
		         }
		    }
		 }
                    if($1>=1){\
		       plottype 1 $2
                       plo 0 ($CONVT1*td$2) ($CONV1*min1d$2)
                    }
                    if($1>=2){\
		       plottype 2 $3
                       plo 0 ($CONVT2*td$3) ($CONV2*min1d$3)
                    }
                    if($1>=3){\
		       plottype 3 $4
                       plo 0 ($CONVT3*td$4) ($CONV3*min1d$4)
                    }
                    if($kk==1){\
                     device X11
                    }
		   
                   }
emdotpl    6       # upto 3 compares
                   do kk=0,20,1{
                    set ein1da06[$kk]=ein1da06[21]
                    #set ein1da02[$kk]=ein1da02[21]
                   }
                   define CONVT1 (1)
                   #define CONVT1 (7960)
                   define CONVT2 (1)
                   #define CONVT2 (7960)
                   define CONVT3 (1)
                   define CONV1 (1)
                   #define CONV1 (.00252519)
                   define CONV2 (1)
                   #define CONV2 (.00252519)
                   define CONV3 (1)
                   do kk=0,$PRINTTO,1{
		      if($ploverlay==0){\

                    if($kk==1){\
                     if($1==1){\
                       device postencap /us1/jon/compare/dot/$2emdot.eps
                     }
                     if($1==2){\
                       device postencap /us1/jon/compare/dot/$2$3emdot.eps
                     }
                     if($1==3){\
                       device postencap /us1/jon/compare/dot/$2$3$4emdot.eps
                     }
                    }
                    ctype default
                    if(goldentemp==1){\
                      speclim1 $5 $6
                    }\
                    else{\
                      if('$5'=='$2'){ define CTL ($CONVT1) }
                      if('$5'=='$3'){ define CTL ($CONVT2) }
                      if('$5'=='$4'){ define CTL ($CONVT3) }
                      if('$6'=='$2'){ define CFL ($CONV1) }
                      if('$6'=='$3'){ define CFL ($CONV2) }
                      if('$6'=='$4'){ define CFL ($CONV3) }
                      speclim1 ($CTL*td$5) ($CFL*ein1d$6/min1d$6)
                    }
		 
                    # new units
                    xla t c^3/GM
                    # new units injection
                    yla \dot{E}/(\dot{M}c^2)
		 
                    if(!($finaldraft)){\
                     relocate (15000 31500)
                     if($1==1){\
                        ctype default label $2 \dot{E}/\dot{M}/c^2
                     }
                     if($1==2){\
                        ctype default label $2 $3 \dot{E}/\dot{M}/c^2
                     }
                     if($1==3){\
                        ctype default label $2 $3 $4 \dot{E}/\dot{M}/c^2
                     }
		    }\
                    else{\
                     mylegend $1 $2 $3 $4
		    }
		   }
                    if($1>=1){\
		     plottype 1 $2
		     plo 0 ($CONVT1*td$2) ($CONV1*ein1d$2/min1d$2)
                    }
                    if($1>=2){\
		       plottype 2 $3
                       plo 0 ($CONVT2*td$3) ($CONV2*ein1d$3/min1d$3)
                    }
                    if($1>=3){\
		       plottype 3 $4
                       plo 0 ($CONVT3*td$4) ($CONV3*ein1d$4/min1d$4)
                    }
                    if($kk==1){\
                     device X11
                    }
                   }
mx3mdotpl    6       # upto 3 compares
                   do kk=0,10,1{
                    set mx3in1da06[$kk]=mx3in1da06[11]
                   }
                   define CONVT1 (1)
                   #define CONVT1 (7960)
                   define CONVT2 (1)
                   #define CONVT2 (7960)
                   define CONVT3 (1)
                   define CONV1 (1)
                   #define CONV1 (20.1005)
                   define CONV2 (1)
                   #define CONV2 (20.1005)
                   define CONV3 (1)
                   do kk=0,$PRINTTO,1{
		   if($ploverlay==0){\
                    if($kk==1){\
                     if($1==1){\
                       device postencap /us1/jon/compare/dot/$2mx3mdot.eps
                     }
                     if($1==2){\
                       device postencap /us1/jon/compare/dot/$2$3mx3mdot.eps
                     }
                     if($1==3){\
                       device postencap /us1/jon/compare/dot/$2$3$4mx3mdot.eps
                     }
                    }
                    ctype default
                    if(goldentemp==1){\
                      speclim1 $5 $6
                    }\
                    else{\
                      if('$5'=='$2'){ define CTL ($CONVT1) }
                      if('$5'=='$3'){ define CTL ($CONVT2) }
                      if('$5'=='$4'){ define CTL ($CONVT3) }
                      if('$6'=='$2'){ define CFL ($CONV1) }
                      if('$6'=='$3'){ define CFL ($CONV2) }
                      if('$6'=='$4'){ define CFL ($CONV3) }
                      speclim1 ($CTL*td$5) ($CFL*mx3in1d$6/min1d$6)
                    }
                    # new units
                    xla t c^3/GM
                    # new units injection
                    yla (\dot{L}/\dot{M})(c/GM)
                    if(!($finaldraft)){\
                     relocate (15000 31500)
                     if($1==1){\
                        ctype default label $2 (\dot{L}/\dot{M})(c/GM)
                     }
                     if($1==2){\
                       ctype default label $2 $3 (\dot{L}/\dot{M})(c/GM)
                     }
                     if($1==3){\
                        ctype default label $2 $3 $4 (\dot{L}/\dot{M})(c/GM)
                     }
		    }\
                    else{\
                     mylegend $1 $2 $3 $4
		    }
		 }
                    if($1>=1){\
		       plottype 1 $2
                       plo 0 ($CONVT1*td$2) ($CONV1*mx3in1d$2/min1d$2)
                    }
                    if($1>=2){\
		       plottype 2 $3
                       plo 0 ($CONVT2*td$3) ($CONV2*mx3in1d$3/min1d$3)
                    }
                    if($1>=3){\
		       plottype 3 $4
                       plo 0 ($CONVT3*td$4) ($CONV3*mx3in1d$4/min1d$4)
                    }
                    if($kk==1){\
                     device X11
                    }
                   }
                   # cp *.m /us1/jon/ndata25
                   # device postscript
                   # define interp (0) set _gam=(5/3) define gam (_gam) set wgam=1
                   # label n17 n16 n25 \dot{M}(t)
                   #label Mass Accretion rate vs. time
myplotbubble 0     #
		   erase
		   device postencap /us1/jon/compare/a1all/2d/bubblecontour.eps
		   define loginterprho 1
		   define cres 20
                   define x1label "R c^2/GM"    
		   define x2label "z c^2/GM"
		   labelaxes 0
		   limits x12 x22
		   mybox2d
		   plc 0 lr 010
		   define loginterprho 0
		   set itx=Fmdx*(x12*x12+x22*x22)
		   set ity=Fmdy*(x12*x12+x22*x22)
		   vplp 0 it 50 4 010
		   device X11
myplotdo1   0      # 4-panel 2D average plot
		   set _mag=0
		   set _fullvec=0
		   set _coord=1
		   define coord (1)
		   define npdone (1)
                   rdbasic 1 0 -1
                   rd idump0090.dat # gives interp pot
                   rd i0_avg2d.dat # gives interp avg prim vars + sig's
                   rd icdump.dat # take interp'ed avg2d -> fluxes 		   
myplot1   0        # THE 4-panel 2D average plot
		   plc 0 r 001 0 29 -14.5 14.5
		   #plc 0 r
		   fdraft
                   window 1 1 1 1
                   notation -4 4 -4 4
                   #myplotdo1
                   erase
                   #now setup
                   device postencap /us1/jon/4panel.eps
                   window -2 -2 1 2 box 0 2 0 0
                   yla z c^2/GM
		   set lr=LG(r)
		   define cres 20
		   define loginterprho 1
                   plc 0 lr 010
		   define loginterprho 0
                   window -2 -2 2 2 box 0 0 0 0
		   define cres 50
                   plc 0 be2d 010
                   window -2 -2 1 1 box 1 2 0 0
                   xla R c^2/GM
                   yla z c^2/GM
		   # flux density
                   #set tempx=Fmdx*(x12*x12+x22*x22)
                   #set tempy=Fmdy*(x12*x12+x22*x22)
		   set radius=sqrt(x12*x12+x22*x22)
		   set sintheta=x12/radius
                   # derivative argument
		   set tempx=Fmx*radius**2*sintheta
                   set tempy=Fmy*radius**2*sintheta
		   define SKIPFACTOR (4)
                   vpl 0 temp 50 12 010
                   window -2 -2 2 1 box 1 0 0 0
                   xla R c^2/GM
		   # argument of derivative
                   #set tempx=Lx*SQRT(x12*x12+x22*x22)
		   #set tempx=Lx*radius*radius
                   #set tempy=Ly*SQRT(x12*x12+x22*x22)
                   #set tempy=Ly*radius*radius
		   set tempx=Fvzx*radius**2*sintheta
		   set tempy=Fvzy*radius**2*sintheta
		   define SKIPFACTOR (4)
                   vpl 0 temp 200 12 010
                   device X11
                   #
myplotdo2   0      # The 3 panel d/dt stuff
  		   # so do not have to keep doing this
                   rd 0_loss.dat
                   redloss
                   der tr min1r td min1d
                   der tr ein1r td ein1d
                   der tr mx3in1r td mx3in1d
myplot2   0        # The 3 panel d/dt stuff
		   fdraft
                   ltype 0
                   window 1 1 1 1
                   notation -4 4 -4 4
                   #myplotdo2
                   erase
                   #now setup
                   device postencap /us1/jon/3dotpanel.eps
                   #
                   limits td min1d
                   window -8 -3 2:8 3 box 0 2 0 0
		   yla \dot{M}/\dot{M}_{inj}
                   plo 0 td min1d
                   #
                   set tempf=ein1d/min1d
                   limits td -.07 .005
                   #limits td tempf
                   window -8 -3 2:8 2 box 0 2 0 0
                   yla \dot{E}/(\dot{M}c^2)
		   ltype 0
                   plo 0 td tempf
		   ltype 1
                   set blah=(td+1E-6)/(td+1E-6)*(-.0625)
		   plo 0 td blah
		   relocate (25000 13800)
		   expand 1.1
                   label thin disk
		   expand 1.5
                   #
                   set tempf=mx3in1d/min1d
                   #limits td tempf
		   limits td 0 4.1
                   window -8 -3 2:8 1 box 1 2 0 0
		   yla (\dot{L}/\dot{M})(c/GM)
                   xla t c^3/GM
		   ltype 0
                   plo 0 td tempf
		   ltype 1
                   set blah=(td+1E-6)/(td+1E-6)*3.67423
		   plo 0 td blah
		   relocate (25000 11000)
		   expand 1.1
                   label thin disk
		   expand 1.5
                   device X11
                   #
myplotdo3   0      #
		   rdr
		   set _fullvec=0
		   set _coord=3
		   set _mag=0
		   define npdone (1)
                   rdbasic 0 0 -1
                   rd dump0000.dat
                   rd 0_avg1d.dat
		   rd 0_avg2d.dat
		   smstart
myplot3   0        #
		   ctype default
		   fdraft
		   ltype 0
                   window 1 1 1 1
		   ticksize -1 0 -1 0
                   #myplotdo3
                   erase
                   #now setup
                   device postencap /us1/jon/41dpanel.eps
		   #set lx1=LG(x1)
		   #set lr=LG(r)
		   #set lcs2=LG(csq1d2)
		   #set vk=SQRT(x12)/(x12-2)
		   #set vkn=SQRT(x12)/(x12)
		   #set lvzk=LG(vz/vk)
		   #set lvz=LG(vz)
		   #set lvk=LG(vk)
		   #set lvkn=LG(vkn)
		   #set lvx=LG(ABS(vx))
		   # 1D stuff broken at the time?
		   thetaphiavg PI/6 r r2davg newx1
		   thetaphiavg PI/6 csq2d cs22davg newx1
		   thetaphiavg PI/6 vx v2davgx newx1
		   set vznew=vz*x12**(1)*g42 # so power law seen better
		   thetaphiavg PI/6 vznew v2davgz newx1
		   # set r2davg=r2d
		   # set cs22davg=cs22d
		   # set v2davgx=v2dx
		   # set v2davgz=v2dz
                   notation -1 1 -1 1
                   setlimits 2.0 600 1.55 1.58 0 1
		   #
		   limits (LG(newx1)) -3.7 -2.2
		   window 30 2 2:16 2 box 1 2 0 0
		   #window 30 4 2:16 3		   
		   xla r c^2/GM
		   yla "\rho (GM)^2/(\dot{M_{inj}} c^3)"
		   #
                   #plflim 0 x1 r2davg 0 111
		   pl 0 newx1 r2davg 1110
		   # fit
		   # ctype default pl 0 newx1 r2davg 1100
		   # ctype red pl 0 newx1 (1E-2*newx1**(-.63)) 1110
		   # fix vk and vkn
                   #
                   limits (LG(newx1)) -4 -.5
                   window 30 2 16:30 2 box 1 2 0 0
		   xla r c^2/GM
		   yla (c_s/c)^2
                   #plflim 0 x1 cs22davg 0 111
		   pl 0 newx1 cs22davg 1110
		   # fit
		   #  ctype default pl 0 newx1 cs22davg 1100
		   # ctype red pl 0 newx1 (6E-1*newx1**(-1)) 1110
                   #
                   limits (LG(newx1)) 0 2
                   window 30 2 16:30 1 box 1 2 0 0
		   xla r c^2/GM
		   #yla v_{\phi}/v_k
		   yla l/(GM/c)
                   #plflim 0 x1 v2davgz 0 111
		   pl 0 newx1 v2davgz 1110
		   # fit
		   # ctype default pl 0 newx1 v2davgz 1100
		   # ctype red pl 0 newx1 (2*newx1**(-0.8)) 1110
		   set vkx1=newx1 if(newx1>6)
		   set vk=SQRT(newx1)/(newx1-2)*newx1**(1)
		   set vkn=SQRT(vkx1)/(vkx1)*vkx1**(1)
                   ltype 3
                   #plflim 0 x1 vk 0 111
		   pl 0 newx1 vk 1110
                   #ltype 4
                   #plflim 0 x1 vkn 0 111
		   #pl 0 vkx1 vkn 1110
                   ltype 0
		   #
                   limits (LG(newx1)) -3.5 0.2
                   window 30 2 2:16 1 box 1 2 0 0
		   xla r c^2/GM
		   yla |v_{r}|/c
                   #plflim 0 x1 v2davgx 0 111
		   pl 0 newx1 v2davgx 1110
                   #
		   device X11
                   #
                   #
myplotdo5 0        #
		dotdo 3 a01 a02 a06
myplot5  0         # just plot (e.g. justpllim 2 a01 a02 0 a01 a01)
		define PRINTTO 0
		  window 1 1 1 1
                  set goldentemp=1  # passed var
		  define ploverlay 1
		  setlim 0 7E5 0 .07 -.1 0 -1 3
                  set tlim=0,1,1
                  set mlim=0,1,1
                  set emlim=0,1,1
                  set mx3mlim=0,1,1
                  set tlim[0]=lim[0]
                  set tlim[1]=lim[1]
                  set mlim[0]=lim[2]
                  set mlim[1]=lim[3]
                  set emlim[0]=lim[4]
                  set emlim[1]=lim[5]
                  set mx3mlim[0]=lim[6]
                  set mx3mlim[1]=lim[7]
		  #
		  notation -2 2 -2 2
		  erase
		  device postencap /us1/jon/compare/dot/a01a02a06mdot.eps
		  limits tlim mlim
		  window -8 -2 2:8 1 box 1 2 0 0
                  mdotpl 2 a01 a02 0 tlim mlim
		  yla \dot{M}/\dot{M}_{inj}
		  xla t c^3/GM
		  window -8 -2 2:8 2 box 0 2 0 0
		  mdotpl 2 a01 a06 0 tlim mlim
		  # new units injection
		  yla \dot{M}/\dot{M}_{inj}
		  device X11
		  #
		  erase
		  device postencap /us1/jon/compare/dot/a01a02a06emdot.eps
		  limits tlim emlim
		  window -8 -2 2:8 1 box 1 2 0 0
                  emdotpl 2 a01 a02 0 tlim emlim
		  yla \dot{E}/(\dot{M}c^2)
		  xla t c^3/GM
		  window -8 -2 2:8 2 box 0 2 0 0
		  emdotpl 2 a01 a06 0 tlim emlim
		  # new units injection
		  yla \dot{E}/(\dot{M}c^2)
		  device X11
		  #
		  erase
		  device postencap /us1/jon/compare/dot/a01a02a06mx3mdot.eps
		  limits tlim mx3mlim
		  window -8 -2 2:8 1 box 1 2 0 0
                  mx3mdotpl 2 a01 a02 0 tlim mx3mlim
		  yla (\dot{L}/\dot{M})(c/GM)
		  xla t c^3/GM
		  window -8 -2 2:8 2 box 0 2 0 0
		  mx3mdotpl 2 a01 a06 0 tlim mx3mlim
		  # new units injection
		  yla (\dot{L}/\dot{M})(c/GM)
                  set goldentemp=0
		  define ploverlay 0
		  device X11
myplottest   0     #
                   window 1 1 1 1
                   #rdbasic 1 0 -1
                   #rd idump0100.dat
                   #rd i0_avg2d.dat
                   #rd icdump.dat
                   #plc 0 r
                   erase
                   #now setup
                   #device postencap /us1/jon/compare/a1all/2d/4panel.eps
                   window -2 -2 1 2 box 0 2 0 0
                   #yla z c^2/GM
                   window -2 -2 2 2 box 0 0 0 0
                   window -2 -2 1 1 box 1 2 0 0
                   #xla R c^2/GM
                   #yla z c^2/GM
                   window -2 -2 2 1 box 1 0 0 0
                   #xla R c^2/GM
                   #device X11
                   # old setlim:
                   # a01a02a06
                   # setlim 0 7E5 0 .07 -.1 0 -1 3
                   # f06f03f11
                   # setlim 0 1.2E5 0 .2 -.1 .1 -1 2
                   # n17n16n25
                   # setlim 0 1E5 0 .04 -.05 0 2 5
                   # n16f02f05
                   # setlim 0 8E5 0 .04 -.035 -.02 2.5 4
                   # n16f02f05
                   # setlim 0 8E5 0 .04 -.035 -.02 3 4
                   # n26n25
                   # setlim 0 2.6E4 0 .05 -.25 -.22 3.2 3.6
                   # n16n28n30
                   # setlim 0 1E5 .025 .045 -.035 -.01 3.3 3.6
myplotfft1   0     #
		   erase
                   device postencap /us1/jon/compare/fft/f02n23fftmdot.eps
                   limits  -5 -1 -12 -4
		   window 2 2 1:2 1
                   rd /us1/jon/n23/0_loss.dat
                   der t min1 td min1d
                   fftreallim 1 td min1d freq min1dfpow 2001 6730
                   set freq[0]=freq[1]
                   set min1dfpow[0]=min1dfpow[1]
                   set fn=freq if(freq>0)
                   set pn=min1dfpow if(freq>0)
                   set freq=fn
                   set min1dfpow=pn
                   pl 0 freq min1dfpow 1110
                   xla Hz GM/c^3
		   yla Power (\dot{M}_{inj} GM/c^3)^2
                   box 1 2 0 0
                   #
                   limits  -5 -1 -18 -9
		   window 2 2 1:2 2
                   rd /us1/jon/f02/0_loss.dat
                   der t min1 td min1d
                   fftreallim 1 td min1d freq min1dfpow 20001 118000
                   set freq[0]=freq[1]
                   set min1dfpow[0]=min1dfpow[1]
                   set fn=freq if(freq>0)
                   set pn=min1dfpow if(freq>0)
                   reduce fn pn fr pr 50
                   set freq=fr
                   set min1dfpow=pr
                   pl 0 freq min1dfpow 1110
                   box 0 2 0 0
		   yla Power (\dot{M}_{inj} GM/c^3)^2
                   device X11
myplotmdotdo1 0    #
                   rd /us1/jon/n23/0_loss.dat
                   der t min1 tdn23 min1dn23
                   rd /us1/jon/f02/0_loss.dat
                   der t min1 tdf02 min1df02
                   reduce tdf02 min1df02 trf02 mrf02 100
                   pdimen trf02
                   set tdf02=trf02
                   set min1df02=mrf02
myplotmdot1   0    #
		   defaults
		   erase
                   device postencap /us1/jon/compare/dot/f02n23mdot.eps
                   limits tdn23 min1dn23
		   window 12 2 2:12 1 box 1 2 0 0
                   plo 0 tdn23 min1dn23
		   yla \dot{M}c^3/(\rho_0 (GM)^2)
		   xla t c^3/GM
                   #
                   limits tdf02 min1df02
		   window 12 2 2:12 2 box 1 2 0 0
                   plo 0 tdf02 min1df02
		   yla \dot{M}/\dot{M}_{inj}
		   xla t c^3/GM
                   device X11
myplotshock    0   #
                   erase
                   #
                   window 3 3 1 1
                   limits 0 1 -.1 1.1
                   lweight 2
                   box
                   lweight 3
                   connect x1 by
		   xla x
                   yla b_y
                   #
                   window 3 3 1 2
                   limits 0 1 -.1 0.4
                   lweight 2
                   box
                   lweight 3
                   connect x1 vx
		   xla x
                   yla v_x
                   #
                   window 3 3 1 3
                   limits 0 1 .15 1.1
                   lweight 2
                   box
                   lweight 3
                   connect x1 r
		   xla x
                   yla \rho
                   #
                   window 3 3 2 3
                   limits 0 1 .15 1.1
                   lweight 2
                   box
                   lweight 3
                   connect x1 p
		   xla x
                   yla p_g
                   #
                   window 3 3 2 2
                   limits 0 1 -.1 0.9
                   lweight 2
                   box
                   lweight 3
                   connect x1 vy
		   xla x
                   yla v_y
                   #
                   window 3 3 3 2
                   limits 0 1 -.1 1.1
                   lweight 2
                   box
                   lweight 3
                   connect x1 vz
		   xla x
                   yla v_z
                   #
                   window 3 3 2 1
                   limits 0 1 -.05 .55
                   lweight 2
                   box
                   lweight 3
                   connect x1 bz
		   xla x
                   yla b_z
                   #
                   window 3 3 3 1
                   limits 0 1 -2 40
                   lweight 2
                   box
                   lweight 3
		   set phi=180/PI*ATAN(bz/(by+1E-6))
                   connect x1 phi
		   xla x
		   yla \Phi [degrees]
                   #
                   window 3 3 3 3
                   limits 0 1 .85 1.9
                   lweight 2
                   box
                   lweight 3
		   set energy=0.5*r*(vx**2+vy**2+vz**2)+0.5*(bx**2+by**2+bz**2)+en
		   connect x1 energy
		   xla x
		   yla E_{tot} density
                   lweight 2
                   relocate (383 31500)
                   label b_x=0.7 t=0.16 (\rho,v_x,v_y,v_z,b_y,b_x,p_g)=(1,0,0,0,0,0,1) (0.3,0,0,1,1,0,0.2) \gamma=5/3
                   relocate (383 100)
                   label 300 zones Ryu/Jones95 4d
                  #                   
perfsetup1  1        # rainman detail single cpu run
		     da $1
		     read {j 1 i 2 zc 3}
                     define coord (1)
                     define interp (0)
		     define ny (51)
		     define nx (63)
		     define dy (2)
		     define dx (2)
		     set x22=j
		     set x12=i
		     define Sx (0)
		     define Sy (0)
		     define Lx ($nx)
		     define Ly ($ny)
perfsetup3  1        #
		     da $1
		     read {j 1 i 2 zc 3}
                     define coord (1)
                     define interp (0)
		     define ny (32)
		     define nx (32)
		     define dy (16)
		     define dx (16)
		     set x22=j
		     set x12=i
		     define Sx (0)
		     define Sy (0)
		     define Lx ($nx)
		     define Ly ($ny)
perfsetup2  1        #
		     da $1
		     read {j 1 i 2 zc 3}
                     define coord (1)
                     define interp (0)
		     define ny (17)
		     define nx (10)
		     define dy (17)
		     define dx (17)
		     set x22=j
		     set x12=i
		     define Sx (0)
		     define Sy (0)
		     define Lx ($nx)
		     define Ly ($ny)
perfsetup4  1        # 4-cpu photon/rainman MPI detail run
		     da $1
		     read {j 1 i 2 zc 3}
                     define coord (1)
                     define interp (0)
		     define ny (30)
		     define nx (63)
		     define dy (2)
		     define dx (2)
		     set x22=j
		     set x12=i
		     define Sx (0)
		     define Sy (0)
		     define Lx ($nx)
		     define Ly ($ny)
perfsetup5  1        # 1-cpu sgi origins r10000
		     da $1
		     read {j 1 i 2 zc 3}
                     define coord (1)
                     define interp (0)
		     define ny (22)
		     define nx (32)
		     define dy (2)
		     define dx (2)
		     set x22=j
		     set x12=i
		     define Sx (0)
		     define Sy (0)
		     define Lx ($nx)
		     define Ly ($ny)
		     #fix up stupid spikes
		     #
perffix1     0        #
		     do ii=0,dimen(zc)-1,1{
  		      if(zc[$ii]<2.2E5){\
		       set zc[$ii]=zc[$ii-1]
		      }
		     }
		     #
grb          0       #
		     cd ~/papers
		     da 4br_grossc.duration
		     read {i 1 t50 2 ut50 3 st50 4 t90 5 ut90 6 st90 7}
		     set lt50=LG(t50)
		     set lt90=LG(t90)
		     set bin=-3,3,.1
		     set hist50=HISTOGRAM(lt50:bin)
		     set hist90=HISTOGRAM(lt90:bin)
plgrb        1       #
		     ticksize -1 0 0 0
		     erase
		     limits bin hist$1
		     box
		     connect bin hist$1
                     # split monopole
		     # set bx=(1/tan(x2)-cos(x2)/tan(x2)/cos(t0)+1/cos(t0)*sin(x2))/x1
                     # set by=(cos(x2)/cos(t0)-1)/r
plgrb2	     0       #
		     ticksize -1 0 0 0
		     #device ppm it.ppm
		     #erase
		     ctype default
		     ltype 0
		     limits bin hist50
		     box
		     connect bin hist50
		     ltype 2
		     connect bin hist90
		     xla seconds
		     yla number of bursts
		     #
		     #
		     #
		     #
		     # FOR SP01 comparison
sp01header    0      # average in time first if you like
		     #set vx=v2dx
		     #set vy=v2dy
		     #set vz=v2dz
		     #set va=ABS(va2d)		     
		     #set vax=ABS(va2dx)
		     #set cs=SQRT(cs22d)
		     ctype default
		     set lgx=1,2,1
		     set lgx[0]=LG($Sx)
		     set lgx[1]=LG(100)
		     define thetarange (PI/256)
		     ctype white
		     #
sprho	       0     #
		     sp01header
		     erase
		     set lgy=1,2,1
		     #
		     set lgy[0]=LG(5E-1)
		     set lgy[1]=LG(10)
		     #
		     ticksize -1 0 -1 0
		     limits lgx lgy
		     box
		     ctype white
		     ltype 0
		     thetaphiavg $thetarange r ravg newx1
		     pl 0 newx1 ravg 1110
		     #
spomega        0     #
		     sp01header
		     erase
		     set lgy=1,2,1
		     #
		     set lgy[0]=LG(5E-4)
		     set lgy[1]=LG(1)
		     #
		     ticksize -1 0 -1 0
		     limits lgx lgy
		     box
		     ctype white
		     ltype 0
		     thetaphiavg $thetarange omega3 omega3avg newx1
		     pl 0 newx1 omega3avg 1110
		     #
		     ctype yellow
		     ltype 1
		     thetaphiavg $thetarange omegak omegakavg newx1
		     pl 0 newx1 omegakavg 1110
		     #
sppress	       0     #
		     sp01header
		     erase
		     set lgy=1,2,1
		     #
		     set lgy[0]=LG(1E-5)
		     set lgy[1]=LG(1)
		     #
		     ticksize -1 0 -1 0
		     limits lgx lgy
		     box
		     ctype white
		     ltype 0
		     thetaphiavg $thetarange p pavg newx1
		     pl 0 newx1 pavg 1110
		     ctype yellow
		     ltype 1
		     thetaphiavg $thetarange b2 b2avg newx1
		     pl 0 newx1 b2avg 1110
		     #
spstress       0     # reynolds stress isn't computed same right now, need more data dumps to do time averages
		     sp01header
		     erase
		     set lgy=1,2,1
		     #
		     set lgy[0]=LG(1E-5)
		     set lgy[1]=LG(1)
		     #
		     ticksize -1 0 -1 0
		     limits lgx lgy
		     box
		     ctype white
		     ltype 0
		     set vxvz=ABS(vx*vz)
		     thetaphiavg $thetarange vxvz vxvzavg newx1
		     pl 0 newx1 vxvzavg 1110
		     set bxbz=ABS(bx*bz)
		     ctype yellow
		     ltype 1
		     thetaphiavg $thetarange bxbz bxbzavg newx1
		     pl 0 newx1 bxbzavg 1110
		     #
spvel          0     # average in time if you like		     
		     sp01header
		     erase
		     set lgy=1,2,1
		     #
		     set lgy[0]=LG(1E-3)
		     set lgy[1]=LG(10)
		     #
		     ticksize -1 0 -1 0
		     limits lgx lgy
		     box
		     ctype white
		     ltype 0
		     thetaphiavg $thetarange vx vxavg newx1
		     pl 0 newx1 vxavg 1110
		     #pl 0 newx1 vxavg 1110
		     thetaphiavg $thetarange va vaavg newx1
		     #thetaphiavg $thetarange vax vaxavg newx1
		     ctype green
		     ltype 1
		     pl 0 newx1 vaavg 1110
		     ctype cyan
		     ltype 2
		     thetaphiavg $thetarange cs csavg newx1
		     pl 0 newx1 csavg 1110
		     ctype blue
		     ltype 3
		     thetaphiavg $thetarange vz vzavg newx1
		     pl 0 newx1 vzavg 1110
		     ctype red
		     ltype 4
		     pl 0 newx1 (SQRT(newx1)/(newx1-2)) 1110
		     ctype yellow
		     ltype 5
		     pl 0 newx1 (1/SQRT(newx1)) 1110
		     #
spfield        0     # average in time if you like		     
		     sp01header
		     erase
		     set lgy=1,2,1
		     #
		     set lgy[0]=LG(1E-4)
		     set lgy[1]=LG(1)
		     #
		     ticksize -1 0 -1 0
		     limits lgx lgy
		     box
		     #
		     ltype 0
		     thetaphiavg $thetarange bx bxavg newx1
		     pl 0 newx1 bxavg 1110
		     #
		     ctype cyan
		     ltype 2
		     thetaphiavg $thetarange by byavg newx1
		     pl 0 newx1 byavg 1110
		     #
		     ctype red
		     ltype 3
		     thetaphiavg $thetarange bz bzavg newx1
		     pl 0 newx1 bzavg 1110
		     #
		     ctype yellow
		     ltype 5
		     set absb=SQRT(b2)
		     thetaphiavg $thetarange absb absbavg newx1
		     pl 0 newx1 absbavg 1110
		     #		     
mpiperf1      1      #
		     da $1
                     read {p0 1 p1 2 dist 3 len 4 time 5 rate 6}
		     pl 0 len rate 1000
		     ptype 4 1
		     points (LG(len)) rate
		     xla bytes
		     yla MB/s
redcompare 0               #
		     rd /us2/jon/mhdsp00/0_loss.dat
		     der t min1 td min1d
		     set per=2*PI*80**1.5
		     set tnew=td/per
		     set mdot1=min1d/(452219.9508/per)
		     ctype red
		     pl 0 tnew mdot1 0110
                     #
redcompare2 0         #
		     rd /us3/jon/mhdtorin16/0_loss.dat 2
		     der t2 min12 td2 min1d2
		     set per=2*PI*80**1.5
		     set tnew2=td2/per
		     set mdot12=min1d2/(452219.9508/per)
		     ctype default
		     pl 0 tnew2 mdot12 0100
                     #
		     #
                     #
		     #
		     #
		     #
		     #
		     #
		     #
		     #
crap	0	     # must always have bottom macro
		     #
                     # modes
modesetup 0          #
		#set R0=15.3 # R0
		set R0=9.4 # R0
		set torbit=2*pi*(R0)**(1.5)
		#
modeplot 0           #
		     modesetup
		     rd 0_mode.dat
		     ctype default
                     #pl 0 (t/torbit) (rm1/rm0) 0101 0 15 1E-6 1E-0
		     #set m1=vm1x+1E-12
		     #set m0=vm0x+1E-12
		     set m0=rm0
		     set m1=rm1
		     #pl 0 (t/torbit) (m1/m0) 0101 (t[0]/torbit-.2) (t[dimen(t)-1]/torbit) 1E-6 1E+0
		     #pl 0 (t/torbit) (m1) 0101 (t[0]/torbit-.2) (t[dimen(t)-1]/torbit) 1E-6 1E+0
		     pl 0 (t/torbit) (m0)
modefit 0            #
		modesetup
		ctype default
		rd 0_mode.dat
		# choose mode to analyze
		set amp=rm1
		modefit1
		modefitder
		modefit2
		#modefinalplot
		#
modefit1 0           # choose time range of analysis
		     #set start=4       #21,22
		     #set start=5        #23
		     #set start=4 # 29
		     #set start=2 # 30		     
		     #set start=3.5        #24,25
		     #set start=45   # 26
		     #set start=50 # mid-22
		     #set end=6 # 21
		     #set end=8 # 22
		     #set end=6 # 23
		     #set end=16 #24,25
		     #set end=6 #29
		     #set end=66.25 # 26
		     #set end=67 # mid-22
		     #set end=4          # 30
		     set start=0.26 #mhdcart8
		     set end=0.54   #mhdcart8
		     set newtime=t/torbit		     
		     pl 0 newtime amp 0100
modefitder 0         #
		     der newtime amp newtimed ampd
		     set ampd[dimen(ampd)-1]=ampd[dimen(ampd)-2]  # fix dual time value at end
		     #
modefit2 0           #
                     set god=ampd/amp/(2*pi)
                     pl 0 newtimed god 0001 newtimed[0] newtimed[dimen(newtimed)-1] -5 5
		     set limtime=newtimed if((newtimed>start)&&(newtimed<end))
		     set limfun=god if((newtimed>start)&&(newtimed<end))
		     lsq limtime limfun newtime newfun rms
		     ctype red plo 0 newtime newfun
		     ctype default
		     set Omegam=SUM(newfun)/dimen(newfun)
		     set rms=$rms
		     set chi2=$CHI2
		     print 'Omega_m=%g rms=%g chi2=%g\n' {Omegam rms chi2}
modefinalplot 0      #
		     set beginii=0
		     set ii=0
		     while{newtime[ii]<start}{\
		      set ii=ii+1
		     }
		     set beginii=ii
		     ctype default pl 0 newtime amp 0100
		     ctype red pl 0 newtime (amp[beginii]*exp(2*pi*Omegam*(newtime-start))) 0110
		     #
modeanalyzev 2  # modeanalyzev v 1
		set new$1x=1,$nx,1
		set new$1y=1,$nx,1
		do ii=0,$nx*$nz-1,1 {
		 set indexi=INT($ii%$nx)
		 set indexj=INT(($ii%($nx*$ny))/$nx)
		 set indexz=INT($ii/($nx*$ny))
		 set new$1x[indexi+indexj*$nx]=0
		 set new$1y[indexi+indexj*$nx]=0
                }
		do ii=0,$nx*$nz-1,1 {
		 set indexi=INT($ii%$nx)
		 set indexj=INT(($ii%($nx*$ny))/$nx)
		 set indexz=INT($ii/($nx*$ny))
		 set new$1x[indexi+indexj*$nx]=new$1x[indexi+indexj*$nx]+$1x[$ii]*cos($2*x3[$ii])*dx32[$ii]
		 set new$1y[indexi+indexj*$nx]=new$1y[indexi+indexj*$nx]+$1y[$ii]*cos($2*x3[$ii])*dx32[$ii]
                }
		set newx=x12 if(k==0)
modeanalyzes 2  # modeanalyzes r 1
		set new$1=1,$nx,1
		do ii=0,$nx*$nz-1,1 {
		 set indexi=INT($ii%$nx)
		 set indexj=INT(($ii%($nx*$ny))/$nx)
		 set indexz=INT($ii/($nx*$ny))
		 set new$1[indexi+indexj*$nx]=0
                }
		do ii=0,$nx*$nz-1,1 {
		 set indexi=INT($ii%$nx)
		 set indexj=INT(($ii%($nx*$ny))/$nx)
		 set indexz=INT($ii/($nx*$ny))
		 set new$1[indexi+indexj*$nx]=new$1[indexi+indexj*$nx]+$1[$ii]*cos($2*x3[$ii])*dx32[$ii]
                }
		set newx=x12 if(k==0)
poledottotal  0  # B^2/Mdot plot
		rdbasic 0 0 -1  # to get DTs
		b2time 'dump'
		revertmin1
		gammieplot
gammieplot 0    #
		ctype default
		fdraft
		set b2omdot=b2vstime/min1d
		define x1label "t c^3/GM"
		define x2label "B_p^2/\dot{M}"
		pl 0 fieldtime b2omdot
		# below should be tuned
		#set inner=2*dimen(fieldtime)/3  # end of run
		#set outer=3*dimen(fieldtime)/3  # end of run
		set inner=dimen(fieldtime)/3 # normal run
		set outer=2*dimen(fieldtime)/3 # normal run
		avglim fieldtime b2omdot b2omdotavg inner outer
		print {b2omdotavg}
polefield 1     #
		set avgmax=1,1,1
		set num=1,1,1
		set avgmax=0*avgmax/avgmax
		set tempvolume=avgmax*0
		set tempcvolume=tempvolume*0
		set num=0*num/num
		set uses=0,$nx*$ny*$nz-1,1
		set uses=0*uses
		set pio4=0*uses+pi/4
		set newx22=ABS(x22-pi/2)
		set rin=0*uses+x12[0]
		set rout=0*uses+1.1*x12[0]
		set one=0*uses+1
		set uses=( (newx22>=pio4)&&(x12>=rin)&&(x12<=rout) ) ? 1 : 0
		#set uses=((x12>=rin)&&(x12<=2.65)&&((x22<=pi/2-pi/4)||(x22>=pi/2+pi/4))) ? 1 : 0
		do jj=0,$ny*$nx*$nz-1,1{
		   set indexi=INT($jj%$nx)
		   set indexj=INT(($jj%($nx*$ny))/$nx)
		   set indexz=INT($jj/($nx*$ny))

		   if(uses[$jj]==1){\
		     if($1==0){\
 		        set avgmax=avgmax+b2[$jj]
		        set num=num+1
		     }\
		     else{\
		      if($coord==3){\
		               #set tempcvolume=x12[$jj]*x12[$jj]*g42[$jj]*dx12[$jj]*dx22[$jj]*dx32[$jj]
		               set tempcvolume=dvl12[$jj]*dvl22[$jj]*dvl32[$jj]          
		       set tempvolume=tempvolume+tempcvolume
		      }\
		      else{\
		       set tempcvolume=dx12[$jj]*dx22[$jj]*dx32[$jj]
		       set tempvolume=tempvolume+tempcvolume
		      }
 		      set avgmax=avgmax+b2[$jj]*tempcvolume
		     }
		  }
 		}
		if($1==0){\
 		 set avgmax=avgmax/num
		 print {avgmax num}
		}\
		else{\
		 set avgmax=avgmax/tempvolume
 		 print {avgmax tempvolume}
		}
		#
mdotc         0 #
		cd /us4/jon/mhdtoribeta1
		rd 0_loss.dat
		der t min1 td min1d
		ctype default pl 0 td min1d
		cd /us4/jon/mhdtoribeta2
		rd 0_loss.dat 2
		der t2 min12 td2 min1d2
		ctype red plo 0 td2 min1d2
		#
mdotc2         0 #
		cd /us4/jon/mhdtoribeta2
		rd 0_loss.dat 2
		der t2 min12 td2 min1d2
		cd /us4/jon/mhdtoribeta1
		rd 0_loss.dat
		der t min1 td min1d
		if(td2[dimen(td2)-1]>td[dimen(td)-1]){ set finaltime=td2[dimen(td2)-1] } else { set finaltime=td[dimen(td)-1] }
		ctype default pllim 0 td2 min1d2 0 finaltime 0 10
		ctype red plo 0 td min1d
		#
newviscplotrd 0   #device postencap /us1/jon/compare/dot/$2mdot.eps
		rdr
		set _fullvec=0
		set _coord=3
		rdbasic 0 0 -1
		cd /us2/jon/a1
		rd 0_loss.dat
		redloss
		der tr min1r tda min1da
		der tr ein1r tda ein1da
		der tr mx3in1r tda mx3in1da
		cd /us2/jon/a6
		rd 0_loss.dat
		redloss
		der tr min1r tdb min1db
		der tr ein1r tdb ein1db
		der tr mx3in1r tdb mx3in1db
		#
newviscplotdo 0   #
		erase
		device postencap /home/jon/research/paper/new/comp.eps
		ctype default
		expand 1.5
		ptype 4 0
		lweight 3
		define PLOTLWEIGHT 5
		define NORMLWEIGHT 3
		#
		# mdot
		limits tda -.007 .072
		window -1 -3 1 3 box 0 2 0 0
		yla "\dot{M}/\dot{M}_{inj}"
		ltype 0
		plo 0 tda min1da
		ltype 3
		plo 0 tdb min1db
		#
		# edot/mdot
		set ita=ein1da/min1da
		set itb=ein1db/min1db
		set crap=0,1,1
		set crap[0]=tda[0]
		set crap[1]=tda[dimen(tda)-1]
		limits crap -.065 -.01
		window -1 -3 1 2 box 0 2 0 0
		# new units injection
		yla "\dot{E}/(\dot{M}c^2)"
		ltype 0
		plo 0 tda ita
		ltype 3
		plo 0 tdb itb
		#
		# mx3in/min
		set ita=mx3in1da/min1da
		set itb=mx3in1db/min1db
		set crap=0,1,1
		set crap[0]=tda[0]
		set crap[1]=tda[dimen(tda)-1]
		limits crap 0 2.4
		window -1 -3 1 1 box 1 2 0 0
		yla "\dot{L}c/(GM\dot{M})"
		xla "t c^3/GM"
		ltype 0
		plo 0 tda ita
		ltype 3
		plo 0 tdb itb
		device X11
		#
mdotvsr   0     #
		define npdone (1)
		define fullvec (0)
		define coord (3)
		rdnumd
		set start=2*$NUMDUMPS/3
		set end=$NUMDUMPS-1
		avgtime 'dump' start end
		# end with Fmdxtime which is rho*vr time average
		# assume done in spherical coordinates so x12=r
		set massflux=Fmdxtime*x12**2 # now *rho*vr*r^2
		set lflux=Fvzdxtime*x12**2
		# below should include the sin(theta) factor and differentials in theta and phi
		thetaphiavg PI/6 massflux mdotavg newx1
		thetaphiavg PI/6 lflux lavg newx1
		thetaphiavg PI/2 massflux mdotavgfull newx1
		thetaphiavg PI/2 lflux lavgfull newx1
lmdotsdo  0     #
		define LOOPTYPE (1)
		rdr
		rdbasic 0 0 -1
		#rdbasic 0 1 -1
		rd 0_loss.dat
		smstart
lmdotsplot 0    #
		#device postencap le.eps
		#
		if($GAMMIE==0){\
		       redloss
		       der tr min1r td min1d
		       der tr ein1r td ein1d
		       der tr mx3in1r td mx3in1d
		    }
		set em=-ein1d/min1d
		set lm=mx3in1d/min1d
		fdraft
		erase
		limits td em
		window -1 -2 1 2 box 0 2 0 0
		#xla "t c^3/GM"
		yla "-\dot{E}/(\dot{M}c^2)"
		plo 0 td em
		#
		#
		limits td lm
		window -1 -2 1 1 box 1 2 0 0
		xla "t c^3/GM"
		yla "(\dot{L}/\dot{M})(c/GM)"
		plo 0 td lm
		#
		#device X11
		#
thind     0     #
		cd ../thindisk5
		rdbasic 0 0 -1
		readenerfull
		ctype default
		pl 0 t (iplus-iminus)
		#
		cd ../thindisk4
		readenerfull
		ctype red
		plo 0 t (iplus-iminus)
		#
		cd ../thindisk3
		readenerfull
		ctype blue
		plo 0 t (iplus-iminus)
		#
		cd ../thindisk2
		readenerfull
		ctype green
		plo 0 t (iplus-iminus)
		#
		cd ../thindisk5
		#
intratio 1 #		
		      set ii=0
		      echo doing lspec
		      set omega3=v$!!extz/(x12*g42)
		      #set lspec=x12*x12*omega3
		      set omegak= sqrt(1.0/(x12**3 * (1.0-2/x12)**2 ) )
		      set lspec=x12*x12*omegak
		      thetaphiavg $1 lspec lspecavg newx1 0
		      echo doing mdot
		      set mdot=r*vx*x12*x12
		      thetaphiavg $1 mdot mdotfull newx1 1
		      echo doing flr		      
		      set Flartime=(x12*x12*x12*g42*r*vx*vz)
		      thetaphiavg $1 Flartime avgflr newx1 1
		      echo doing flm
		      set Flamtime=(x12*x12*x12*g42*(-bz*bx))
		      thetaphiavg $1 Flamtime avgflm newx1 1
		      echo doing plot
		      while {x12[ii]<6.0} { set ii=ii+1 }
		      set pickradius=ii
		      define lisco (lspecavg[pickradius])
		      set intratio1vst=avgflm/mdotfull/$lisco
		      set intratio2vst=avgflr/mdotfull/$lisco
		      #
		      set ldot=(Flartime+Flamtime)
		      thetaphiavg $1 ldot ldotfull newx1 1
		      set lmdot=ldotfull/mdotfull/$lisco
crapit    0     #
	        #


		
