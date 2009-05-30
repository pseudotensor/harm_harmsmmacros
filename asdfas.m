jrdp dump0005
fieldcalc 0 aphi
interpsingle aphi 256 256 3 3 0
!~/sm/iinterpnoextrap 1 2 1 1 $nx $ny $nz  1.0 0.0 0.5 $igrid  $inx $iny $inz  0 $ixmax -$iymax $iymax 0 0 \
$iRin $iRout $iR0 $ihslope $idefcoord < ./dumps/aphi > ./dumps/iaphi

!~/sm/iinterp 1 0 1 1 $nx $ny $nz  1.0 0.0 0.5 $igrid  $inx $iny $inz  0 $ixmax -$iymax $iymax 0 0\  $iRin $iRout $iR0 $ihslope $idefcoord < ./dumps/aphi > ./dumps/iaphi
