local composer = require( "composer" );
composer.removeScene( "level1", true )
local scene = composer.newScene();
local widget = require( "widget" );--To make use of widgets
local physics = require( "physics" )--To use physics
local soundTable=require("soundTable");--Referring to class soundTable
local Brick = require ("Brick");--Referring to class Brick
local paddle--declare a vairable paddle fro creating the paddle.
local levelcomplete=0--To check for level completion.
local t1
local t5
box ={}--Placeholder for bricks
local backgroundMusicChannel--To play music in the background while playing.


--*******************************************************************************************
-------------------------------------------------------------------------------------------
--Implementing sprite to display bricks
local options =
{
  frames = {
    { x = 76, y = 0, width = 72, height = 69}, --red frame 1
    { x = 153, y = 78, width = 72, height = 69}, --yellow frame 2
    { x = 153, y = 0, width = 72, height = 69}, --grey frame 3
    { x = 0, y = 77, width = 72, height = 69}, --blue frame 4
    { x = 74, y = 209, width = 100, height = 30}, --special frame 5
  }
};
local sheet = graphics.newImageSheet( "bk.jpg", options );

local seqData = {
  {name = "red", frames={1}},
  {name = "yellow", frames={2}},
  {name = "blue", frames={4}},
  {name = "grey", frames={3}},
  {name = "special", frames={5}},
}


-------------------------------------------------------------------------------------------
--Implementing sprite to display ball
local options =
{
  frames = {
    { x = 15, y = 6, width = 72, height = 70}, --red frame 1
  }
};
local sheet1 = graphics.newImageSheet( "ball_2.png", options );


local sequenceData = {
  {name = "ball",frames={1}},

}


-------------------------------------------------------------------------------
--*******************************************************************************************


function scene:create( event )
	local sceneGroup = self.view;
	local bg = display.newImage ("bg6.jpg", display.contentCenterX, display.contentCenterY);
	bg.xScale = display.contentWidth / bg.width;
	bg.yScale = display.contentHeight / bg.height;
	sceneGroup:insert( bg)
end

function scene:show( event )

  local sceneGroup = self.view;
  local phase = event.phase;

  	if ( phase == "will" ) then

  	elseif ( phase == "did" ) then
      function startgame()
		audio.loadStream("POL-clockwork-tale-short.wav")
		backgroundMusicChannel = audio.play( soundTable["bgscore"], { channel=1, loops=-1}  )
		--------------Display the hits and record the count when the boxes are hit--------------
		local show = display.newEmbossedText ( {text = "hit:0", x=display.contentCenterX-50,y=100, "Comic Sans MS", 60});
		show:setFillColor( 0,0,1 );
		--------------Display the life value and record the count when the ball hits the bottom of the screen--------------
		local show1= display.newEmbossedText ( {text = "life:3", x=display.contentCenterX+50,y=100, "Comic Sans MS", 60});
		show1:setFillColor( 0,0,1 );
		--------------Display which level the player is currently in--------------
		local name1 = display.newEmbossedText( "Level1", 360, 30, native.systemFont, 60 );
		name1:setFillColor( 0,0,1 );

		local color =
		{
			highlight = {0,1,1},
			shadow = {0,1,1}
		}
		name1:setEmbossColor( color );
		show:setEmbossColor( color );
		show1:setEmbossColor( color );


		--------------insert the objects creted to the scene group--------------
		sceneGroup:insert(name1)
		sceneGroup:insert(show)
		sceneGroup:insert(show1)
		--------------Apply physics to the objects created--------------
		physics.start();

		--physics.setDrawMode('hybrid');
		physics.setGravity(0,0);

		--------------Creating a playing area for the game--------------
		local top = display.newRect(0,150,display.contentWidth, 20);
		top:setFillColor( 0, 0, 0 )
		local left = display.newRect(0,0,20, display.contentHeight);
		left:setFillColor( 0, 0, 0 )
		local right = display.newRect(display.contentWidth- 20,0,20,display.contentHeight);
		right:setFillColor( 0, 0, 0 )
		local bottom = display.newRect(0,display.contentHeight-20, display.contentWidth, 20);
		bottom:setFillColor( 0, 0, 0 )
		top.anchorX = 0;top.anchorY = 0;
		left.anchorX = 0;left.anchorY = 0;
		right.anchorX = 0;right.anchorY = 0;
		bottom.anchorX = 0;bottom.anchorY = 0;
		physics.addBody( bottom, "static" );
		physics.addBody( left, "static" );
		physics.addBody( right, "static" );
		physics.addBody( top, "static" );

		--------------Creation of ball using imagesheet and applying physics-----------
		local ball1 = display.newSprite( sheet1, sequenceData );
		ball1:setSequence('ball');
		ball1.x=display.contentCenterX
		ball1.y=display.contentCenterY-50
		--------------make the ball dynamic--------------
		physics.addBody (ball1, "dynamic", {bounce=1, radius=20} );

		--------------apply some force on the ball--------------
		ball1:applyForce(1,10,ball1.x,ball1.y);

