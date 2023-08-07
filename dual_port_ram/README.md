!이 프로젝트는 상명대학교의 과제물로 제작되었습니다. 허락 없이 사용하지 말아주세요!

32비트 데이터 2개를 저장하는 2x32 ram 메모리를 구현한 코드입니다. 

LED[0]: error, LED[2:1]: 2bit_status_vld, LED[3]: dout_vld, LED[4]: full 

PUSH[0]: n_rst, PUSH[1]: din_vld, PUSH[2]: read

데이터 저장 상태가 2bit_status_vld LED에 표시됩니다.

status_vld[0]이 불이 켜진 상태이면 0 위치에 저장된 데이터가 있는 것이며, 0의 데이터를 읽으면 status_vld[0]의 불이 꺼집니다.

쓰기:

슬라이드 스위치로 0~9까지의 숫자를 설정한 후 din_vld 버튼을 누르면 2x32 램에 데이터를 저장합니다. 

저장 위치는 데이터가 없는 위치로 자동적으로 지정됩니다. 초기화 됐을 때 처음 위치는 2bit_status_vld[0]입니다. 

읽기:

read 버튼을 누르면 ram에 저장된 데이터를 16진수의 형태로 FND에 출력합니다. 

읽을 위치는 데이터가 있는 위치로 자동적으로 지정됩니다. 초기화 됐을 때 처음 위치는 2bit_status_vld[0]입니다. 

read 버튼을 눌렀는데 읽으려는 위치에 데이터가 없을 경우 error의 불이 켜지며, 2자리 모두 저장된 데이터가 있는 경우 full의 불이 켜집니다. 


!This project is made for the assignment of Sangmyung University. Please don't use it without permission!

2x32 ram memory that stores two 32-bit data.

LED[0]: error, LED[2:1]: 2bit_status_vld, LED[3]: dout_vld, LED[4]: full

PUSH[0]: n_rst, PUSH[1]: din_vld, PUSH[2]: read

The data storage status is displayed on the 2bit_status_vld LED.

If status_vld[0] light turns on, there is data stored in the 0 position, and if you read the 0 data, status_vld[0] light turns off.

Write:

Set the number from 0 to 9 on the slide switch and press the din_vld button to store the data in 2x32 RAM.

The write address is automatically assigned to a location where there is no data. When initialized, the first position is 2bit_status_vld[0].

Read:

When the read button is pressed, the data stored in the ram is output to the FND in hexadecimal format.

The read address to read is automatically assigned to a location where the data is stored. When initialized, the first position is 2bit_status_vld[0].

If you press the read button and there is no data in the address, the error light turns on.
And if there is data stored in both digits, the full light turns on.
