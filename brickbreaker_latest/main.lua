local composer = require( "composer" )
local widget = require("widget");

local scene = composer.newScene()

  local startBtn = widget.newButton(
    {
      x = 270,
      y = 675,
      id = "button1",
      label = "Start Game ",
      fontSize = 50,
      font = "Monotype Corsiva",
      labelColor = {default = {1,1,1}, over = {0,0,0,.5}},
      width = 250,
      height = 70,
      defaultFile = "startbutton.png",
      onEvent = handleButtonEvent
    })



local options = 
{ 
  effect = "slideLeft",
  time = 600 
}
--------------DIsplay a background image for the start screen--------------

local bg = display.newImage ("background.png", display.contentCenterX, display.contentCenterY);
bg.xScale = display.contentWidth / bg.width;
bg.yScale = display.contentHeight / bg.height;

bg:toBack();





--------------creatin a tapped event so when the user taps on the start text the game should go to the next screen(level chooser )--------------
local function tapped(event)
	--name:removeSelf( )
    startBtn:removeSelf( )
    bg:removeSelf( )
    startBtn:removeEventListener('tap', tapped)
  	composer.gotoScene("scene1", options);
end

----event listener is added which will take the user to level chooser screen --------------
startBtn:addEventListener( 'tap', tapped );