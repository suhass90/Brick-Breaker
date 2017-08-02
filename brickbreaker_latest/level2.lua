local composer = require( "composer" );
composer.removeScene( "level2", true )
local scene = composer.newScene();
local widget = require( "widget" );
local physics = require( "physics" )
local soundTable=require("soundTable");
--local storyboard = require ("storyboard");
local Brick = require ("Brick");--Referring to class Enemy
local Powerup = require ("Powerup");
local box1
--------------declare a vairable paddle fro creating the paddle--------------
local paddle
local levelcomplete=0
local t1
local t5
box ={}
local count = 0
local backgroundMusicChannel
local ball1
local btnOpt =
{
  frames =
  {
    { x = 3, y = 2, width=70, height = 22}, --frame 1
    { x = 78, y = 2, width=70, height = 22}, --frame 2
  }
};

local buttonSheet = graphics.newImageSheet( "button.png", btnOpt );

local options =
{
  frames = {
    { x = 150, y = 78, width = 60, height = 60}, --red heart frame 1
    {x = 75, y = 5, width = 66, height = 61}, --red broken heart frame 2

  }
};
local sheet = graphics.newImageSheet( "image.png", options );

-- Create animation sequence for alex kid
local seqData = {
  {name = "heart", frames={1}},
  {name = "brokenHeart", frames={2}},
}

local options =
{
  frames = {
    { x = 78, y = 331, width = 108, height = 109}, --red frame 1
  }
};
local sheet1 = graphics.newImageSheet( "ball2.png", options );

-- Create animation sequence for alex kid
local sequenceData = {
  {name = "ball",frames={1}},

}













function scene:create( event )
	local sceneGroup = self.view;
    	local bg = display.newImage ("bg4.jpg", display.contentCenterX, display.contentCenterY);
        bg.xScale = display.contentWidth / bg.width;
        bg.yScale = display.contentHeight / bg.height;
    	sceneGroup:insert( bg)
end

-- "scene:show()"
function scene:show( event )

  local sceneGroup = self.view;
  local phase = event.phase;

  	if ( phase == "will" ) then

--fadein means that it starts at low volume getting higher
--end
  	elseif ( phase == "did" ) then
      function startgame()
      audio.loadStream("POL-clockwork-tale-short.wav")
      --function playbgmusic()
    --set loops = -1 to loop infinitely
     backgroundMusicChannel = audio.play( soundTable["level2bg"], { channel=1, loops=-1}  )
    --end
    --playbgmusic()
    		--------------Display the hits and record the count when the boxes are hit--------------
  			local show = display.newEmbossedText ( {text = "hit:0", x=display.contentCenterX-50,y=100, "Comic Sans MS", 60});
  			show:setFillColor( 1,0,0 );
  			--------------Display the life value and record the count when the ball hits the bottom of the screen--------------
  			local show1= display.newEmbossedText ( {text = "life:3", x=display.contentCenterX+50,y=100, "Comic Sans MS", 60});
  			show1:setFillColor( 1,0,0 );
  			--------------Display which level the player is currently in--------------
            local name1 = display.newEmbossedText( "Level2", 360, 30, native.systemFont, 60 );
             name1:setFillColor( 0.5,0,0 );

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

			physics.setDrawMode('normal');
			physics.setGravity(0,0);

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





 local ball1 = display.newSprite( sheet1, sequenceData );
ball1.xScale = .6;
ball1.yScale = .6;
      ball1:setSequence('ball');
      ball1.x=display.contentCenterX
      ball1.y=display.contentCenterY-50
      --ball1.strokeWidth = 10
			--ball1:setFillColor(1, 1, 1)
			--ball1:setStrokeColor(0,1,0)
			--------------make the ball dynamic--------------
			physics.addBody (ball1, "dynamic", {bounce=1, radius=20} );

			--------------apply some force on the ball--------------
			ball1:applyForce(1.05,11,ball1.x,ball1.y);


