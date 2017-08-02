
--for level2
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



------------------------------------------------------------------------
--for Level 3

local options =
{
  frames = {
    { x = 5, y = 221, width = 61, height = 62}, --smile  face frame 1
    {x = 150, y = 149, width = 61, height = 62}, --sad face frame 2
    {x = 149, y = 221, width = 61, height = 61}, --crying face frame 3
    {x = 220, y = 149, width = 62, height = 65}, --ball horror frame 4
    {x = 7, y = 4, width = 59, height = 62}, --ball angry frame 5

  }
};
local sheet = graphics.newImageSheet( "image.png", options );

-- Create animation sequence for alex kid
local seqData = {
  {name = "smile", frames={1}},
  {name = "sad", frames={2}},
   {name = "crying", frames={3}},
    {name = "horror", frames={4}},
   {name = "angry", frames={5}},
}
