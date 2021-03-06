local BaseClass = require "NJLI.STATEMACHINE.NodeEntity"

local Button = {}
Button.__index = Button

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
    assert(init, "init variable is nil.")
    assert(type(init) == "table", "Init variable is expecting a states table")
    assert(init.atlas ~= nil, "init.atlas variable is nil")
    assert(init.geometry ~= nil, "init.geometry variable is nil")

    self._touchUpOutside = init.touchUpOutside
    self._touchUpInside = init.touchUpInside
    self._touchDownInside = init.touchDownInside
    self._touchDragOutside = init.touchDragOutside
    self._touchDragInside = init.touchDragInside
    self._touchCancelled = init.touchCancelled

    self._scale = init.scale or 1.0
    
    self._screenPercentWidth = init.screenPercentWidth or 1.0
    self._screenPercentHeight = init.screenPercentHeight or 1.0
    
    self._disabled = init.disabled or false

    local node = self:getNode()

    node:setGeometry(init.geometry)

    self._spriteFrameAtlas = init.atlas
    
    self._physicsShape = njli.PhysicsShapeBox.create()

    self._physicsBody = njli.PhysicsBodyRigid.create()
    self._physicsBody:setStaticPhysics()
    self._physicsBody:setPhysicsShape(self._physicsShape)

    node:setPhysicsBody(self._physicsBody)

    buttonSoundNameTable = buttonSoundNameTable or {}
    
    self._soundTouchUpOutside = njli.Sound.create()
    self._soundTouchUpOutside:setName("button_sound" )
    generateUniqueName(self._soundTouchUpOutside, buttonSoundNameTable)
    buttonSoundNameTable[self._soundTouchUpOutside:getName()] = self._soundTouchUpOutside
    
    if init.soundTouchUpOutside and type(init.soundTouchUpOutside) == "string" then
        njli.World.getInstance():getWorldResourceLoader():load(init.soundTouchUpOutside, self._soundTouchUpOutside)
    end

    self._soundTouchUpInside = njli.Sound.create()
    self._soundTouchUpInside:setName("button_sound" )
    generateUniqueName(self._soundTouchUpInside, buttonSoundNameTable)
    buttonSoundNameTable[self._soundTouchUpInside:getName()] = self._soundTouchUpInside
    
    if init.soundTouchUpInside and type(init.soundTouchUpInside) == "string" then
        njli.World.getInstance():getWorldResourceLoader():load(init.soundTouchUpInside, self._soundTouchUpInside)
    end

    self._soundTouchDownInside = njli.Sound.create()
    self._soundTouchDownInside:setName("button_sound" )
    generateUniqueName(self._soundTouchDownInside, buttonSoundNameTable)
    buttonSoundNameTable[self._soundTouchDownInside:getName()] = self._soundTouchDownInside
    
    if init.soundTouchDownInside and type(init.soundTouchDownInside) == "string" then
        njli.World.getInstance():getWorldResourceLoader():load(init.soundTouchDownInside, self._soundTouchDownInside)
    end

    self._soundTouchDragOutside = njli.Sound.create()
    self._soundTouchDragOutside:setName("button_sound" )
    generateUniqueName(self._soundTouchDragOutside, buttonSoundNameTable)
    buttonSoundNameTable[self._soundTouchDragOutside:getName()] = self._soundTouchDragOutside
    
    if init.soundTouchDragOutside and type(init.soundTouchDragOutside) == "string" then
        njli.World.getInstance():getWorldResourceLoader():load(init.soundTouchDragOutside, self._soundTouchDragOutside)
    end

    self._soundTouchDragInside = njli.Sound.create()
    self._soundTouchDragInside:setName("button_sound" )
    generateUniqueName(self._soundTouchDragInside, buttonSoundNameTable)
    buttonSoundNameTable[self._soundTouchDragInside:getName()] = self._soundTouchDragInside
    
    if init.soundTouchDragInside and type(init.soundTouchDragInside) == "string" then
        njli.World.getInstance():getWorldResourceLoader():load(init.soundTouchDragInside, self._soundTouchDragInside)
    end

    self._soundTouchCancelled = njli.Sound.create()
    self._soundTouchCancelled:setName("button_sound" )
    generateUniqueName(self._soundTouchCancelled, buttonSoundNameTable)
    buttonSoundNameTable[self._soundTouchCancelled:getName()] = self._soundTouchCancelled
    
    if init.soundTouchCancelled and type(init.soundTouchCancelled) == "string" then
        njli.World.getInstance():getWorldResourceLoader():load(init.soundTouchCancelled, self._soundTouchCancelled)
    end
    
    --Create The default state of the button.
    local frameName = "butn_" .. self:getNode():getName() .. "_off"
    local scale = self:scale()
    
    local pw = self:screenPercentWidth()
    local ph = self:screenPercentHeight()

    self:setSpriteAtlasFrame(frameName, true)
    local dimSprite = self:getDimensions()
    
    self:setDimensions(scaleDimension(dimSprite, pw, ph))
