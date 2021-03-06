local BaseClass = require "NJLI.STATEMACHINE.NodeEntityState"

local Default = {}
Default.__index = Default

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
--Default Specific
--#############################################################################

--#############################################################################
--NodeEntityState overwrite
--#############################################################################

function Default:enter()
    BaseClass.enter(self)
end

function Default:update(timeStep)
  BaseClass.update(self, timeStep)
end

function Default:exit()
  BaseClass.exit(self)
end

function Default:onMessage()
  BaseClass.onMessage(self)
end

function Default:rayTouchesDown(rayContact)
  BaseClass.rayTouchesDown(self, rayContact)
end

function Default:rayTouchesUp(rayContact)
  BaseClass.rayTouchesUp(self, rayContact)
end

function Default:rayTouchesMove(rayContact)
  BaseClass.rayTouchesMove(self, rayContact)
end

function Default:rayTouchesCancelled(rayContact)
  BaseClass.rayTouchesCancelled(self, rayContact)
end

function Default:rayTouchesMissed(node)
    BaseClass.rayTouchesMissed(self, node)
end

function Default:rayTouchDown(rayContact)
  BaseClass.rayTouchDown(self, rayContact)
end

function Default:rayTouchUp(rayContact)
  BaseClass.rayTouchUp(self, rayContact)
end

function Default:rayTouchMove(rayContact)
  BaseClass.rayTouchMove(self, rayContact)
end

function Default:rayTouchCancelled(rayContact)
  BaseClass.rayTouchCancelled(self, rayContact)
end

function Default:rayTouchMissed(node)
    BaseClass.rayTouchMissed(self, node)
end

function Default:rayMouseDown(rayContact)
  BaseClass.rayMouseDown(self, rayContact)
end

function Default:rayMouseUp(rayContact)
  BaseClass.rayMouseUp(self, rayContact)
end

function Default:rayMouseMove(rayContact)
  BaseClass.rayMouseMove(self, rayContact)
end

function Default:rayMouseMissed(node)
  BaseClass.rayMouseMissed(self, node)
end

function Default:collide(otherNode, collisionPoint)
  BaseClass.collide(self, collisionPoint)
end

function Default:near(otherNode)
  BaseClass.near(self, otherNode)
end

function Default:actionUpdate(action, timeStep)
  BaseClass.actionUpdate(self, timeStep)
end

function Default:actionComplete(action)
  BaseClass.actionComplete(self, action)
end

function Default:keyboardShow()
  BaseClass.keyboardShow(self)
end

function Default:keyboardCancel()
  BaseClass.keyboardCancel(self)
end

function Default:keyboardReturn()
    BaseClass.keyboardReturn(self)
end

function Default:renderHUD()
    BaseClass.renderHUD(self)
end

function Default:gamePause()
    BaseClass.gamePause(self)
end

function Default:gameUnPause()
    BaseClass.gameUnPause(self)
end

function Default:touchesDown(touches)
    BaseClass.touchesDown(self, touches)
end

function Default:touchesUp(touches)
    BaseClass.touchesUp(self, touches)
end

function Default:touchesMove(touches)
    BaseClass.touchesMove(self, touches)
end

function Default:touchesCancelled(touches)
    BaseClass.touchesCancelled(self, touches)
end

function Default:touchDown(touch)
    BaseClass.touchDown(self, touch)
end

function Default:touchUp(touch)
    BaseClass.touchUp(self, touch)
end

function Default:touchMove(touch)
    BaseClass.touchMove(self, touch)
end

function Default:touchCancelled(touch)
    BaseClass.touchCancelled(self, touch)
end

function Default:mouseDown(mouse)
    BaseClass.mouseDown(self, mouse)
end

function Default:mouseUp(mouse)
    BaseClass.mouseUp(self, mouse)
end

function Default:mouseMove(mouse)
    BaseClass.mouseMove(self, mouse)
end

--#############################################################################
--End Custom Code
--#############################################################################

--#############################################################################
--DO NOT EDIT BELOW
--#############################################################################

setmetatable(Default, {
    __index = BaseClass,
    __call = function (cls, ...)
      local self = setmetatable({}, cls)
      --Create the base first
      BaseClass._create(self, ...)
      self:_create(...)
      return self
    end,
  })

function Default:className()
  return "Default"
end

function Default:class()
  return self
end

function Default:superClass()
  return BaseClass
end

function Default:__gc()
  --Destroy derived class first
  Default._destroy(self)
  --Destroy base class after derived class
  BaseClass._destroy(self)
end

function Default:__tostring()
  local ret = self:className() .. " =\n{\n"
  
  for pos,val in pairs(self) do 
    ret = ret .. "\t" .. "["..pos.."]" .. " => " .. type(val) .. " = " .. tostring(val) .. "\n"
  end

  ret = ret .. "\n\t" .. tostring_r(BaseClass) .. "\n}"
  return ret .. "\n\t" .. tostring_r(getmetatable(self)) .. "\n}"
end

function Default:_destroy()
  assert(not self.__DefaultCalledLoad, "Must unload before you destroy")
  __dtor(self)
end

function Default:_create(init)
  self.__DefaultCalledLoad = false
  __ctor(self, init)
end

function Default:load()
  --load base first
  BaseClass.load(self)

  --load derived last...
  __load(self)

  self.__DefaultCalledLoad = true
end

function Default:unLoad()
  assert(self.__DefaultCalledLoad, "Must load before unloading")

  --unload derived first...
  __unLoad(self)
  self.__DefaultCalledLoad = false

  --unload base last...
  BaseClass.unLoad(self)
end

return Default
