

local getNodeState = function(self)
 return self.nodeState
end

local getNodeObject = function(self)
 return self.nodeObject
end

local push = function(self)
 assert(self:getNodeObject(), "self:getNodeObject() must not be nil in " .. self:getNodeState():getName())

 self:getNodeObject():getNode():getStateMachine():pushState(self:getNodeState())
end

local isIn = function(self)
 assert(self:getNodeObject(), "self:getNodeObject() must not be nil in " .. self:getNodeState():getName())

 return self:getNodeState():getName() == self:getNodeObject():getNode():getStateMachine():getState():getName()
end

local actionUpdate = function(self, action, timeStep)
 
end

local actionComplete = function(self, action)
 
end

local enter = function(self)
 print(self:getNodeState():getName() .. " enter for " .. self:getNodeObject():getNode():getName())

 local nodeObject = self:getNodeObject()
 local node = nodeObject:getNode()
 local dogMovingEntity = nodeObject:getDog().movingEntity

 node:getPhysicsBody():setCollisionGroup(CollisionGroups.bird)
 node:getPhysicsBody():setCollisionMask(CollisionMasks.bird)
 node:getPhysicsBody():enableHandleCollideCallback()
 node:getPhysicsBody():setKinematicPhysics()

 nodeObject:setFrameActionName("idle")
 nodeObject:setFrameIncrement(1)

 local AabbMin, AabbMax = node:getGeometry():getAabb(node)

 AabbMax = AabbMax * node:getScale()
 AabbMax:setX(0)
 AabbMax:setZ(-1.0)

 nodeObject:getMovingEntity():getSteeringBehaviors():setOffsetPursuitOn(dogMovingEntity, AabbMax)

 self:getNodeObject():enablePursueFlagged(false)
end

local update = function(self, timeStep)
end

local exit = function(self)
 print(self:getNodeState():getName() .. " exit for " .. self:getNodeObject():getNode():getName())

 local nodeObject = self:getNodeObject()
 local node = nodeObject:getNode()

 nodeObject:getMovingEntity():getSteeringBehaviors():setOffsetPursuitOff()
 nodeObject:getMovingEntity():getSteeringBehaviors():setSeparationOff()
end

local onMessage = function(self, message)
 
end

local render = function(self)
 
end

local collide = function(self, otherNode, collisionPoint)
 
 
 local myGroup = self:getNodeObject():getNode():getPhysicsBody():getCollisionGroup()
 local otherGroup = otherNode:getPhysicsBody():getCollisionGroup()

 if bit.band(otherGroup, CollisionGroups.projectile) ~= 0 then
 self:getNodeObject():getStateObject("Hit"):push()
 elseif bit.band(otherGroup, CollisionGroups.dog) ~= 0 then
 local nodeObject = self:getNodeObject()
 local node = nodeObject:getNode()
 local distanceFromTarget = nodeObject:getMovingEntity():getSteeringBehaviors():getOffsetPursueDistance()
 local birdSpeed = nodeObject:getMovingEntity():getSpeed()

 if distanceFromTarget <= 1 and birdSpeed < 1 then
 self:getNodeObject():getStateObject("Grabbing"):push()
 end
 end
end

local near = function(self, otherNode)
 
end

local touchDown = function(self, rayContact)
 
end

local touchUp = function(self, rayContact)
 
end

local touchMove = function(self, rayContact)
 
end

local touchCancelled = function(self, rayContact)
 
end

local delete = function(self)
 njli.NodeState.destroy(self:getNodeState())
end

local methods = 
{
 
 

 getNodeState = getNodeState,
 getNodeObject = getNodeObject,
 push = push,
 isIn = isIn,
 actionUpdate = actionUpdate,
 actionComplete = actionComplete,
 enter = enter,
 update = update,
 exit = exit,
 onMessage = onMessage,
 render = render,
 collide = collide,
 near = near,
 touchDown = touchDown,
 touchUp = touchUp,
 touchMove = touchMove,
 touchCancelled = touchCancelled,
 __gc = delete
}

local new = function(name, nodeObject)

 local nodeState = njli.NodeState.create()
 nodeState:setName(name)

 local properties = 
 {
 nodeState = nodeState,



 nodeObject = nodeObject,
 }
 return setmetatable(properties, {__index = methods})
end

return {
 new = new,
}