end

local __dtor = function(self)

    njli.Sound.destroy(self._soundTouchUpOutside)
    self._soundTouchUpOutside = nil

    njli.Sound.destroy(self._soundTouchUpInside)
    self._soundTouchUpInside = nil

    njli.Sound.destroy(self._soundTouchDownInside)
    self._soundTouchDownInside = nil

    njli.Sound.destroy(self._soundTouchDragOutside)
    self._soundTouchDragOutside = nil

    njli.Sound.destroy(self._soundTouchDragInside)
    self._soundTouchDragInside = nil

    njli.Sound.destroy(self._soundTouchCancelled)
    self._soundTouchCancelled = nil

    njli.PhysicsBodyRigid.destroy(self._physicsBody)
    self._physicsBody = nil

    njli.PhysicsShapeBox.destroy(self._physicsShape)
    self._physicsShape = nil

    self._spriteFrameAtlas = nil

    self:getNode():removeGeometry()
end

local __load = function(self)
  --TODO: load this Entity
end

local __unLoad = function(self)
  --TODO: unload this Entity
end

--#############################################################################
--Button Specific
--#############################################################################

function Button:startStateMachine()
	

  
  
  BaseClass.startStateMachine(self)
end

function Button:screenPercentWidth(s)
    if s ~= nil then
        self._screenPercentWidth = s
    end
    return self._screenPercentWidth
end

function Button:screenPercentHeight(s)
    if s ~= nil then
        self._screenPercentHeight = s
    end
    return self._screenPercentHeight
end

function Button:scale(s)
    if s ~= nil then
        self._scale = s
    end
    return self._scale
end

function Button:touchUpOutsideCallback(cb)
  if cb ~= nil then
    self._touchUpOutside = cb
  end
  return self._touchUpOutside
end

function Button:touchUpInsideCallback(cb)
  if cb ~= nil then
    self._touchUpInside = cb
  end
  return self._touchUpInside
end

function Button:touchDownInsideCallback(cb)
  if cb ~= nil then
    self._touchDownInside = cb
  end
  return self._touchDownInside
end

function Button:touchDragOutsideCallback(cb)
  if cb ~= nil then
    self._touchDragOutside = cb
  end
  return self._touchDragOutside
end

function Button:touchDragInsideCallback(cb)
  if cb ~= nil then
    self._touchDragInside = cb
  end
  return self._touchDragInside
end

function Button:touchCancelledCallback(cb)
  if cb ~= nil then
    self._touchCancelled = cb
  end
  return self._touchCancelled
end

function Button:disabled(b)
    if b ~= nil then

        self._disabled = b

        if self._disabled then
            self:pushState("NJLI.STATEMACHINE.UI.BUTTON.STATES.Disabled")
        else
            self:pushState("NJLI.STATEMACHINE.UI.BUTTON.STATES.Default")
        end
    end

    return self._disabled
end

function Button:setSpriteAtlasFrame(nodeStateName, match)
	local parts = nodeStateName:split("[^,%s]+")

	local name = nodeStateName
	if #parts ~= 1 then
		name = parts[1] .. parts[3]
	end
    assert(self:getNode())
    assert(self:getNode():getGeometry())
    self:getNode():getGeometry():setSpriteAtlasFrame(self:getNode(), self._spriteFrameAtlas, name, match)
end

function Button:setOrigin(origin)
  self:getNode():setOrigin(origin)
end

function Button:getOrigin()
  return self:getNode():getOrigin()
end

function Button:getDimensions()
    return self:getNode():getGeometry():getDimensions(self:getNode())