---------------------------------------boxes creation----------------------------------------
		--local box = { };
		local grey = 0;
		local yellow = 0;
		local red = 0;
		local blue = 0;
		local hit = 0

		--------------create a collision for the box--------------
		local function BoxCollision( event)
		if ( event.phase == "began" ) then
        if(event.other.tag=="box") then
				hit = hit + 1;
				show.text = "Hit:" .. hit;
        event.other.pp:hit(event.other);
        ----------------Checking for level completion--------------
        if (hit==24) then
          Runtime:removeEventListener("touch", move);
          levelcomplete=1
          audio.stop( backgroundMusicChannel );
          ball1:removeSelf()
          paddle:removeSelf()
          ball1=nil
          show:removeSelf()
          show1:removeSelf()
          name1:removeSelf()
          ---------To go to next level after clearing all the bricks in level 1-------
          local function level(event)
            composer.removeScene( "level1", false )
            composer.gotoScene( "level2",{effect="slideLeft",time=500});
          end

            timer.performWithDelay( 2000, function()
              finalscore=hit*100
            lvl2 = widget.newButton( {
    						--x=display.contentCenterX, y=50
                          x = 370,
                          y = 675,
    	                   id = "lvl2",
    	                    label = "Score:  " .. finalscore.."\nWay to Go!!!!\n      Level 2",
    	                    fontSize = 60,
    	                     font = "Monotype Corsiva",
    	                    labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
    	                          width = 450,
                            height = 300,
                            defaultFile = "startbutton.png",
    	                  --  sheet = buttonSheet,
    	                    --defaultFrame = 1,
    	                    --overFrame = 2,
    	                    onEvent = level,
    	            },
    	            {
    						--x=display.contentCenterX, y=50
                          x = 370,
                          y = 475,
    	                   id = "lvl2",
    	                    label = "Score:" .. hit .."hits" ,
    	                    fontSize = 60,
    	                     font = "Monotype Corsiva",
    	                    labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
    	                          width = 350,
                            height = 150,
                            defaultFile = "startbutton.png",
    	                  --  sheet = buttonSheet,
    	                    --defaultFrame = 1,
    	                    --overFrame = 2,
    	                    onEvent = level,
    	            }
    	             )
                sceneGroup:insert(lvl2)
                end,1)


show.text = "Hit:" .. hit;

        end
      end
		end
		end
		ball1:addEventListener( "collision", BoxCollision)

		--------------for the given number of rows and coloumns put a for loop to traverse and create rectangles for the given positions--------------
		--------------make the boxes kinematic--------------
		--------------set the stroke color and width--------------
    local box = Brick:new( {HP=1, fR=720, fT=5000,
    				  bT=5000} );
--Overriding function spawn of class brick to create boxes for level 1
    function box:spawn(row,coloumn)

			box[row][coloumn] = display.newSprite(sheet, seqData);

				  if (row==0) then
			      	box[row][coloumn]:setSequence("grey");
			      	box_placement={x=display.contentWidth-(72*6)/2-300,y=display.contentHeight/2-400}
			      	box[row][coloumn].x=box_placement.x+(coloumn * 72) ;
				  box[row][coloumn].y=box_placement.y +(row*69);
        elseif(row==1) then
			        box[row][coloumn]:setSequence("blue");
			        box_placement={x=display.contentWidth-(72*6)/2-300,y=display.contentHeight/2-400}
			      	box[row][coloumn].x=box_placement.x+(coloumn * 72) ;
				  box[row][coloumn].y=box_placement.y +(row*69);
        elseif(row==2) then
			      	box[row][coloumn]:setSequence("yellow");
			      	box_placement={x=display.contentWidth-(72*6)/2-300,y=display.contentHeight/2-400}
			      	box[row][coloumn].x=box_placement.x+(coloumn * 72) ;
				      box[row][coloumn].y=box_placement.y +(row*69);
			      else
			      	box[row][coloumn]:setSequence("red");
			      	box_placement={x=display.contentWidth-(72*6)/2-300,y=display.contentHeight/2-400}
			      	box[row][coloumn].x=box_placement.x+(coloumn * 72) ;
				      box[row][coloumn].y=box_placement.y +(row*69);
			      end


				  physics.addBody(box[row][coloumn], "static");
			      box[row][coloumn]:setStrokeColor( 0, 0, 0 );
			      box[row][coloumn].strokeWidth = 3;
			      box[row][coloumn].tag="box";

			      box[row][coloumn].pp = self;

			sceneGroup:insert(box[row][coloumn])

  end
  		for row = 0, 3 do
			box[row] = { };
			for coloumn = 0,5 do

        		box:spawn(row,coloumn);


			end
		end








	-------create a Paddle and add a move event to it--------

			paddle = display.newRoundedRect (display.contentCenterX, display.contentHeight-100, 200, 30, 15);

			paddle.strokeWidth = 3
			paddle:setFillColor(1, 1, 0)
			--paddle:setStrokeColor(1,0,0)

			physics.addBody( paddle, "kinematic",{bounce=1});

