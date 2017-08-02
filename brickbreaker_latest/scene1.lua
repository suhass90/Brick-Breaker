local composer = require( "composer" )

local scene = composer.newScene()
local widget = require( "widget" )


----- On scene create-----
function scene:create( event )
    local sceneGroup = self.view


    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end

--Function to check for the user selection and make the transition to the level accordingly.
local function onSegmentPress( event )
local target = event.target
print( "Segment Label is:",
target.segmentLabel )
print( "Segment Number is:",
target.segmentNumber )
if(target.segmentLabel=="Easy") then
  composer.removeScene( "level1", false )
  composer.gotoScene("level1", { effect="fade", time=400 });
elseif (target.segmentLabel=="Medium") then
  composer.removeScene( "level2", false )
  composer.gotoScene("level2", { effect="fade", time=400 });
else
  composer.removeScene( "level3", false )
  composer.gotoScene("level3", { effect="fade", time=400 });
end
end

-- On scene show--------------
function scene:show( event )
    local sceneGroup = self.view
    --local phase = event.phase
    if ( event.phase == "will" ) then
      --To display the background image
    	local bg2 = display.newImage ("scene1bg.png", display.contentCenterX, display.contentCenterY);
		  bg2.xScale = display.contentWidth / bg2.width;
      bg2.yScale = display.contentHeight / bg2.height;
      sceneGroup:insert(bg2)
		  bg2:toBack();
		  text = display.newEmbossedText( "Levels",display.contentWidth /2, display.contentHeight /2-110, "Monotype Corsiva", 60  )
		  text:setFillColor( 0, 1, 0)
		  sceneGroup:insert( text )
      local color = 
      {
        highlight = {0,1,0},   
        shadow = {0,1,0}  
      }
      text:setEmbossColor( color );

    elseif ( event.phase == "did" ) then

      --Imagesheet to display the segmented control which will enable the user to select the level he/she wants to play.
      local options = {
        frames =
        {
        { x=0, y=0, width=40, height=68 },
        { x=40, y=0, width=40, height=68 },
        { x=80, y=0, width=40, height=68 },
        { x=122, y=0, width=40, height=68 },
        { x=162, y=0, width=40, height=68 },
        { x=202, y=0, width=40, height=68 },
        { x=245, y=0, width=4, height=68 }
        },
        sheetContentWidth = 250,
        sheetContentHeight = 68
      }
      local segmentSheet = graphics.newImageSheet( "segment.png", options )

      -- Create a custom segmented control
      local segmentedControl = widget.newSegmentedControl(
      {
        left = display.contentWidth/2-225,
        top = display.contentHeight/2 -60,
        sheet = segmentSheet,
        leftSegmentFrame = 1,
        middleSegmentFrame = 2,
        rightSegmentFrame = 3,
        leftSegmentSelectedFrame = 4,
        middleSegmentSelectedFrame = 5,
        rightSegmentSelectedFrame = 6,
        segmentFrameWidth = 40,
        segmentFrameHeight = 68,
        dividerFrame = 7,
        dividerFrameWidth = 4,
        dividerFrameHeight = 68,
        segmentWidth = 150,
        segments = { "Easy", "Medium", "Hard"},
        fontSize = 40,
        defaultSegment = 1,
        labelColor = { default={0,0,0}, over={1,0.3,0.8,1}},
        labelSize =30,
        labelFont = "Monotype Corsiva",
        emboss = true,
        onPress = onSegmentPress
      })
      sceneGroup:insert( segmentedControl )

  end
end
-- On scene hide...
function scene:hide( event )
    local sceneGroup = self.view

    if ( event.phase == "will" ) then


    elseif (event.phase == "did" ) then

    end
end

-- On scene destroy...
function scene:destroy( event )
    local sceneGroup = self.view
end

-- Composer scene listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )



return scene