end

function Button:setDimensions(dimension)
  self:getNode():getGeometry():setDimensions(self:getNode(), dimension)
  self._physicsShape:setHalfExtends(bullet.btVector3( dimension:x(), dimension:y(), 1.0 ))
end

function Button:show(camera)
  self:getNode():show(camera)
end

function Button:hide(camera)
  self:getNode():hide(camera)
end

function Button:display(enable)
  if nil ~= enable and nil ~= OrthographicCameraNode and OrthographicCameraNode:getCamera() then
    if enable then
      self:show(OrthographicCameraNode:getCamera())
    else
      self:hide(OrthographicCameraNode:getCamera())
    end
  end
end

function Button:touchUpOutside(touches)
    if not self._touchedUp then
        if self._touchUpOutside then
            self._touchUpOutside(touches)
        else
            print(self:getNode():getName() .. ":touchUpOutside")
        end
    end
    self._soundTouchUpOutside:play()  
end

function Button:touchUpInside(rayContact)
    if self._touchUpInside then
        self._touchUpInside(rayContact)
    else
        print(self:getNode():getName() .. ":touchUpInside")
    end
    self._touchedUp = true
    self._soundTouchUpInside:play()   
end

function Button:touchDownInside(rayContact)
    if self._touchDownInside then
        self._touchDownInside(rayContact)
    else
        print(self:getNode():getName() .. ":touchDownInside")
    end
    self._touchedUp = false
    self._soundTouchDownInside:play()
end

function Button:touchDragOutside()
    if self._touchDragOutside then
        self._touchDragOutside()
    else
        print(self:getNode():getName() .. ":touchDragOutside")
    end
    self._soundTouchDragOutside:play()
end

function Button:touchDragInside(rayContact)
    if self._touchDragInside then
        self._touchDragInside(rayContact)
    else
        print(self:getNode():getName() .. ":touchDragInside")
    end
    self._soundTouchDragInside:play()
end

function Button:touchCancelled(rayContact)
    if self._touchCancelled then
        self._touchCancelled(rayContact)
    else
        print(self:getNode():getName() .. ":touchCancelled")
    end
    self._soundTouchCancelled:play()
end

--#############################################################################

function Button:enter()
  BaseClass.enter(self)
end

function Button:update(timeStep)
  BaseClass.update(self, timeStep)
end

function Button:exit()
  BaseClass.exit(self)
end

function Button:onMessage()
  BaseClass.onMessage(self)
end

function Button:rayTouchesDown(rayContact)
  BaseClass.rayTouchesDown(self, rayContact)

  if not self:disabled() then
      self:touchDownInside(rayContact)
  end
end

function Button:rayTouchesUp(rayContact)
  BaseClass.rayTouchesUp(self, rayContact)

  if not self:disabled() then
      self:touchUpInside(rayContact)
  end
end

function Button:rayTouchesMove(rayContact)
  BaseClass.rayTouchesMove(self, rayContact)

  if not self:disabled() then
      self:touchDragInside(rayContact)
  end
end

function Button:rayTouchesCancelled(rayContact)
  BaseClass.rayTouchesCancelled(self, rayContact)

  if not self:disabled() then
      self:touchCancelled(rayContact)
  end
end

function Button:rayTouchesMissed(node)
  BaseClass.rayTouchesMissed(self, node)

--  if not self:disabled() then
--      self:touchMissed(node)
--  end
end

function Button:rayTouchDown(rayContact)
  BaseClass.rayTouchDown(self, rayContact)

  if not self:disabled() then
      self:touchDownInside(rayContact)
  end
end

function Button:rayTouchUp(rayContact)
  BaseClass.rayTouchUp(self, rayContact)

  if not self:disabled() then
      self:touchUpInside(rayContact)
  end
end

function Button:rayTouchMove(rayContact)
  BaseClass.rayTouchMove(self, rayContact)

  if not self:disabled() then
      self:touchDragInside(rayContact)
  end
end

function Button:rayTouchCancelled(rayContact)
  BaseClass.rayTouchCancelled(self, rayContact)

  if not self:disabled() then
      self:touchCancelled(rayContact)
  end
end

function Button:rayTouchMissed(node)
  BaseClass.rayTouchMissed(self, node)

