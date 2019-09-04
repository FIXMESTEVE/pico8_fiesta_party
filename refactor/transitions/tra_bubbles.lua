--original version made by emu
--https://www.lexaloffle.com/bbs/?tid=3588
xcam=0
ycam=0
tra_bubbles={}

--timer
tra_bubbles.t=0

function tra_bubbles._update()
  --increase timer
  tra_bubbles.t+=0.025
  if (tra_bubbles.t>5)then
    tra_mgr:finish()
  end
end

function tra_bubbles._draw()
  cls()

  --this crazy bit loops through
  --limited background colors,
  --and changes it when the
  --screen is covered with white
  if(tra_bubbles.t>2.60)then
    tra_mgr.next_scn._init()
    tra_mgr.next_scn._draw()
  else
    tra_mgr.current_scn._draw()
  end

  for i=0,8 do -- column loop
    for j=0,8 do -- row loop
      --x positions are snapped
      --to 16px columns
      local x = i*16

      --this number sweeps back
      --and forth from -1 to 1
      local osc1 = sin(tra_bubbles.t+i*0.1)

      --this number also sweeps
      --back and forth, but at
      --a different rate
      local osc2 = sin(tra_bubbles.t/4+j*0.03)

      --y positions are influenced
      --by one of the sweepy
      --numbers
      local y = j*16 + osc1*10

      --the circles' radii are
      --influenced by the other
      --sweepy number
      circfill(x+xcam, y+ycam, osc2*15, 7)
    end
  end
end