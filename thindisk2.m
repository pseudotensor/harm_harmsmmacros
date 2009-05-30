dm1024vs2048 0   #
		1307  jrdpener 0 2000
		1308  pl 0 t dm
		1309  !scp metric.physics.uiuc.edu:ener1024.out .
		1310  jrdpener 0 2000
		1311  set dm2048=dm
		1312  set t2048=t
		1313  !cp ener.out ener2048.out
		1314  !cp ener1024.out ener.out
		1315  jrdpener 0 2000
		1316  set dm1024=dm
		1317  set t1024=t
		1318  pl 0 t1024 dm1024
		1319  ctype red plo 0 t2048 dm2048
		1320  pl 0 t1024 dm1024 0001 0 2000 -.05 0
		1321  ctype default pl 0 t1024 dm1024 0001 0 2000 -.05 0
		1322  ctype red plo 0 t2048 dm2048
		1323  ctype default pl 0 t1024 dm1024 0001 0 1000 -.05 0
		1324  ctype red plo 0 t2048 dm2048
		1325  ctype default pl 0 t1024 dm1024 0001 0 1000 -.05 0
		1326  define x1label "t (c^3/GM)
		1327  define x1label "t (c^3/GM)"
		1328  define x2label "\dot{M}_0"
		1329  ctype default pl 0 t1024 dm1024 0001 0 1000 -.05 0
		1330  ctype red plo 0 t2048 dm2048
		ctype default pl 0 t1024 (ABS(dm1024)) 0101 0 1000 1E-5 0.1
		ctype red pl 0 t2048 (ABS(dm2048)) 0110