----------------------------------------boxes creation----------------------------------------
		--local box = { };
		local grey = 0;
		local yellow = 0;
		local red = 0;
		local blue = 0;
		local hit = 0

		--------------create a collision for the box--------------
		local function BoxCollision( event)
		if ( event.phase == "began" ) then
			--------------if the ball hits the yellow box then go throught the for loop and change the colors of the blue to red and change the color of the red boxes--------------
			--------------to blue and remove the yellow boxes--------------
			--[[if (event.other.id =="yellow") then
				for row= 1,4 do
					for coloumn = 1,6 do
							event.other:removeSelf()
						 	if (box[row][coloumn].id == "blue") then
								box[row][coloumn]:setFillColor(1,0,0);
								box[row][coloumn].id="red"
							elseif (box[row][coloumn].id == "red") then
								box[row][coloumn]:setFillColor(0,0,1);
								box[row][coloumn].id="blue"
							end
					end
				end]]
			--------------if the ball hits the blue box then make the blue box red and increment the hit count--------------
			--elseif (event.other.id == "blue") then
				--event.other:setFillColor(1,0,0);
				--event.other.id="red"
        if(event.other.tag=="box") then
        print (event.other.HP);
        if(event.other.HP ~= nil) then
        if(event.other.HP>1) then
            event.other:setSequence("brokenHeart");
            audio.play( soundTable["heartbreak"] );
          if(event.other.id=="grey") then
            event.other:setFillColor(0,0.75,0);
          elseif (event.other.id=="red") then
            event.other:setFillColor(0.75,0,0);
          elseif (event.other.id=="blue") then
            event.other:setFillColor(0,0,0.75);
          else
            event.other:setFillColor(0.75,0.75,0);
          end
          event.other.HP=event.other.HP-1
          --event.other:setFillColor(0.25,0.5,0.75)
        else
          event.other.pp:hit(event.other);
          count=count+1
        end
    end
        hit = hit + 1;
				show.text = "Hit:" .. hit;
        if (count==30) then
          levelcomplete=1
          audio.stop( backgroundMusicChannel );
          --if(ball1 and ball1.removeself) then
            --ball1:removeEventListener( "collision", BoxCollision)
            ball1:removeSelf()
            --ball1=nil
          --end
          paddle:removeSelf()
          show:removeSelf()
          show1:removeSelf()
          name1:removeSelf()
          --ball1=nil
          local function level(event)
    				--if()
            composer.removeScene( "level2", false )
            composer.gotoScene( "level3",{effect="slideLeft",time=500});
          end
    				-------------add a button level2 on the level 1 screen so if the player doesnt want to play level 1 then he can directly skip to level 2-------------




            timer.performWithDelay( 2000, function()
              finalscore=hit*200
            lvl2 = widget.newButton( {
    						--x=display.contentCenterX, y=50
                          x = 350,
                          y = 675,
    	                   id = "lvl2",
    	                    label = "        Score:  " .. finalscore.."\nYou are almost there!!!!\n         Level 3",

    	                    fontSize = 60,
    	                     font = "Monotype Corsiva",
    	                    labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
    	                          width = 550,
                            height = 250,
                            defaultFile = "startbutton.png",
    	                  --  sheet = buttonSheet,
    	                    --defaultFrame = 1,
    	                    --overFrame = 2,
    	                    onEvent = level,
    	            } )
                sceneGroup:insert(lvl2)
                end,1)









                  --
          --[[ball1:removeSelf()
          Runtime:removeEventListener("touch", move);
          paddle:removeSelf()
          timer.cancel(t6);
          composer.removeScene( "level1", false )
          composer.gotoScene( "level2",{effect="slideLeft",time=500});
          scene:removeEventListener( "create", scene )
          scene:removeEventListener( "show", scene )
          sceneGroup:removeSelf()]]
        end
      end
			--------------if  the ball hits the red box then remove the red box--------------
			--[[elseif  (event.other.id == "red") then
			    event.other:removeSelf()
			    event.other.id=nil
			    event.other = nil;
			end]]
		end
		end
		ball1:addEventListener( "collision", BoxCollision)

		--------------for the given number of rows and coloumns put a for loop to traverse and create rectangles for the given positions--------------
		--------------make the boxes kinematic--------------
		--------------set the stroke color and width--------------
    local box = Brick:new( {HP=2, fR=720, fT=5000,
    				  bT=5000} );
    box1= Brick:new( {HP=2, fR=720, fT=5000,
    				  bT=5000} );
    box1=display.newSprite(sheet, seqData);
    box1:setSequence("brokenHeart");
    physics.addBody (box1, "static");
    box1:setStrokeColor( 0, 0, 0 );
    box1.strokeWidth = 3;
    box1.tag="box";
    box1.HP=1;
    --self.shape=box[row][coloumn];
    box1.pp = self;
    box1.row=0;
    box1.coloumn=0;
    box1.isVisible=false
    function box:spawn(row,coloumn)

      box[row][coloumn] = display.newSprite(sheet, seqData);
      box[row][coloumn]:setSequence("heart");
      box_placement={x=display.contentWidth-(60*6)/2-500,y=display.contentHeight/2-450}
      box[row][coloumn].x=box_placement.x+(coloumn * 60) ;
      box[row][coloumn].y=box_placement.y +(row*60);
      --box[row][coloumn].shape=self.shape;
      physics.addBody (box[row][coloumn], "static");
      box[row][coloumn]:setStrokeColor( 0, 0, 0 );
      box[row][coloumn].strokeWidth = 3;
      box[row][coloumn].tag="box";
      box[row][coloumn].HP=2;

      box[row][coloumn].pp = self;
      box[row][coloumn].row=row;
      box[row][coloumn].coloumn=coloumn;

  end
  		for row = 1, 3 do
			box[row] = { };
			for coloumn = 1,10 do
				--[[box[row][coloumn] = display.newRect(100*coloumn,300+40*row,100, 40);
				physics.addBody (box[row][coloumn], "kinematic");
				box[row][coloumn]:setStrokeColor( 0, 0, 0 );
				box[row][coloumn].strokeWidth = 3;]]
			-- 	local x
			-- 	while(true) do
        box:spawn(row,coloumn);

			-- 			--print(x)
			-- 			if(x==1 and grey < 6 and row ~=2 and row ~= 4) then
			-- 				break
			-- 			end
			-- 			if(x==2 and yellow < 2 ) then
			-- 				break
			-- 			end
			-- 			if(x==3 and blue < 8) then
			-- 				break
			-- 			end
			-- 			if(x==4 and red < 8) then
			-- 				break
			-- 			end
			-- 	end
			-- 	print(x)

			-- 				if(x==1) then
			-- 					box[row][coloumn]:setFillColor(0,1,0);
			-- 					grey = grey + 1;
			-- 				elseif(x==2) then
			-- 					box[row][coloumn]:setFillColor(1,1,0);
			-- 					yellow = yellow + 1
			-- 				elseif(x==3) then
			-- 					box[row][coloumn]:setFillColor(0,0,1);
			-- 					blue = blue + 1;
			-- 				else
			-- 					box[row][coloumn]:setFillColor(1,0,0);
			-- 					red = red + 1;
			-- 				end

			--------------create a local variable x and make it random to select the choices--------------
				x = math.random(1,4);
				--------------if the row number is three fill thea coloums with the remaining grey color--------------
					if (row == 3) then
						if(coloumn == grey) then
							x=1
						end
					end



				--------------if the value of x is 1 and the grey color is less than 6 and the row is not 2 or 4 then fill grey color to the boxes and increment the value for grey--------------
				if(x == 1 and grey < 6 and row ~=2 and row ~= 4)  then
					box[row][coloumn]:setFillColor(0,1,0);
					grey = grey + 1;
					box[row][coloumn].id ="grey"
					--print(grey)
				--------------if the value of x is 2 and the yellow color is less than 2 and  then fill yellow color to the boxes and increment the value for yellow--------------
				elseif(x == 2 and yellow <2) then
					box[row][coloumn]:setFillColor(1,1,0);
					yellow = yellow + 1;
					box[row][coloumn].id ="yellow"
				--------------if the value of x is 3 and the blue color is less than 8 and  then fill blue color to the boxes and increment the value for blue--------------
				elseif(x == 3 and blue < 8)  then
					box[row][coloumn]:setFillColor(0,0,1);
					blue = blue + 1;
					box[row][coloumn].id ="blue"
				--------------if the value of x is 4 and the red color is less than 8 and  then fill red color to the boxes and increment the value for red--------------
				elseif(x == 4 and red < 8) then
					box[row][coloumn]:setFillColor(1,0,0);
					red = red + 1;
					box[row][coloumn].id ="red"
				else
					if(x == 1)	then
						--------------if the value of x is 1 and the grey color is less than 6 and the row is not 2 or 4 then fill grey color to the boxes and increment the value for grey--------------
						if(grey < 6  and row ~=2 and row ~= 4) then
						box[row][coloumn]:setFillColor(0,1,0)
						grey = grey + 1
						box[row][coloumn].id ="grey"
						--------------if the value of x is 1 and the blue color is less than 8 and  then fill blue color to the boxes and increment the value for blue--------------
						elseif(blue < 8) then
						box[row][coloumn]:setFillColor(0,0,1)
						blue = blue + 1
						box[row][coloumn].id ="blue"
						--------------if the value of x is 1 and the red color is less than 8 and  then fill red color to the boxes and increment the value for red--------------
						elseif(red < 8) then
						box[row][coloumn]:setFillColor(1,0,0)
						red = red + 1
						box[row][coloumn].id ="red"
						end
					elseif(x == 2) then
						--------------if the value of x is 2 and the yellow color is less than 2 and  then fill yellow color to the boxes and increment the value for yellow--------------
						if(yellow < 2) then
						box[row][coloumn]:setFillColor(1,1,0)
						yellow = yellow + 1
						box[row][coloumn].id ="yellow"
						--------------if the value of x is 2 and the blue color is less than 8 and  then fill blue color to the boxes and increment the value for blue--------------
						elseif(blue < 8) then
						box[row][coloumn]:setFillColor(0,0,1)
						blue = blue + 1
						box[row][coloumn].id ="blue"
						--------------if the value of x is 2 and the red color is less than 8 and  then fill red color to the boxes and increment the value for red--------------
						elseif(red < 8) then
						box[row][coloumn]:setFillColor(1,0,0)
						red = red + 1
						box[row][coloumn].id ="red"
						end
					elseif(x == 3) then
						--------------if the value of x is 3 and the yellow color is less than 2 and  then fill yellow color to the boxes and increment the value for yellow--------------
						if(yellow < 2) then
						box[row][coloumn]:setFillColor(1,1,0)
						yellow = yellow + 1
						box[row][coloumn].id ="yellow"
						--------------if the value of x is 3 and the grey color is less than 6 and the row is not 2 or 4 then fill grey color to the boxes and increment the value for grey--------------
						elseif(grey < 6  and row ~=2 and row ~= 4) then
						box[row][coloumn]:setFillColor(0,1,0)
						grey = grey + 1
						box[row][coloumn].id ="grey"
						--------------if the value of x is 3 and the red color is less than 8 and  then fill red color to the boxes and increment the value for red--------------
						elseif(red < 8) then
						box[row][coloumn]:setFillColor(1,0,0)
						red = red + 1
						box[row][coloumn].id ="red"
						end
					elseif(x == 4)	then
						--------------if the value of x is 4 and the yellow color is less than 2 and  then fill yellow color to the boxes and increment the value for yellow--------------
						if(yellow < 2) then
						box[row][coloumn]:setFillColor(1,1,0)
						 yellow = yellow + 1
						 box[row][coloumn].id ="yellow"
						 --------------if the value of x is 4 and the grey color is less than 6 and the row is not 2 or 4 then fill grey color to the boxes and increment the value for grey--------------
						elseif(grey < 6  and row ~=2 and row ~= 4) then
						box[row][coloumn]:setFillColor(0,1,0)
						grey = grey + 1
						box[row][coloumn].id ="grey"
						--------------if the value of x is 4 and the blue color is less than 8 and  then fill blue color to the boxes and increment the value for blue--------------
						elseif(blue < 8) then
						box[row][coloumn]:setFillColor(0,0,1)
						blue = blue + 1
						box[row][coloumn].id ="blue"
						end
					else
						-------------- the grey color is less than 6 and the row is not 2 or 4 then fill grey color to the boxes and increment the value for grey--------------
						if(grey < 6 and row ~=2 and row ~= 4) then
						box[row][coloumn]:setFillColor(0,1,0)
						grey = grey + 1
						box[row][coloumn].id ="grey"
						--------------if the yellow color is less than 2 and  then fill yellow color to the boxes and increment the value for yellow--------------
						elseif(yellow <2) then
						box[row][coloumn]:setFillColor(1,1,0)
						yellow = yellow + 1
						box[row][coloumn].id ="yellow"
						--------------if the red color is less than 8 and  then fill red color to the boxes and increment the value for red--------------
						elseif(red < 8) then
						box[row][coloumn]:setFillColor(1,0,0)
						red = red + 1
						box[row][coloumn].id ="red"
						--------------if the blue color is less than 8 and  then fill blue color to the boxes and increment the value for blue--------------
						elseif(blue < 8) then
						box[row][coloumn]:setFillColor(0,0,1)
						blue = blue + 1
						box[row][coloumn].id ="blue"
						end
					end
				end
			--print(row,coloumn,x)
			sceneGroup:insert(box[row][coloumn])
			end
		end
		--sceneGroup:insert(box[row][coloumn])








	-------create a Paddle and add a move event to it--------

			paddle = display.newRoundedRect (display.contentCenterX, display.contentHeight-100, 175, 30,15);


			paddle.strokeWidth = 3
			paddle:setFillColor(1, 0.843137, 0)
			paddle:setStrokeColor(0.5,0,0)

			physics.addBody( paddle, "kinematic",{bounce=1});





			local function move ( event )
				if event.phase == "began" then
          if(count<30) then
					       paddle.markX = paddle.x
          end
				elseif event.phase == "moved" then
          if(count<30) then
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





			-- local function retry(event)
	  --           if(event.phase == "ended") then
	  --           	-- if (hand ~= nil) then
   --            --       hand:removeSelf();
   --            --       hand = nil
   --            --   	end
	  --           	 local options =
	  --               {
	  --                   effect = "crossFade",
	  --                   params= {ss = "play again lvl1"}
	  --               }

	  --               composer.removeScene( "level1", false )
	  --               composer.gotoScene( "playagain", options)
	  --           end
   --      	end

   --      	Retrybutton = widget.newButton( {
   --                  x = 440,
   --                  y = 50,
   --                  id = "Retrybutton",
   --                  label = "Retry",
   --                  labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
   --                  sheet = buttonSheet,
   --                  defaultFrame = 1,
   --                  overFrame = 2,
   --                  onEvent = retry,
   --          } );

   --          sceneGroup:insert(Retrybutton)






			--------------add a life to the ball so when the ball touches the bottom of the screen the life should be reduced by 1-------------
            local life=3;
			local function ballCollision (event)
				if (event.phase == "began") then
					-- if (event.other == paddle) then
					-- 	bounces=bounces+1;
					-- 	show.text =
					-- 				"Hits: "..bounces;
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
      ball1.xScale = .6;