----------------------Paddle Movement-----------------------------------------
			local function move ( event )
  				if event.phase == "began" then
            if(hit<24) then
  					       paddle.markX = paddle.x
            end
  				elseif event.phase == "moved" then
            if(hit<24) then
  					local x = (event.x-event.xStart) + paddle.markX;

  					if (x <= 20 + paddle.width/2) then
  						paddle.x = 20+paddle.width/2;
  					elseif (x >= display.contentWidth-20-paddle.width/2) then
  						paddle.x = display.contentWidth-20-paddle.width/2;
  					else
  						paddle.x = x;
  					end
          end
				end
			end

			Runtime:addEventListener("touch", move);
			sceneGroup:insert(paddle)


			--------------Decremeting life by 1 when it goes off screen-------------
            local life=3;
			local function ballCollision (event)
				if (event.phase == "began") then

          if(life>0) then
					if (event.other == bottom) then

						life = life - 1;
            audio.play( soundTable["loselife"] );
            show1.text = "life:" .. life;
						event.target:removeSelf();
            event.target=nil
            if(levelcomplete==0) then
            t1=timer.performWithDelay( 2000, function()

      ball1 = display.newSprite( sheet1, sequenceData );
      ball1:setSequence('ball');
      ball1.x=display.contentCenterX
      ball1.y=display.contentCenterY-50
			--------------make the ball dynamic--------------
			physics.addBody (ball1, "dynamic", {bounce=1, radius=20} );

			--------------apply some force on the ball--------------
			ball1:applyForce(1,10,ball1.x,ball1.y);

            ball1:addEventListener( "collision", BoxCollision)
            ball1:addEventListener("collision", ballCollision)

          end,1 );
        end
        end
        ----------------Check for life---------------------------------
						if (life == 0) then
              audio.stop( backgroundMusicChannel );
						 	show1:removeSelf()
                           	top:removeSelf()
							bottom:removeSelf()
							left:removeSelf()
							right:removeSelf()
						if(paddle and paddle.removeSelf)then
						 paddle:removeSelf()
						end
						if(ball1 and ball1.removeSelf) then
						  ball1:removeEventListener("collision", ballCollision);
						end

             timer.cancel( t1 )
             for row = 0, 3 do
             	for coloumn = 0,5 do
             		if(box[row][coloumn] and box[row][coloumn].removeSelf)then
             			box[row][coloumn]:removeSelf();
             			box[row][coloumn]=nil
             		end
             	end
             end
             show:removeSelf()
             show1:removeSelf()
             name1:removeSelf()
             Runtime:removeEventListener("touch", move);
             timer.performWithDelay( 2000, function()
               finalscore=hit*100;
          plagain = widget.newButton( {
                        x = display.contentCenterX,
                        y = display.contentCenterY,
                       id = "plagain",
                        label = "  You Lose\n     Score:  " .. finalscore.."\n      play again",
                        fontSize = 60,
                         font = "Monotype Corsiva",
                        labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
                              width = 450,
                          height = 300,
                          defaultFile = "startbutton.png",
                } )

          ---------------Creation of Custom event to go back to the level selection scene if the user wants to play again---------------
                local function playAgainHandler(myEvent)
                --if(event.phase=='ended')
                composer.removeScene( "level1", false )
                composer.gotoScene("scene1", { effect="crossFade", time=500 });
                if(myEvent=="ended") then
                plagain:dispatchEvent( myEvent )
                end
                end

                plagain:addEventListener( "tap", playAgainHandler )
                local myEvent={ name="tap", target=plagain}

              sceneGroup:insert(plagain)
              end,1)
						end
					end
				end
			end

			ball1:addEventListener("collision", ballCollision);
	end
end

-----------------------------------Count of 3 so that user gets ready to play the game----------------
local time = 4;
local function countdown()
----removes count i.e 3, 2, 1
  if(time~=0) then
    print("Coming here"..time);
    if(txt ~= nil) then
     txt:removeSelf( )
     txt = nil
    end
    print("Going to display"..time);
    time = time - 1; ----for countdown
    txt = display.newEmbossedText( time, display.contentWidth /2, display.contentHeight /2+20, native.systemFont, 200)
    txt:setFillColor(0, 0, 1)


local color =
{
	highlight = {0,1,1},
	shadow = {0,1,1}
}
txt:setEmbossColor( color );
  end

  if (time == 0) then
    if(txt ~= nil) then
      txt:removeSelf( )

      txt = nil
      timer.cancel(t5);
    end
    t6 = timer.performWithDelay(2000, startgame, 1 )
  end
end

  t5 = timer.performWithDelay( 1000, countdown, 4)
  --end;
end




scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )




return scene;
