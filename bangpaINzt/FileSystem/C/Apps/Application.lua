awtxReq={}
require("awtxReqConstants")
require("ReqWeb")
require("awtxReqScaleKeys")
-- AppName 
AppName = "Multi Scale Application"

TextLine1 = "  "
TextLine2 = "Avery Weigh-Tronix"
TextLine3 = AppName
TextLine4 = "Version : TH_3SCL_V1.3"
TextLine5 = "ZT load cells / 3 Scales"

-- Create Startup screen

Text_Screen = awtx.graphics.screens.new("Text_Screen")  -- create a screen

--create a label control
txtLabel1 = awtx.graphics.label.new("textLabel1")    -- create a label
txtLabel1:setLocation(85, 0)   
txtLabel1:reSize(320,15)
txtLabel1:setFont(awtx.graphics.FONT_VERDANA_15)
txtLabel1:setText(TextLine1)
txtLabel1:setVisible(true)

txtLabel2 = awtx.graphics.label.new("textLabel2")    -- create a label
txtLabel2:setLocation(85, 15)   
txtLabel2:reSize(320,15)
txtLabel2:setFont(awtx.graphics.FONT_VERDANA_15)
txtLabel2:setText(TextLine2)
txtLabel2:setVisible(true)

txtLabel3 = awtx.graphics.label.new("textLabel3")    -- create a label
txtLabel3:setLocation(75, 30)   
txtLabel3:reSize(320,15)
txtLabel3:setFont(awtx.graphics.FONT_VERDANA_15)
txtLabel3:setText(TextLine3)
txtLabel3:setVisible(true)

txtLabel4 = awtx.graphics.label.new("textLabel4")    -- create a label
txtLabel4:setLocation(75, 45)   
txtLabel4:reSize(320,15)
txtLabel4:setFont(awtx.graphics.FONT_VERDANA_15)
txtLabel4:setText(TextLine4)
txtLabel4:setVisible(true)

txtLabel5 = awtx.graphics.label.new("textLabel5")    -- create a label
txtLabel5:setLocation(85, 60)   
txtLabel5:reSize(320,15)
txtLabel5:setFont(awtx.graphics.FONT_VERDANA_15)
txtLabel5:setText(TextLine5)
txtLabel5:setVisible(true)

Text_Screen:addControl(txtLabel1)
Text_Screen:addControl(txtLabel2)
Text_Screen:addControl(txtLabel3)
Text_Screen:addControl(txtLabel4)
Text_Screen:addControl(txtLabel5)

Text_Screen:show()




-- create main screen to display scales and weight
mainScreen = awtx.graphics.screens.new("mainScreen")  -- create a screen

--create a scale control
--Scale style 1 320x80 Large
--Scale style 2 320x60 Medium
--Scale style 3 320x34 Small
--Scale style 4 160x24 Side-by-side

--create control for scale 1 
ctrlScale1 = awtx.graphics.scale.new("scale1",1,4 ) 
ctrlScale1:setLocation(0, 0)
ctrlScale1:setScaleNumVisible(true)

--create control for scale 2
ctrlScale2 = awtx.graphics.scale.new("scale2",2,4 ) 
ctrlScale2:setLocation(160, 0)
ctrlScale2:setScaleNumVisible(true)

--create control for scale 3
ctrlScale3 = awtx.graphics.scale.new("scale3",3,4 ) 
ctrlScale3:setLocation(0, 25)
ctrlScale3:setScaleNumVisible(true)

--create control for scale 4
ctrlScale4 = awtx.graphics.scale.new("scale4",4,4 ) 
ctrlScale4:setLocation(160, 25)
ctrlScale4:setScaleNumVisible(true)

--create control for Total
ctrlScaleTotal = awtx.graphics.scale.new("scaleTotal",-1,3 ) 
ctrlScaleTotal:setLocation(60, 50)
ctrlScaleTotal:setScaleNumVisible(true)

--add controls to the main screen
mainScreen:addControl(ctrlScale1)
mainScreen:addControl(ctrlScale2)
mainScreen:addControl(ctrlScale3)
mainScreen:addControl(ctrlScale4)
mainScreen:addControl(ctrlScaleTotal)

function onPrintComplete(errCode,errMsg)

  if errCode == 0 then 
    awtx.printer.printFmt(1)
  end
end

function awtx.keypad.KEY_PRINT_DOWN()
  awtx.weight.requestPrint(0)
end


function suitedAndBooted() 
  mainScreen:show() 
end

function awtx.keypad.KEY_ZERO_DOWN()            -- Zero all active scales
  
 i = 1
 
 number_of_active_scales =  awtx.weight.getNumActiveScales()
 
while i <= number_of_active_scales do
      awtx.weight.requestZero(i)
      
      
      i = i + 1
end 
 
end

function onZeroComplete(result, resultstring)

print (result)
print (resultstring)
print (scaleNum)

end

-- Setup events

awtx.weight.registerZeroCompleteEvent(onZeroComplete)


awtx.os.createTimer(suitedAndBooted, 5000)

awtx.weight.registerPrintCompleteEvent(onPrintComplete)
--Tell the system to beep once number is at or above 10
local number = 0
for i = 1, 10 do
if number < 10 then
number = number + 1
else
awtx.display.doBeep()
end
end
print(number) -- Prints to the Lua Console (located at Ztools -> Zedit -> Output)