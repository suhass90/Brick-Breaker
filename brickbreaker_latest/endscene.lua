
--********************************************************************************
-- end Scene of the game to display congrats message and take back to Home screen. 
--********************************************************************************

----------------------End Scene ------------------------
local composer = require( "composer" )
composer.removeScene( "endscene", true )
local scene = composer.newScene();
local widget = require( "widget" );


function scene:create( event ) 
    local sceneGroup = self.view
    --display image
    local bg = display.newImage ("endimage.png", display.contentCenterX, display.contentCenterY);
  
    sceneGroup:insert( bg) 
end



function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then

    --local function back to home screen
    local function goHome(event)
        if (hand ~= nil) then
            hand:removeSelf();
            hand = nil
        end
        composer.removeScene( "endscene", false )
        composer.gotoScene( "startscene", {effect="slideLeft",time=500}) 
    end 


      -- button to get back to home screen
      local restartBtn = widget.newButton(
      {
      x = 162,
      y = 203,
      id = "button1",
      label = "Play Again",
      fontSize = 15,
      font = "Monotype Corsiva",
      labelColor = {default = {0,0,0}, over = {0,0,0,.5}},
      width = 90,
      height = 70,
      defaultFile = "startbutton1.png",
      onEvent = goHome
      })
      
      sceneGroup:insert(restartBtn)
    end
end



function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen
      scene:removeEventListener( "create", scene )
      scene:removeEventListener( "show", scene )
        
    end
end



function scene:destroy( event )

    local sceneGroup = self.view
    -- Called prior to the removal of scene's view
    -- Insert code here to clean up the scene
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene