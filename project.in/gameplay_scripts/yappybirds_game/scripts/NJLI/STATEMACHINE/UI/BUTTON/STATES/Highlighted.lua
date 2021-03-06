local BaseClass = require "NJLI.STATEMACHINE.NodeEntityState"

local Highlighted = {}
Highlighted.__index = Highlighted

--#############################################################################
--DO NOT EDIT ABOVE
--#############################################################################

--#############################################################################
--Begin Custom Code
--Required local functions:
-- __ctor()
-- __dtor()
-- __load()
-- __unLoad()
--#############################################################################

local __ctor = function(self, init)
  --TODO: construct this Entity
end

local __dtor = function(self)
  --TODO: destruct this Entity
end

local __load = function(self)
  --TODO: load this Entity
end

local __unLoad = function(self)
  --TODO: unload this Entity
end

--############################################################################# 

function Highlighted:enter()
  BaseClass.enter(self)
end

function Highlighted:update(timeStep)
  BaseClass.update(self, timeStep)
end

function Highlighted:exit()
  BaseClass.exit(self)
end

function Highlighted:onMessage()
  BaseClass.onMessage(self)
end

function Highlighted:rayTouchesDown(rayContact)
  BaseClass.rayTouchesDown(self, rayContact)
end

function Highlighted:rayTouchesUp(rayContact)
  BaseClass.rayTouchesUp(self, rayContact)
end

function Highlighted:rayTouchesMove(rayContact)
  BaseClass.rayTouchesMove(self, rayContact)
end

function Highlighted:rayTouchesCancelled(rayContact)
  BaseClass.rayTouchesCancelled(self, rayContact)
end

function Highlighted:rayTouchesMissed(node)
    BaseClass.rayTouchesMissed(self, node)
end

function Highlighted:rayTouchDown(rayContact)
  BaseClass.rayTouchDown(self, rayContact)
end

function Highlighted:rayTouchUp(rayContact)
  BaseClass.rayTouchUp(self, rayContact)
end

function Highlighted:rayTouchMove(rayContact)
  BaseClass.rayTouchMove(self, rayContact)
end

function Highlighted:rayTouchCancelled(rayContact)
  BaseClass.rayTouchCancelled(self, rayContact)
end

function Highlighted:rayTouchMissed(node)
    BaseClass.rayTouchMissed(self, node)
end

function Highlighted:rayMouseDown(rayContact)
  BaseClass.rayMouseDown(self, rayContact)
end

function Highlighted:rayMouseUp(rayContact)
  BaseClass.rayMouseUp(self, rayContact)
end

function Highlighted:rayMouseMove(rayContact)
  BaseClass.rayMouseMove(self, rayContact)
end

function Highlighted:rayMouseMissed(node)
  BaseClass.rayMouseMissed(self, node)
end

function Highlighted:collide(otherNode, collisionPoint)
  BaseClass.collide(self, collisionPoint)
end

function Highlighted:near(otherNode)
  BaseClass.near(self, otherNode)
end

function Highlighted:actionUpdate(action, timeStep)
  BaseClass.actionUpdate(self, timeStep)
end

function Highlighted:actionComplete(action)
  BaseClass.actionComplete(self, action)
end

function Highlighted:keyboardShow()
  BaseClass.keyboardShow(self)
end

function Highlighted:keyboardCancel()
  BaseClass.keyboardCancel(self)
end

function Highlighted:keyboardReturn()
    BaseClass.keyboardReturn(self)
end

function Highlighted:renderHUD()
    BaseClass.renderHUD(self)
end

function Highlighted:gamePause()
    BaseClass.gamePause(self)
end

function Highlighted:gameUnPause()
    BaseClass.gameUnPause(self)
end

function Highlighted:touchesDown(touches)
    BaseClass.touchesDown(self, touches)
end

function Highlighted:touchesUp(touches)
    BaseClass.touchesUp(self, touches)
end

function Highlighted:touchesMove(touches)
    BaseClass.touchesMove(self, touches)
end

function Highlighted:touchesCancelled(touches)
    BaseClass.touchesCancelled(self, touches)
end

function Highlighted:touchDown(touch)
    BaseClass.touchDown(self, touch)
end

function Highlighted:touchUp(touch)
    BaseClass.touchUp(self, touch)
end

function Highlighted:touchMove(touch)
    BaseClass.touchMove(self, touch)
end

function Highlighted:touchCancelled(touch)
    BaseClass.touchCancelled(self, touch)
end

function Highlighted:mouseDown(mouse)
    BaseClass.mouseDown(self, mouse)
end

function Highlighted:mouseUp(mouse)
    BaseClass.mouseUp(self, mouse)
end

function Highlighted:mouseMove(mouse)
    BaseClass.mouseMove(self, mouse)
end

--#############################################################################
--End Custom Code
--#############################################################################

--#############################################################################
--DO NOT EDIT BELOW
--#############################################################################

setmetatable(Highlighted, {
    __index = BaseClass,
    __call = function (cls, ...)
      local self = setmetatable({}, cls)
      --Create the base first
      BaseClass._create(self, ...)
      self:_create(...)
      return self
    end,
  })

function Highlighted:className()
  return "Highlighted"
end

function Highlighted:class()
  return self
end

function Highlighted:superClass()
  return BaseClass
end

function Highlighted:__gc()
  --Destroy derived class first
  Highlighted._destroy(self)
  --Destroy base class after derived class
  BaseClass._destroy(self)
end

function Highlighted:__tostring()
  local ret = self:className() .. " =\n{\n"
  
  for pos,val in pairs(self) do 
    ret = ret .. "\t" .. "["..pos.."]" .. " => " .. type(val) .. " = " .. tostring(val) .. "\n"
  end

  ret = ret .. "\n\t" .. tostring_r(BaseClass) .. "\n}"
  return ret .. "\n\t" .. tostring_r(getmetatable(self)) .. "\n}"
end

function Highlighted:_destroy()
  assert(not self.__HighlightedCalledLoad, "Must unload before you destroy")
  __dtor(self)
end

function Highlighted:_create(init)
  self.__HighlightedCalledLoad = false
  __ctor(self, init)
end

function Highlighted:load()
  --load base first
  BaseClass.load(self)

  --load derived last...
  __load(self)

  self.__HighlightedCalledLoad = true
end

function Highlighted:unLoad()
  assert(self.__HighlightedCalledLoad, "Must load before unloading")

  --unload derived first...
  __unLoad(self)
  self.__HighlightedCalledLoad = false

  --unload base last...
  BaseClass.unLoad(self)
end

return Highlighted
