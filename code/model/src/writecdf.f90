  subroutine writecdf(step,n)

  USE header,ONLY : NI,NJ,NK,ntr,nconsume,dirout,out1d_int,out2d_int,out3d_int,rc_kind
  IMPLICIT NONE

  INTEGER :: step,counter_2d,counter_3d,counter_1d,ksurf,islice,jslice,imooring,jmooring,n
  REAL :: sigma

! out1d_int  - frequency of 1d output
! out2d_int  - frequency of 2d output
! out3d_int  - frequency of 3d output

  ! 1D output
  if (mod(step,out1d_int).eq.0) then
    counter_1d= step/out1d_int +1 
imooring=NI/2;jmooring=NJ/2;    call writemooring(imooring,jmooring,counter_1d)
  end if

  ! 2D output
  if (mod(step,out2d_int).eq.0) then
    counter_2d= step/out2d_int +1 

    ksurf=NK;    call writeksurf(ksurf,counter_2d,n)
    ksurf=NK/2;  call writeksurf(ksurf,counter_2d,n)
    islice= NI/2;call writexslice(islice,counter_2d,n)
    jslice= NJ/2;call writeyslice(jslice,counter_2d,n)
    sigma=26.d0;  call writeisopycnal(sigma,counter_2d,n) ! writes the solution on the sigma isopycnal

  end if

  ! 3D output
  if (mod(step,out3d_int).eq.0) then
    counter_3d= step/out3d_int +1 
   call outcdf(step,n)
   call writestrain(step,n)

  end if
     
! ksurf=NK;call writeksurf(frame_int,step,ksurf,h,consump,Tr,s,T,rho,u,v,w,p,vor,strain,freqN2,xc,yc,zc,DL,LEN,Jac,dtf*TL)
! ksurf= INT(NK/3); call writeksurf(frame_int,step,ksurf,h,consump,Tr,s,T,rho,u,v,w,p,vor,strain,freqN2,xc,yc,zc,DL,LEN,Jac,dtf*TL)

  END 
