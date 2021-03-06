local BaseClass = require "NJLI.STATEMACHINE.NodeEntity"

local Bird = {}
Bird.__index = Bird

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
  
  print("inside bird node")
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

function Bird:enter()
  BaseClass.enter(self)
end

function Bird:update(timeStep)
  BaseClass.update(self, timeStep)
end

function Bird:exit()
  BaseClass.exit(self)
end

function Bird:onMessage()
  BaseClass.onMessage(self)
end

function Bird:rayTouchesDown(rayContact)
  BaseClass.rayTouchesDown(self, rayContact)
end

function Bird:rayTouchesUp(rayContact)
  BaseClass.rayTouchesUp(self, rayContact)
end

function Bird:rayTouchesMove(rayContact)
  BaseClass.rayTouchesMove(self, rayContact)
end

function Bird:rayTouchesCancelled(rayContact)
  BaseClass.rayTouchesCancelled(self, rayContact)
end

function Bird:rayTouchesMissed(node)
  BaseClass.rayTouchesMissed(self, node)
end

function Bird:rayTouchDown(rayContact)
  BaseClass.rayTouchDown(self, rayContact)
end

function Bird:rayTouchUp(rayContact)
  BaseClass.rayTouchUp(self, rayContact)
end

function Bird:rayTouchMove(rayContact)
  BaseClass.rayTouchMove(self, rayContact)
end

function Bird:rayTouchCancelled(rayContact)
  BaseClass.rayTouchCancelled(self, rayContact)
end

function Bird:rayTouchMissed(node)
  BaseClass.rayTouchMissed(self, node)
end

function Bird:rayMouseDown(rayContact)
  BaseClass.rayMouseDown(self, rayContact)
end

function Bird:rayMouseUp(rayContact)
  BaseClass.rayMouseUp(self, rayContact)
end

function Bird:rayMouseMove(rayContact)
  BaseClass.rayMouseMove(self, rayContact)
end

function Bird:rayMouseMissed(node)
  BaseClass.rayMouseMissed(self, node)
end

function Bird:collide(otherNode, collisionPoint)
  BaseClass.collide(self, otherNode, collisionPoint)
end

function Bird:near(otherNode)
  BaseClass.near(self, otherNode)
end

function Bird:actionUpdate(action, timeStep)
  BaseClass.actionUpdate(self, action, timeStep)
end

function Bird:actionComplete(action)
  BaseClass.actionComplete(self, action)
end

function Bird:keyboardShow()
  BaseClass.keyboardShow(self)
end

function Bird:keyboardCancel()
  BaseClass.keyboardCancel(self)
end

function Bird:keyboardReturn()
  BaseClass.keyboardReturn(self)
end

function Bird:renderHUD()
  BaseClass.renderHUD(self)
end

function Bird:gamePause()
  BaseClass.gamePause(self)
end

function Bird:gameUnPause()
  BaseClass.gameUnPause(self)
end

function Bird:touchesDown(touches)
  BaseClass.touchesDown(self, touches)
end

function Bird:touchesUp(touches)
  BaseClass.touchesUp(self, touches)
end

function Bird:touchesMove(touches)
  BaseClass.touchesMove(self, touches)
end

function Bird:touchesCancelled(touches)
  BaseClass.touchesCancelled(self, touches)
end

function Bird:touchDown(touch)
  BaseClass.touchDown(self, touch)
end

function Bird:touchUp(touch)
  BaseClass.touchUp(self, touch)
end

function Bird:touchMove(touch)
  BaseClass.touchMove(self, touch)
end

function Bird:touchCancelled(touch)
  BaseClass.touchCancelled(self, touch)
end

function Bird:mouseDown(mouse)
  BaseClass.mouseDown(self, mouse)
end

function Bird:mouseUp(mouse)
  BaseClass.mouseUp(self, mouse)
end

function Bird:mouseMove(mouse)
  BaseClass.mouseMove(self, mouse)
end

--#############################################################################
--End Custom Code
--#############################################################################

--#############################################################################
--DO NOT EDIT BELOW
--#############################################################################

setmetatable(Bird, {
    __index = BaseClass,
    __call = function (cls, ...)
      local self = setmetatable({}, cls)
      --Create the base first
      BaseClass._create(self, ...)
      self:_create(...)
      return self
    end,
  })

function Bird:className()
  return "Bird"
end

function Bird:class()
  return self
end

function Bird:superClass()
  return BaseClass
end

function Bird:__gc()
  --Destroy derived class first
  Bird._destroy(self)
  --Destroy base class after derived class
  BaseClass._destroy(self)
end

function Bird:__tostring()
  local ret = self:className() .. " =\n{\n"

  for pos,val in pairs(self) do
    ret = ret .. "\t" .. "["..pos.."]" .. " => " .. type(val) .. " = " .. tostring(val) .. "\n"
  end

  ret = ret .. "\n\t" .. tostring_r(BaseClass) .. "\n}"
  return ret .. "\n\t" .. tostring_r(getmetatable(self)) .. "\n}"
end

function Bird:_destroy()
  assert(not self.__BirdCalledLoad, "Must unload before you destroy")
  __dtor(self)
end

function Bird:_create(init)
  self.__BirdCalledLoad = false
  __ctor(self, init)
end

function Bird:load()
  --load base first
  BaseClass.load(self)

  --load derived last...
  __load(self)

  self.__BirdCalledLoad = true
end

function Bird:unLoad()
  assert(self.__BirdCalledLoad, "Must load before unloading")

  --unload derived first...
  __unLoad(self)
  self.__BirdCalledLoad = false

  --unload base last...
  BaseClass.unLoad(self)
end

return Bird
