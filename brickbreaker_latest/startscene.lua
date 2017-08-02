local composer = require( "composer" )
composer.removeScene( "startscene", true )
local widget = require("widget");

local scene = composer.newScene()


------------Displaying the game name in the main screen when the game is loaded---------------
--name = display.newText( "ARKANOID", display.contentWidth /2, display.contentHeight /2-20, "Monotype Corsiva", 70);
------------filling the color for the text--------------
--name:setFillColor( 0, 0, 1 )
--------------start the game once clicked onthe start text--------------
--start = display.newText( "Start",  display.contentWidth /2 , display.contentHeight /2 +100, "Monotype Corsiva", 60);
--------------color for the start text--------------
--start:setFillColor( 1, 0, 0 )

function scene:create( event )
    local sceneGroup = self.view
    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    --display text on screen
local bg = display.newImage ("background.png", display.contentCenterX, display.contentCenterY);
  bg.xScale = display.contentWidth / bg.width;
 bg.yScale = display.contentHeight / bg.height;

bg:toBack();


sceneGroup:insert(bg)
end


function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        
       -- Called when the scene is still off screen (but is about to come on screen)
    
        
     
    elseif ( phase == "did" ) then


     local function tapped(event)
 
       Runtime:removeEventListener('tap', tapped)
       composer.gotoScene("scene1", options);

     end

        --button to start game

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

        sceneGroup:insert(startBtn)
        --scene change options
        
local options = 
{ 
  effect = "slideLeft",
  time = 600 
}

      --event function to start game

      --runtime event listner is added which will take to first lvl
      startBtn:addEventListener( 'tap', tapped );

        -- Called when the scene is now on screen
        -- Insert code here to make the scene come alive
        -- Example: start timers, begin animation, play audio, etc.
       -- timer.performWithDelay( 3000, showScene2)
    end
end



-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        scene:removeEventListener( "create", scene )
        scene:removeEventListener( "show", scene )
        -- Called immediately after scene goes off screen
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view
    -- Insert code here to clean up the scene
    -- Example: remove display objects, save state, etc.
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene
