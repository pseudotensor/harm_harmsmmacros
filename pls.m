pls    17	# pls <file> <function> <type of plot=100,000,overlay=010,000,limits=000,001> <0 0 0 0>
                prepaxes x1 x2 $2
                if($?3 == 1) { define tobebits ($3) } else { define tobebits (0x0) }
                #defaults
                #expand 1.3
                #location 3500 17250 3500 31000
                location 3500 31000 3500 31000
                #window 2 1 1 1
                myrd $1
                if('$tobebits'=='000'){\
                 set thebits=0x0
		}\
                else{\
                 set thebits=0x$tobebits
		}
                if(thebits & 0x001){\
		  shrink3 $2 x12 x22 $4 $5 $6 $7
		  set newfun=$2new
		   if(thebits & 0x100){\
		         set inew=i if( (ixold>=$rxl)&(ixold<=$rxh)&(iyold>=$ryl)&(iyold<=$ryh))
		         set jnew=j if( (ixold>=$rxl)&(ixold<=$rxh)&(iyold>=$ryl)&(iyold<=$ryh))
		          set reallyx=inew if(k==$WHICHLEV)
		          set reallyy=jnew if(k==$WHICHLEV)
		   }\
		   else{\
		    set reallyx=x12new if(k==$WHICHLEV)
		    set reallyy=x22new if(k==$WHICHLEV)
                   }
                }\
                else{\
		 if($PLANE==3){\
		   define xl ($Sx)
	   	   define xh ($Sx+$Lx)
		   define yl ($Sy)
		   define yh ($Sy+$Ly)
                   define txl ($xl)
                   define txh ($xh)
                   define tyl ($yl)
                   define tyh ($yh)
                   define rxl (0)
                   define rxh ($nx)
                   define ryl (0)
                   define ryh ($ny)
                   define rnx ($nx)
                   define rny ($ny)
                   #image ($nx,$ny) $xl $xh $yl $yh
                   #image ($nx,$ny) $rxl $rxh $ryl $ryh
                   #image ($nx,$ny)
                   #set reallyx=x1
                   #set reallyy=x2
                   #set reallyx=x12 # don't need for plc
                   #set reallyy=x22 # don't need for plc
		   #define WHICHLEV ($nz/2)
                   set newfun=$2  if(k==$WHICHLEV) # for example
		   define realdx ($dx)
		   define realdy ($dy)
		   if(thebits & 0x100){\
		          set reallyx=i if(k==$WHICHLEV)
		          set reallyy=j if(k==$WHICHLEV)
		   }\
		   else{\
		    set reallyx=x12 if(k==$WHICHLEV)
		    set reallyy=x22 if(k==$WHICHLEV)
                   }
		#
		 }
		 if($PLANE==2){\
                   define xl ($Sx)
	   	   define xh ($Sx+$Lx)
		   define yl ($Sz)
		   define yh ($Sz+$Lz)
                   define txl ($xl)
                   define txh ($xh)
                   define tyl ($yl)
                   define tyh ($yh)
                   define rxl (0)
                   define rxh ($nx)
                   define ryl (0)
                   define ryh ($nz)
                   define rnx ($nx)
                   define rny ($nz)
		   #define WHICHLEV ($ny/2)
                   set newfun=$2 if(j==$WHICHLEV)
		   define realdx ($dx)
		   define realdy ($dz)
	   	   #
		   set reallyx=x12 if(j==$WHICHLEV)
                   set reallyy=x32 if(j==$WHICHLEV)
		 }
		 if($PLANE==1){\
                   define xl ($Sy)
	   	   define xh ($Sy+$Ly)
		   define yl ($Sz)
		   define yh ($Sz+$Lz)
                   define txl ($xl)
                   define txh ($xh)
                   define tyl ($yl)
                   define tyh ($yh)
                   define rxl (0)
                   define rxh ($ny)
                   define ryl (0)
                   define ryh ($nz)
                   define rnx ($ny)
                   define rny ($nz)
		   #define WHICHLEV ($nx/2)
                   set newfun=$2 if(i==$WHICHLEV)   
		   define realdx ($dy)
		   define realdy ($dz)
		   set reallyx=x22 if(i==$WHICHLEV)   
                   set reallyy=x32 if(i==$WHICHLEV)   
	   	   #
		 }		 
                }
		set ii=1,$rnx*$rny
		if($SKIPFACTOR>1){\
		 if( $SKIPFACTOR>$rnx/2-1 ||  $SKIPFACTOR>$rny/2-1){\
		  if($rny<$rnx){\
		   set temptemp=int($rny/2-1)
		   define SKIPFACTOR (temptemp)
		  }\
		  else{\
		   set temptemp=int($rnx/2-1)
		   define SKIPFACTOR (temptemp)
		  }
		 }
		 set ii=0,$rnx*$rny-1
		 set iix = ii%$rnx+1
		 set iiy = int(ii/$rnx)+1
		 set use = (int(iiy/$SKIPFACTOR) - iiy/$SKIPFACTOR == 0 && int(iix/$SKIPFACTOR) - iix/$SKIPFACTOR == 0  ) ? 1 : 0
		 set temptempnx=int($rnx/$SKIPFACTOR)
		 set temptempny=int($rny/$SKIPFACTOR)
		 define rnx (temptempnx)
		 define rny (temptempny)
		 set ii=0,$rnx*$rny-1
		 set ix = ii%$rnx
		 set iy = int(ii/$rnx)
		}\
		else{\
		 set x=(ii - $rnx*int((ii-0.5)/$rnx) - 0.5)*$realdx+$txl
		 set y=((int((ii-0.5)/$rnx) + 0.5)*$realdy)+$tyl
		 set ix = int((x -$txl)/$realdx)
		 set iy = int((y -$tyl)/$realdy)
		 set use=ii/ii*1		 
		}
		#
		set newfuntemp=newfun if(use)
		set newfun=newfuntemp
		set realx1=reallyx if(use)
		set realy1=reallyy if(use)
		#
		# sm image command loses first row of data, so add a buffer of 0s
		# occurs for positive large values in the 0->$rnx for tj=0, for whatever crappy buggy reason!
		#set truenewfun=1,$rnx*($rny+1),1
		#set truenewfun=0*truenewfun
		#set truerealx1=0*truenewfun
		#set truerealy1=0*truenewfun
		#do kk=$rny,$rnx*$rny-1,1{
		#   set truenewfun[$kk]=newfun[$kk-$rny]
		#   set truerealx1[$kk]=realx1[$kk-$rny]
		#   set truerealy1[$kk]=realy1[$kk-$rny]
		#}
		#define rny ($rny+$rnx)
		#set newfun=truenewfun
		#set realx1=truerealx1
		#set realx2=truerealx2
		#
		#
		#
		if(!(thebits & 0x010)){\
                 limits $txl $txh $tyl $tyh
		}
		#image ($nx,$ny) $xl $xh $yl $yh
		#image ($rnx,$rny)
		image ($rnx,$rny)
		#
                set image[ix,iy] = newfun
		#set image[ix,iy] = $2[ii-1]
                set realx=0,$rnx-1
                set realy=0,$rny-1
                do kk=0,$rnx-1,1{
                  set realx[$kk] = realx1[$kk]
                }
                do kk=0,$rny-1,1{
                  set realy[$kk] = realy1[$kk*$rnx]
                }
                #
		if(!(thebits & 0x010)){\
                 limits 0 $rnx 0 $rny
		}
                #limits $rxl $rxh $ryl $ryh
                minmax min max echo $min $max
		if(!(thebits & 0x010)){\
                 limits 0 $rnx 0 $rny
		}
                #limits $rxl $rxh $ryl $ryh
                #device ppm file1.ppm
                # default(0) to not overlay
                if(thebits & 0x010){\
                   define temptemptemp (1)
                }\
                else{
                 erase
		 ctype default
                 labeltime
                }
                # else overlay
		load surfaces
		Viewpoint 50 50 0
		#Viewpoint 80 80 0
                #Viewpoint 20 20 0
		#Viewpoint 50 -130 0
                #surface 13 $min $max realx realy
                #Surface 13 $min $max realx realy
                #Surface 13 $min $max ix iy
                # default to not be log-log
		Surface 103 $min $max realx realy
		#
                define Lo_x ($txl)
                define Hi_x ($txh)
                define Lo_y ($tyl)
                define Hi_y ($tyh)
                box3
                labelaxes3 x1 x2 $2
                #device X11
		#
		#
		#

