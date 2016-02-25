
;---------------------------------------------------------------------------------------------------;

	;Master Clicker
	;Author: Cloudwad (Rewritten from from Scripts by CrownFox)
		
global title := "Clicker Heroes"

#NoEnv  ;Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ;Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ;Ensures a consistent starting directory.
#SingleInstance force ;if script is opened again, replace instance
#Persistent ;script stays in memory until ExitApp is called or script crashes
SetTitleMatchMode 3 ;Exact Match
WinActivate %title%
SetMouseDelay -1
SetBatchLines -1 
SetControlDelay -1
SetKeyDelay -1

;---------------------------------------------------------------------------------------------------;
 
global gui := true
global running := false
global leveluphero := false
global heroslot := 2
global clickables := false
global Count := 0

Gui,Font,S14 W550,Arial
Gui,Add,Text,vCPS x0 y5 w250 h40 +Center,Clicks Per Second
 
Gui,Font,S25 CDefault Bold,Arial
Gui,Add,Text,vText x0 y25 w250 h40 +Center,%Count%
 
Gui,Font,S10 CDefault Bold,Arial
Gui,Add,Text, x5 y195 w125 h15 +Left,Running (F7/F8):
Gui,Add,Text,vRunning x120 y195 w125 h15 +Right,False
Gui,Add,Text, x5 y210 w125 h15 +Left,Level Hero (F9):
Gui,Add,Text,vHeroLevel x120 y210 w125 h15 +Right,False
Gui,Add,Text, x5 y225 w125 h15 +Left,Click Candy (F10):
Gui,Add,Text,vClickables x120 y225 w125 h15 +Right,False
Gui,Add,Text, x5 y240 w125 h15 +Left,Exit Clicker (F11)
 
Gui, Show, w250 h265, Clicker v1

F7::
        GuiControl,Text,Running,True
        activate()
        return
       
F8::
        GuiControl,Text,Running,False
        running := false
        return
       
F9::
        if (leveluphero = false)
        {
                GuiControl,Text,HeroLevel,True
                leveluphero := true
                return
        }
        else
        {
                GuiControl,Text,HeroLevel,False
                leveluphero := false
                return
        }
        return
       
F10::
        if (clickables = false)
        {
                GuiControl,Text,Clickables,True
                clickables := true
                return
        }
        else
        {
                GuiControl,Text,Clickables,False
                clickables := false
                return
        }
        return
       
F11::
        ExitApp
        return
 
activate()
{
        starttime := A_TickCount
        Count := 0
        running := true
        i := 0
		end := 25
        
        while(running) {
			clickBeeArea()
			if(clickables) {
				clickClickables()
			}
			if (leveluphero) {
                if (i > end) {
					levelHero()
					i := 0
				}     
				i++
			}
			if (gui) {
				ET := A_TickCount - starttime
				Clicks_Second := Count / (ET / 1000)
				GuiControl,Text,Text,%Clicks_Second%
				if (leveluphero) {
					GuiControl,Text,HeroLevel,True
				}
				else {
					GuiControl,Text,HeroLevel,False
				}
				if (running) {
					GuiControl,Text,Running,True
				}
				else {
					GuiControl,Text,Running,False
				}
			}      
            sleep 55
        }     
        return
}

clickBeeArea() {
    clickXY(750, 160)
	clickXY(800, 160)
	clickXY(850, 160)
	clickXY(900, 160)
	clickXY(950, 160)
	clickXY(975, 160)
	clickXY(1000, 160)
    return
}
 
clickClickables() {
	clickXY(515, 490)
	clickXY(740, 430)
	clickXY(755, 480)
	clickXY(755, 370)
	clickXY(860, 510)
	clickXY(1000, 455)
	clickXY(1040, 440)
    return
}

levelHero() {
	math := 203 + (104 * (heroslot-1)) + 58
	clickXY(60, math)
	return
}

clickXY(vX, vY, delayNum:=20) {
	ControlClick, % "x" vX " y" vY, %title%,,,, NA
	Count++
	sleep %delayNum%
	return
}