local soundTable=require("soundTable");

local Powerup = {tag="Powerup", xPos=0, yPos=0, fR=0, sR=0, bR=0, fT=1000, sT=500, bT	=500};

function Powerup:new (o)    --constructor
  o = o or {};
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function Powerup:spawn()
 self.shape=display.newCircle(self.xPos, self.yPos,15);
 self.shape.pp = self;  -- parent object
 self.shape.tag = self.tag; -- “Powerup”
 self.shape:setFillColor (1,1,0);
 physics.addBody(self.shape, "kinematic");
end


function Powerup:forward ()
   transition.to(self.shape, {x=self.shape.x+100, y=800,
   time=self.fT, rotation=self.fR,
   onComplete= function (obj) self:side() end } );
end

function Powerup:move ()
	self:forward();
end

function Powerup:hit ()
	self.HP = self.HP - 1;
	if (self.HP > 0) then
		audio.play( soundTable["hitSound"] );
		self.shape:setFillColor(0.5,0.5,0.5);

	else
		audio.play( soundTable["explodeSound"] );
		transition.cancel( self.shape );

		if (self.timerRef ~= nil) then
			timer.cancel ( self.timerRef );
		end

		-- die
		self.shape:removeSelf();
		self.shape=nil;
		self = nil;
	end
end



return Powerup
