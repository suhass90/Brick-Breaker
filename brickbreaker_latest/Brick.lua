local soundTable=require("soundTable");

local Brick = {tag="Brick", HP=1, xPos=0, yPos=0, fR=0, sR=0, bR=0, fT=1000, sT=500, bT	=500};


--constructor
function Brick:new (o)    
  o = o or {};
  setmetatable(o, self);
  self.__index = self;
  return o;
end


--Function to create new bricks
function Brick:spawn(row,column)
 self.shape=display.newCircle(self.xPos, self.yPos,15);
 self.shape.pp = self;  -- parent object
 self.shape.tag = self.tag; -- “Brick”
 self.shape:setFillColor (1,1,0);
 physics.addBody(self.shape, "kinematic");
end

--Function to check for hit count of the brick
function Brick:hit (obj)
  self.shape=obj
	self.HP = self.HP - 1;
		audio.play( soundTable["hitSound"] );
    print("removing brick");
		self.shape:removeSelf();
		self.shape=nil;
		self = nil;
end


return Brick