--  if not self:disabled() then
--      self:touchMissed(node)
--  end
end

function Button:rayMouseDown(rayContact)
  BaseClass.rayMouseDown(self, rayContact)
  
  if not self:disabled() then
      self:touchDownInside(rayContact)
  end
end

function Button:rayMouseUp(rayContact)
  BaseClass.rayMouseUp(self, rayContact)
  
  if not self:disabled() then
      self:touchUpInside(rayContact)
  end
end

function Button:rayMouseMove(rayContact)
  BaseClass.rayMouseMove(self, rayContact)
  
  if not self:disabled() then
      self:touchDragInside(rayContact)
  end
end

function Button:rayMouseMissed(node)
  BaseClass.rayMouseMissed(self, node)
end

function Button:collide(otherNode, collisionPoint)
  BaseClass.collide(self, otherNode, collisionPoint)
end

function Button:near(otherNode)
  BaseClass.near(self, otherNode)
end

function Button:actionUpdate(action, timeStep)
  BaseClass.actionUpdate(self, action, timeStep)
end

function Button:actionComplete(action)
  BaseClass.actionComplete(self, action)
end

function Button:keyboardShow()
  BaseClass.keyboardShow(self)
end

function Button:keyboardCancel()
  BaseClass.keyboardCancel(self)
end

function Button:keyboardReturn()
    BaseClass.keyboardReturn(self)
end

function Button:renderHUD()
    BaseClass.renderHUD(self)
end

function Button:gamePause()
    BaseClass.gamePause(self)
end

function Button:gameUnPause()
    BaseClass.gameUnPause(self)
end

function Button:touchesDown(touches)
    BaseClass.touchesDown(self, touches)
end

function Button:touchesUp(touches)
    BaseClass.touchesUp(self, touches)
end

function Button:touchesMove(touches)
    BaseClass.touchesMove(self, touches)
end

function Button:touchesCancelled(touches)
    BaseClass.touchesCancelled(self, touches)
end

function Button:touchDown(touch)
    BaseClass.touchDown(self, touch)
end

function Button:touchUp(touch)
    BaseClass.touchUp(self, touch)
end

function Button:touchMove(touch)
    BaseClass.touchMove(self, touch)
end

function Button:touchCancelled(touch)
    BaseClass.touchCancelled(self, touch)
end

function Button:mouseDown(mouse)
    BaseClass.mouseDown(self, mouse)
end

function Button:mouseUp(mouse)
    BaseClass.mouseUp(self, mouse)
end

function Button:mouseMove(mouse)
    BaseClass.mouseMove(self, mouse)
end

--#############################################################################
--End Custom Code
--#############################################################################

--#############################################################################
--DO NOT EDIT BELOW
--#############################################################################

setmetatable(Button, {
    __index = BaseClass,
    __call = function (cls, ...)
      local self = setmetatable({}, cls)
      --Create the base first
      BaseClass._create(self, ...)
      self:_create(...)
      return self
    end,
  })

function Button:className()
  return "Button"
end

function Button:class()
  return self
end

function Button:superClass()
  return BaseClass
end

function Button:__gc()
  --Destroy derived class first
  Button._destroy(self)
  --Destroy base class after derived class
  BaseClass._destroy(self)
end

function Button:__tostring()
  local ret = self:className() .. " =\n{\n"

  for pos,val in pairs(self) do
    ret = ret .. "\t" .. "["..pos.."]" .. " => " .. type(val) .. " = " .. tostring(val) .. "\n"
  end

  ret = ret .. "\n\t" .. tostring_r(BaseClass) .. "\n}"
  return ret .. "\n\t" .. tostring_r(getmetatable(self)) .. "\n}"
end

function Button:_destroy()
  assert(not self.__ButtonCalledLoad, "Must unload before you destroy")
  __dtor(self)
end

function Button:_create(init)
  self.__ButtonCalledLoad = false
  __ctor(self, init)
end

function Button:load()
  --load base first
  BaseClass.load(self)

  --load derived last...
  __load(self)

  self.__ButtonCalledLoad = true
end

function Button:unLoad()
  assert(self.__ButtonCalledLoad, "Must load before unloading")

  --unload derived first...
  __unLoad(self)
  self.__ButtonCalledLoad = false

  --unload base last...
  BaseClass.unLoad(self)
end

return Button
