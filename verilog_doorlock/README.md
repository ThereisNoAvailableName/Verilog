!이 프로젝트는 상명대학교의 과제물로 제작되었습니다. 허락 없이 사용하지 말아주세요!
!This project is made for the assignment of Sangmyung University. Please don't use it without permission!


스테이트 머신을 이용하여 도어락을 구현한 베릴로그 코드입니다.
동작 모드와 설정 모드 2가지의 모드를 가지며, sharp 버튼을 눌러서 모드를 변경합니다. 
LED[3:2]를 통해 현재 모드드를 표시합니다.
LED[2]: 동작 모드   LED[3]: 설정 모드

동작 모드:
10자리 슬라이드 스위치로 비밀번호를 입력 받고 star 버튼(Push Button[1])을 누릅니다. 
설정한 비밀번호가 일치할 경우 LED[0]이 켜지며(open), 틀릴 경우 LED[1]이 켜집니다.(alarm)
설정 모드:
10자리 슬라이드 스위치로 2~3자리 비밀번호를 입력 받습니다. 
sharp 버튼을 누르면 비밀번호가 설정됨과 함께 현재 모드가 동작 모드로 변경됩니다. 
비밀번호의 길이가 1자리일 경우 비밀번호 변경이 적용되지 않으며, 4자리 이상일 경우 앞자리 3자리만 적용됩니다. 
초기화된 상태에서 비밀번호는 000으로 설정되어 있습니다. 

Verilog code that implements a door lock using a state machine.
There are two modes, active mode and setting mode. Press the sharp button to change the mode.
Displays the current mode via the LED [3:2].
LED[2]:active mode LED[3]:setting mode

Active mode:
Enter the password with the 10 slide switch and press the star button (Push Button [1]).
If the password you set is correct, LED[0] turns on(open), and if it is incorrect, LED[1] turns on(alarm).
Setting mode:
Enter the 2 or 3 digit password with the 10 slide switch.
Pressing the sharp button changes the current mode to active mode with the password setting.
If the password is 1 digit long, the setting will not be applied; if it is more than 4 digits, only the first 3 digits will be applied.
After reset, the password is set to 000 first.