ball1.yScale = .6;
      ball1.x=display.contentCenterX
      ball1.y=display.contentCenterY-50
      --ball1.strokeWidth = 10
			--ball1:setFillColor(1, 1, 1)
			--ball1:setStrokeColor(0,1,0)
			--------------make the ball dynamic--------------
			physics.addBody (ball1, "dynamic", {bounce=1, radius=20} );

			--------------apply some force on the ball--------------
			 ball1:applyForce(1.05,11,ball1.x,ball1.y)

            ball1:addEventListener( "collision", BoxCollision)
            ball1:addEventListener("collision", ballCollision)

          end,1 );
        end
        end
						if (life == 0) then
						-- paddle:removeEventListener("touch", move)
						-- show:removeSelf()
						-- --paddle:removeSelf()
            if(paddle and paddle.removeSelf)then
             paddle:removeSelf()
            end
            audio.stop( backgroundMusicChannel );
						--ball1:removeSelf()
						 show1:removeSelf()
						      top:removeSelf()
bottom:removeSelf()
left:removeSelf()
right:removeSelf()
             timer.cancel( t1 )
             for row = 1, 3 do
             	for coloumn = 1,10 do
             		if(box[row][coloumn] and box[row][coloumn].removeSelf)then              			
             			box[row][coloumn]:removeSelf();
             			box[row][coloumn]=nil
             		end
             	end
             end
             --ball1:removeEventListener("collision", ballCollision);
             Runtime:removeEventListener("touch", move);
             show:removeSelf()
             show1:removeSelf()
             name1:removeSelf()
             timer.performWithDelay( 2000, function()
               finalscore=hit*200;
          plagain = widget.newButton( {
              --x=display.contentCenterX, y=50
                        x = display.contentCenterX,
                        y = display.contentCenterY,
                       id = "plagain",
                        label = "  You Lose\n     Score:  " ..finalscore.."\n      play again",
                        fontSize = 60,
                         font = "Monotype Corsiva",
                        labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
                              width = 450,
                          height = 300,
                          defaultFile = "startbutton.png",
                      --  sheet = buttonSheet,
                        --defaultFrame = 1,
                        --overFrame = 2,
                        --onEvent = playgain,
                } )
                local function playAgainHandler(myEvent)
                --if(event.phase=='ended')
                composer.removeScene( "level2", false )
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
    txt:setFillColor(1, 0, 0)


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
      ---call to button appear function
    --startgame();
      ----timer for preview
    t6 = timer.performWithDelay(2000, startgame, 1 )
  end
end

  t5 = timer.performWithDelay( 1000, countdown, 4)
  --end;
end

-- "scene:hide()"
--[[function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

    	composer.removeScene( "scene1", false )
    elseif ( phase == "did" ) then
      Runtime:removeEventListener("touch",move);
      timer.cancel(t6);
      sceneGroup:removeSelf()
    	scene:removeEventListener( "create", scene )
        scene:removeEventListener( "show", scene )
    end
end

function scene:destroy( event )

    local sceneGroup = self.view
end]]

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
--scene:addEventListener( "hide", scene )
--scene:addEventListener( "destroy", scene )



return scene;
