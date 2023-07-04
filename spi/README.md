!이 프로젝트는 상명대학교의 과제물로 제작되었습니다. 허락 없이 사용하지 말아주세요!
!This project is made for the assignment of Sangmyung University. Please don't use it without permission!

spi의 master와 slave 중 master를 구현한 코드입니다.
input으로 들어오는 clk의 25배 주기를 가지는 sclk를 만듭니다.  
start 버튼이 눌리면 sclk의 rising edge에서 sdata를 읽어서 16진수의 형태로 FND[1:0]에 내보냅니다. 

It is a code that implements the master of spi. (master/slave)
It creates a sclk with a 25-fold slow cycle of the clk entering as the input.
When the start button is pressed, it reads the sdata from the rising edge of the sclk and exports it to FND[1:0] in hexadecimal form.
