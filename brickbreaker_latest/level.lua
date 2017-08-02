local composer = require( "composer" );
composer.removeScene( "level2", true )
local scene = composer.newScene();
local widget = require( "widget" );
local physics = require( "physics" )
local soundTable=require("soundTable");
--------------declare a vairable paddle for creating the paddle--------------
local paddle


local btnOpt =
{
  frames =
  {
    { x = 3, y = 2, width=70, height = 22}, --frame 1
    { x = 78, y = 2, width=70, height = 22}, --frame 2
  }
};

local buttonSheet = graphics.newImageSheet( "button.png", btnOpt );


function scene:create( event )
	local sceneGroup = self.view;

		local bg = display.newImage ("bg4.jpg", display.contentCenterX, display.contentCenterY);
    	sceneGroup:insert( bg)
end

-- "scene:show()"
function scene:show( event )

  local sceneGroup = self.view;
  local phase = event.phase;

  	if ( phase == "will" ) then

  	elseif ( phase == "did" ) then
  			--------------Display the hits and record the count when the boxes are hit--------------
            local show = display.newText ( {text = "hit:0", x=display.contentCenterX+180,y=50, "Comic Sans MS", 44});
            --------------Display the life value and record the count when the ball hits the bottom of the screen--------------
            local show1= display.newText ( {text = "life:5", x=display.contentCenterX+270,y=50, "Comic Sans MS", 44});
  			name = display.newText( "Level2", 140, 50, "Monotype Corsiva", 70);
			name:setFillColor( 0, 1, 1 )
			sceneGroup:insert(show1)
  		sceneGroup:insert(show)
			sceneGroup:insert(name)
			physics.start();

			physics.setDrawMode(normal);
			physics.setGravity(0,0);


			local bounces=0;


			local top = display.newRect(0,100,display.contentWidth, 20);
			local left = display.newRect(0,0,20, display.contentHeight);
			local right = display.newRect(display.contentWidth- 20,0,20,display.contentHeight);
			local bottom = display.newRect(0,display.contentHeight-20, display.contentWidth, 20);

			top.anchorX = 0;top.anchorY = 0;
			left.anchorX = 0;left.anchorY = 0;
			right.anchorX = 0;right.anchorY = 0;
			bottom.anchorX = 0;bottom.anchorY = 0;

			physics.addBody( bottom, "static" );
			physics.addBody( left, "static" );
			physics.addBody( right, "static" );
			physics.addBody( top, "static" );




			--------------create a ball with the radius and bounce and specify the position where the ball should start from--------------
            local ball = display.newCircle (display.contentCenterX,
            display.contentCenterY-50, 20);
            physics.addBody (ball, "dynamic", {bounce=1, radius=20} );
            --physics.addBody(ball, "dynamic", {density = 1, friction = 0, bounce = 0});

            ball:applyForce(1,10,ball.x,ball.y);

            sceneGroup:insert(ball)
            --------------create a ball with the radius and bounce and specify the position where the ball should start from--------------
            -- local ball2 = display.newCircle (display.contentCenterX,
            -- display.contentCenterY-50, 20);
            -- physics.addBody (ball2, "dynamic", {bounce=1, radius=30} );
            -- --physics.addBody(ball, "dynamic", {density = 1, friction = 0, bounce = 0});

            -- ball2:applyForce(1,25,ball2.x,ball2.y);

            -- sceneGroup:insert(ball2)



----------------------------------------rectangles----------------------------------------
		local box = { };
		local grey = 0;
		local yellow = 0;
		local red = 0;
		local blue = 0;
		local hit = 0

		local function BoxCollision( event)
		if ( event.phase == "ended" ) then
			--------------if the ball hits the yellow star then go throught the for loop and change the colors of the blue to red and change the color of the red stars--------------
            --------------to blue and remove the yellow stars--------------
			if (event.other.id =="yellow") then
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
				end
			 --------------if the ball hits the blue star then make the blue star red and increment the hit count--------------
			elseif (event.other.id == "blue") then
				audio.play( soundTable["shootSound"] );
				event.other:setFillColor(1,0,0);
				event.other.id="red"
				hit = hit + 1;
				show.text = "Hit:" .. hit;
			--------------if the ball hits the red star then make the red star blue and increment the hit count--------------
			elseif  (event.other.id == "red") then
				audio.play( soundTable["explodeSound"] );
			    event.other:removeSelf()
			    event.other.id=nil
			    event.other = nil;
			end
		end
		end
		ball:addEventListener( "collision", BoxCollision)

		-- local function BoxCollision( event)
		-- if ( event.phase == "ended" ) then
		-- 	if (event.other.id =="yellow") then
		-- 		for row= 1,4 do
		-- 			for coloumn = 1,6 do
		-- 					event.other:removeSelf()
		-- 				 	if (box[row][coloumn].id == "blue") then
		-- 						box[row][coloumn]:setFillColor(1,0,0);
		-- 						box[row][coloumn].id="red"
		-- 					elseif (box[row][coloumn].id == "red") then
		-- 						box[row][coloumn]:setFillColor(0,0,1);
		-- 						box[row][coloumn].id="blue"
		-- 					end
		-- 			end
		-- 		end

		-- 	elseif (event.other.id == "blue") then
		-- 		--audio.play( soundTable["shootSound"] );
		-- 		event.other:setFillColor(1,0,0);
		-- 		event.other.id="red"
		-- 		hit = hit + 1;
		-- 		show.text = "Hit:" .. hit;
		-- 	elseif  (event.other.id == "red") then
		-- 		--audio.play( soundTable["explodeSound"] );
		-- 	    event.other:removeSelf()
		-- 	    event.other.id=nil
		-- 	    event.other = nil;
		-- 	end
		-- end
		-- end
		-- ball2:addEventListener( "collision", BoxCollision)






  		for row = 1, 4 do
			box[row] = { };
			for coloumn = 1,6 do
				local vertices = { 0,-90, 17,-25, 95,-25, 33,6, 55,80, 0,35, -55,80, -33,5, -95,-25, -17,-25, }
				box[row][coloumn]= display.newPolygon( 100*coloumn,140+70*row, vertices )
				--box[row][coloumn].fill = { type="image", filename="bg1.jpg" }
				--box[row][coloumn] = display.newRect(100*coloumn,300+40*row,100, 40);
				physics.addBody (box[row][coloumn], "kinematic");
				box[row][coloumn]:setStrokeColor( 0, 0, 0 );
				box[row][coloumn].strokeWidth = 3;
			-- 	local x
			-- 	while(true) do

						x = math.random(1,4);
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
					if (row == 3) then
						if(coloumn == grey+1) then
							x=1
						end
					end



				--------------if the value of x is 1 and the grey color is less than 6 and the row is not 2 or 4 then fill grey color to the stars and increment the value for grey--------------
                if(x == 1 and grey < 6 and row ~=2 and row ~= 4)  then
                    box[row][coloumn]:setFillColor(0.5,0.5,0.5);
                    grey = grey + 1;
                    box[row][coloumn].id ="grey"
                    --print(grey)
                --------------if the value of x is 2 and the yellow color is less than 2 and  then fill yellow color to the stars and increment the value for yellow--------------
                elseif(x == 2 and yellow <2) then
                    box[row][coloumn]:setFillColor(1,1,0);
                    yellow = yellow + 1;
                    box[row][coloumn].id ="yellow"
                --------------if the value of x is 3 and the blue color is less than 8 and  then fill blue color to the stars and increment the value for blue--------------
                elseif(x == 3 and blue < 8)  then
                    box[row][coloumn]:setFillColor(0,0,1);
                    blue = blue + 1;
                    box[row][coloumn].id ="blue"
                --------------if the value of x is 4 and the red color is less than 8 and  then fill red color to the stars and increment the value for red--------------
                elseif(x == 4 and red < 8) then
                    box[row][coloumn]:setFillColor(1,0,0);
                    red = red + 1;
                    box[row][coloumn].id ="red"
                else
                    if(x == 1)  then
                        --------------if the value of x is 1 and the grey color is less than 6 and the row is not 2 or 4 then fill grey color to the stars and increment the value for grey--------------
                        if(grey < 6  and row ~=2 and row ~= 4) then
                        box[row][coloumn]:setFillColor(0.5,0.5,0.5)
                        grey = grey + 1
                        box[row][coloumn].id ="grey"
                        --------------if the value of x is 1 and the blue color is less than 8 and  then fill blue color to the stars and increment the value for blue--------------
                        elseif(blue < 8) then
                        box[row][coloumn]:setFillColor(0,0,1)
                        blue = blue + 1
                        box[row][coloumn].id ="blue"
                        --------------if the value of x is 1 and the red color is less than 8 and  then fill red color to the stars and increment the value for red--------------
                        elseif(red < 8) then
                        box[row][coloumn]:setFillColor(1,0,0)
                        red = red + 1
                        box[row][coloumn].id ="red"
                        end
                    elseif(x == 2) then
                        --------------if the value of x is 2 and the yellow color is less than 2 and  then fill yellow color to the stars and increment the value for yellow--------------
                        if(yellow < 2) then
                        box[row][coloumn]:setFillColor(1,1,0)
                        yellow = yellow + 1
                        box[row][coloumn].id ="yellow"
                        --------------if the value of x is 2 and the blue color is less than 8 and  then fill blue color to the stars and increment the value for blue--------------
                        elseif(blue < 8) then
                        box[row][coloumn]:setFillColor(0,0,1)
                        blue = blue + 1
                        box[row][coloumn].id ="blue"
                        --------------if the value of x is 2 and the red color is less than 8 and  then fill red color to the stars and increment the value for red--------------
                        elseif(red < 8) then
                        box[row][coloumn]:setFillColor(1,0,0)
                        red = red + 1
                        box[row][coloumn].id ="red"
                        end
                    elseif(x == 3) then
                        --------------if the value of x is 3 and the yellow color is less than 2 and  then fill yellow color to the stars and increment the value for yellow--------------
                        if(yellow < 2) then
                        box[row][coloumn]:setFillColor(1,1,0)
                        yellow = yellow + 1
                        box[row][coloumn].id ="yellow"
                        --------------if the value of x is 3 and the grey color is less than 6 and the row is not 2 or 4 then fill grey color to the stars and increment the value for grey--------------
                        elseif(grey < 6  and row ~=2 and row ~= 4) then
                        box[row][coloumn]:setFillColor(0.5,0.5,0.5)
                        grey = grey + 1
                        box[row][coloumn].id ="grey"
                        --------------if the value of x is 3 and the red color is less than 8 and  then fill red color to the stars and increment the value for red--------------
                        elseif(red < 8) then
                        box[row][coloumn]:setFillColor(1,0,0)
                        red = red + 1
                        box[row][coloumn].id ="red"
                        end
                    elseif(x == 4)  then
                        --------------if the value of x is 4 and the yellow color is less than 2 and  then fill yellow color to the stars and increment the value for yellow--------------
                        if(yellow < 2) then
                        box[row][coloumn]:setFillColor(1,1,0)
                         yellow = yellow + 1
                         box[row][coloumn].id ="yellow"
                         --------------if the value of x is 4 and the grey color is less than 6 and the row is not 2 or 4 then fill grey color to the stars and increment the value for grey--------------
                        elseif(grey < 6  and row ~=2 and row ~= 4) then
                        box[row][coloumn]:setFillColor(0.5,0.5,0.5)
                        grey = grey + 1
                        box[row][coloumn].id ="grey"
                        --------------if the value of x is 4 and the blue color is less than 8 and  then fill blue color to the stars and increment the value for blue--------------
                        elseif(blue < 8) then
                        box[row][coloumn]:setFillColor(0,0,1)
                        blue = blue + 1
                        box[row][coloumn].id ="blue"
                        end
                    else
                        -------------- the grey color is less than 6 and the row is not 2 or 4 then fill grey color to the stars and increment the value for grey--------------
                        if(grey < 6 and row ~=2 and row ~= 4) then
                        box[row][coloumn]:setFillColor(0.5,0.5,0.5)
                        grey = grey + 1
                        box[row][coloumn].id ="grey"
                        --------------if the yellow color is less than 2 and  then fill yellow color to the stars and increment the value for yellow--------------
                        elseif(yellow <2) then
                        box[row][coloumn]:setFillColor(1,1,0)
                        yellow = yellow + 1
                        box[row][coloumn].id ="yellow"
                        --------------if the red color is less than 8 and  then fill red color to the stars and increment the value for red--------------
                        elseif(red < 8) then
                        box[row][coloumn]:setFillColor(1,0,0)
                        red = red + 1
                        box[row][coloumn].id ="red"
                        --------------if the blue color is less than 8 and  then fill blue color to the stars and increment the value for blue--------------
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







	-------create a Paddle and add a move event to it--------

            paddle = display.newRect (display.contentCenterX, display.contentHeight-100, 200, 20);
            physics.addBody( paddle, "kinematic",{bounce=1});
            local function move ( event )
                if event.phase == "began" then
                    paddle.markX = paddle.x
                elseif event.phase == "moved" then
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

            Runtime:addEventListener("touch", move);
            sceneGroup:insert(paddle)

             --------------add a life to the ball so when the ball touches the bottom of the screen the life should be reduced by 1-------------
			local life=5;
			local function ballCollision (event)
				if (event.phase == "began") then
					-- if (event.other == paddle) then
					-- 	bounces=bounces+1;
					-- 	show.text =
					-- 				"Hits: "..bounces;

					if (event.other == bottom) then
						show1.text = "life:" .. life;
						life = life - 1;

						if (life == -1) then
						-- paddle:removeEventListener("touch", move)
						-- show:removeSelf()
						-- --paddle:removeSelf()
						 ball:removeSelf()
						 --ball2:removeSelf()
						-- show1:removeSelf()
						composer.removeScene( "level2", false )
            			composer.gotoScene("scene1", { effect="crossFade", time=500 });
	      				-- composer.removeScene( "level2", false )
	          --           composer.gotoScene( "finish", {effect="slideLeft",time=500})
						      -- timer1= timer.performWithDelay( 200, endscreen)
						end
					end
				end
			end

			ball:addEventListener("collision", ballCollision);
			--ball2:addEventListener("collision", ballCollision);





         local function level(event)

				-- paddle:removeSelf()
				ball:removeSelf()
				--ball2:removeSelf()



           		composer.removeScene( "level2", false )

            	composer.gotoScene( "scene1",{effect="slideLeft",time=500});
        	end
				-------------add a button menu on the level 2 screen so if the player doesnt want to play level 2 then he can go to menu ad select the levels-------------
				scene = widget.newButton( {
						--x=display.contentCenterX, y=50
	                    x = 360,
	                    y = 50,
	                    id = "scene",
	                    label = "Menu",
	                    labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
	                    sheet = buttonSheet,
	                    defaultFrame = 1,
	                    overFrame = 2,
	                    onEvent = level,
	            } );
            	sceneGroup:insert(scene)












	end
end

-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

    	composer.removeScene( "scene2", false )
    elseif ( phase == "did" ) then
    	scene:removeEventListener( "create", scene )
        scene:removeEventListener( "show", scene )
    end
end

function scene:destroy( event )

    local sceneGroup = self.view
    if (timer1~= nil) then
            timer.cancel( timer1 )
        end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )



return scene;
