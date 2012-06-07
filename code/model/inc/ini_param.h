

  
!-------------------------------------------
!   reading configuration file
!--------------------------

  NAMELIST /PARAM/ nsteps,dtf,fnhhy,fplane,phi0deg,dx,dy,total_depth,Kx,Ky,&
                   pickup_int,pickup_step,out1d_int,out2d_int,out3d_int,dirout
#ifdef particle
  NAMELIST /traj/ ini_particle_time,parti_file_num,NPR,pcx,pcy,pcz,pcr
#endif
  READ (*,PARAM) !from the namelist file
#ifdef particle
  READ (*,traj) !from the namelist file
#endif




!--------------------------
! Numerical matters:

  kappah= 0.65d0 

  kaphinv= 1.d0/kappah 


!--------------------------
! Geometric constants:

  lambda= LEN/AL 

  delta= DL/LEN 

  delinv= LEN/DL



!--------------------------
! Characteristics of the flow: 

  qpr= fnhhy*delta 

  beta= 1.d0/(EPS*EPS*delta) 

  UL= FPAR *LEN*EPS 

  WL= EPS*delta*UL 

  P1= R0*UL*UL*EPS**(-1) !     P1= RU^2/EPS                                                      

  HL= P1/(R0*10.d0)      ! 10.d0 stands for the normalization of g. 

  HDL= HL/DL 

  TL= LEN/UL 



!--------------------------
! Summary:


  WRITE(*,"(A,E14.4)")  "# fnhhy   = ", fnhhy
  WRITE(*,"(A,E14.4)")  "# EPS     = ",EPS
  WRITE(*,"(A,E14.4)")  "# delta   = ",delta
  WRITE(*,"(A,E14.4)")  "# qpr     = ", qpr
  WRITE(*,"(A,E14.4)")  "# lambda  = ",lambda
  WRITE(*,"(A,E14.4)")  "# beta    = ", beta
  WRITE(*,"(A,E14.4)")  "# dtf     = ", dtf
  WRITE(*,"(A,E14.4)")  "# WL      = ", WL
  WRITE(*,"(A,E14.4)")  "# R0      = ", R0
  WRITE(*,"(A,E14.4)")  "# UL      = ", UL
  WRITE(*,"(A,E14.4)")  "# P1      = ", P1
  WRITE(*,"(A,E14.4)")  "# HL      = ", HL
  WRITE(*,"(A,E14.4)")  "# HDL     = ", HDL
  WRITE(*,"(A,i14.4)")  "# NP      = ", NPR
  
