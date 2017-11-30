
_done__debugging__ = nil

local function CreatePerspectiveCameraNode(name)
    local node = njli.Node.create()
    node:setName(name)

    local camera = njli.Camera.create()
    camera:enableOrthographic(false)
    camera:setRenderCategory(RenderCategories.perspective)
    camera:setName("perspectiveCamera")

    node:setCamera(camera)

    return node
end

local function CreateOrthoCameraNode(name)
    local node = njli.Node.create()
    node:setName(name)

    local camera = njli.Camera.create()
    camera:enableOrthographic()
    camera:setRenderCategory(RenderCategories.orthographic)
    camera:setName("orthoCamera")

    node:setCamera(camera)

    return node
end

local Interface = require 'NJLI.Interface'
local BitmapFont = require 'NJLI.BitmapFont'
local YappyGame = require "YAPPYBIRDS.YappyGame"

OrthographicCameraNode = nil
PerspectiveCameraNode = nil
gInterface = nil
Geometry2D = nil
RanchersFont = nil
MyGame = nil

local Create = function()

  if nil == OrthographicCameraNode then
    OrthographicCameraNode = CreateOrthoCameraNode("orthoCamera")
    njli.World.getInstance():enableDebugDraw(OrthographicCameraNode:getCamera())
  end
  
  if nil == PerspectiveCameraNode then
    PerspectiveCameraNode = CreatePerspectiveCameraNode("perspectiveCamera")
  end
  
  if nil == gInterface then
    gInterface = Interface()
    gInterface:getDeviceEntity():create()
  end
  
  if nil == Geometry2D then
    Geometry2D = njli.Sprite2D.create()
    Geometry2D:setName("YappyBird Geometry")
    
    local material = njli.Material.create()
    material:setName("YappyBird Material")
    
    local shader = njli.ShaderProgram.create()
    shader:setName("YappyBird Shader")
    njli.World.getInstance():getWorldResourceLoader():load("shaders/objectShader.vsh", "shaders/objectShader.fsh", shader)
    
    Geometry2D:setMaterial(material)
    Geometry2D:setShaderProgram(shader)
    Geometry2D:show(OrthographicCameraNode:getCamera())
    Geometry2D:hide(PerspectiveCameraNode:getCamera())
  end
  
  if nil == RanchersFont then
    RanchersFont = BitmapFont({file='Ranchers_GlyphDesigner.fnt'})
  
    RanchersFont:load()
    RanchersFont:show(OrthographicCameraNode:getCamera())
    RanchersFont:hide(PerspectiveCameraNode:getCamera())
  end
  
  if nil == MyGame then
    MyGame = YappyGame(Worlds.yappygame)
    MyGame:startStateMachine()
  end
  
end
  
local Destroy = function()
  if OrthographicCameraNode then
    njli.Camera.destroy(OrthographicCameraNode:getCamera())
    njli.Node.destroy(OrthographicCameraNode)
    OrthographicCameraNode = nil
  end
  
  if PerspectiveCameraNode then
    njli.Camera.destroy(PerspectiveCameraNode:getCamera())
    njli.Node.destroy(PerspectiveCameraNode)
    PerspectiveCameraNode = nil
  end
  
  if gInterface then
    gInterface:getDeviceEntity():destroy()
    gInterface = nil
  end
  
  if Geometry2D then
    njli.Material.destroy(Geometry2D:getMaterial())
    njli.ShaderProgram.destroy(Geometry2D:getShaderProgram())
    njli.Sprite2D.destroy(Geometry2D)
    Geometry2D = nil
    
    RanchersFont:unLoad()
    RanchersFont = nil
    
    MyGame:stopStateMachine()
    MyGame = nil
  end
  
end

local Update = function(timeStep)
  local pos = bullet.btVector3(100, 100, -1)
  local to = bullet.btVector3(100, 200, -1)
  local color = bullet.btVector4(1, 0, 0, 1)
  njli.World.getInstance():getDebugDrawer():point(pos, color, 100)--, 100000, 10)

  njli.World.getInstance():getDebugDrawer():line(pos, to, color)

  if gInterface then
    gInterface:getDeviceEntity():update(timeStep)
    
    if _done__debugging__ == nil then
      _done__debugging__ = false
      return
    end
    
    if not _done__debugging__ then
      require("mobdebug").start()
      _done__debugging__ = true
    end
  end
  
  
end

local Render = function()
  if gInterface then
    gInterface:getDeviceEntity():render()
  end
end

local Resize = function(width, height, orientation)
  if gInterface then
    gInterface:getDeviceEntity():resize(width, height, orientation)
  end
end

local TouchesDown = function(touches)
  if gInterface then
    gInterface:getDeviceEntity():touchesDown(touches)
  end
end

local TouchesUp = function(touches)
  if gInterface then
    gInterface:getDeviceEntity():touchesUp(touches)
  end
end

local TouchesMove = function(touches)
  if gInterface then
    gInterface:getDeviceEntity():touchesMove(touches)
  end
end

local TouchesCancelled = function(touches)
  if gInterface then
    gInterface:getDeviceEntity():touchesCancelled(touches)
  end
end

local TouchDown = function(touch)
  if gInterface then
    gInterface:getDeviceEntity():touchDown(touch)
  end
end

local TouchUp = function(touch)
  if gInterface then
    gInterface:getDeviceEntity():touchUp(touch)
  end
end

local TouchMove = function(touch)
  if gInterface then
    gInterface:getDeviceEntity():touchMove(touch)
  end
end

local TouchCancelled = function(touches)
  if gInterface then
    gInterface:getDeviceEntity():touchCancelled(touches)
  end
end

local MouseDown = function(mouse)
  if gInterface then
    gInterface:getDeviceEntity():mouseDown(mouse)
  end
end

local MouseUp = function(mouse)
  if gInterface then
    gInterface:getDeviceEntity():mouseUp(mouse)
  end
end

local MouseMove = function(mouse)
  if gInterface then
    gInterface:getDeviceEntity():mouseMove(mouse)
  end
end

local WorldEnterState = function()
  if gInterface then
    gInterface:getStateMachine():_worldEnterState()
  end
end

local WorldUpdateState = function(timeStep)
  if gInterface then
    gInterface:getStateMachine():_worldUpdateState(timeStep)
  end
end

local WorldExitState = function()
  if gInterface then
    gInterface:getStateMachine():_worldExitState()
  end
end

local WorldOnMessage = function()
  if gInterface then
    gInterface:getStateMachine():_worldOnMessage(message)
  end
end

local WorldKeyboardShow = function()
  if gInterface then
    gInterface:getStateMachine():_worldKeyboardShow()
  end
end

local WorldKeyboardCancel = function()
  if gInterface then
    gInterface:getStateMachine():_worldKeyboardCancel()
  end  
end

local WorldKeyboardReturn = function(text)
  if gInterface then
    gInterface:getStateMachine():_worldKeyboardReturn(text)
  end
end

local WorldReceivedMemoryWarning = function()
  if gInterface then
    gInterface:getStateMachine():_worldReceivedMemoryWarning()
  end
end

local WorldGamePause = function()
  if gInterface then
    gInterface:getStateMachine():_worldGamePause()
  end
end

local WorldGameUnPause = function()
  if gInterface then
    gInterface:getStateMachine():_worldGameUnPause()
  end
end

local WorldRenderHUD = function()
  if gInterface then
    gInterface:getStateMachine():_worldRenderHUD()
  end
end

local WorldTouchesDown = function(touches)
    if gInterface then
        gInterface:getStateMachine():_worldTouchesDown(touches)
    end
end

local WorldTouchesUp = function(touches)
    if gInterface then
        gInterface:getStateMachine():_worldTouchesUp(touches)
    end
end

local WorldTouchesMove = function(touches)
    if gInterface then
        gInterface:getStateMachine():_worldTouchesMove(touches)
    end
end

local WorldTouchesCancelled = function(touches)
    if gInterface then
        gInterface:getStateMachine():_worldTouchesCancelled(touches)
    end
end

local WorldTouchDown = function(touch)
    if gInterface then
        gInterface:getStateMachine():_worldTouchDown(touch)
    end
end

local WorldTouchUp = function(touch)
    if gInterface then
        gInterface:getStateMachine():_worldTouchUp(touch)
    end
end

local WorldTouchMove = function(touch)
    if gInterface then
        gInterface:getStateMachine():_worldTouchMove(touch)
    end
end

local WorldTouchCancelled = function(touch)
    if gInterface then
        gInterface:getStateMachine():_worldTouchCancelled(touch)
    end
end

local WorldMouseDown = function(mouse)
    if gInterface then
        gInterface:getStateMachine():_worldMouseDown(mouse)
    end
end

local WorldMouseUp = function(mouse)
    if gInterface then
        gInterface:getStateMachine():_worldMouseUp(mouse)
    end
end

local WorldMouseMove = function(mouse)
    if gInterface then
        gInterface:getStateMachine():_worldMouseMove(mouse)
    end
end

local WorldWillResignActive = function()
    if gInterface then
        gInterface:getStateMachine():_worldWillResignActive()
    end
end

local WorldDidBecomeActive = function()
    if gInterface then
        gInterface:getStateMachine():_worldDidBecomeActive()
    end
end

local WorldDidEnterBackground = function()
    if gInterface then
        gInterface:getStateMachine():_worldDidEnterBackground()
    end
end

local WorldWillEnterForeground = function()
    if gInterface then
        gInterface:getStateMachine():_worldWillEnterForeground()
    end
end

local WorldWillTerminate = function()
    if gInterface then
        gInterface:getStateMachine():_worldWillTerminate()
    end
end

local WorldInterrupt = function()
    if gInterface then
        gInterface:getStateMachine():_worldInterrupt()
    end
end

local WorldResumeInterrupt = function()
    if gInterface then
        gInterface:getStateMachine():_worldResumeInterrupt()
    end
end

local SceneEnterState = function(scene)
    if gInterface then
        gInterface:getStateMachine():_sceneEnterState(scene)
    end
end

local SceneUpdateState = function(scene, timeStep)
    if gInterface then
        gInterface:getStateMachine():_sceneUpdateState(scene, timeStep)
    end
end

local SceneExitState = function(scene)
    if gInterface then
        gInterface:getStateMachine():_sceneExitState(scene)
    end
end

local SceneOnMessage = function(scene, message)
    if gInterface then
        gInterface:getStateMachine():_sceneOnMessage(scene, message)
    end
end

local SceneKeyboardShow = function(scene)
    if gInterface then
        gInterface:getStateMachine():_sceneKeyboardShow(scene)
    end
end

local SceneKeyboardCancel = function(scene)
    if gInterface then
        gInterface:getStateMachine():_sceneKeyboardCancel(scene)
    end
end

local SceneKeyboardReturn = function(scene, text)
    if gInterface then
        gInterface:getStateMachine():_sceneKeyboardReturn(scene, text)
    end
end

local SceneRenderHUD = function(scene)
    if gInterface then
        gInterface:getStateMachine():_sceneRenderHUD(scene)
    end
end

local SceneGamePause = function(scene)
    if gInterface then
        gInterface:getStateMachine():_sceneGamePause(scene)
    end
end

local SceneGameUnPause = function(scene)
    if gInterface then
        gInterface:getStateMachine():_sceneGameUnPause(scene)
    end
end

local SceneTouchesDown = function(scene, touches)
    if gInterface then
        gInterface:getStateMachine():_sceneTouchesDown(scene, touches)
    end
end

local SceneTouchesUp = function(scene, touches)
    if gInterface then
        gInterface:getStateMachine():_sceneTouchesUp(scene, touches)
    end
end

local SceneTouchesMove = function(scene, touches)
    if gInterface then
        gInterface:getStateMachine():_sceneTouchesMove(scene, touches)
    end
end

local SceneTouchesCancelled = function(scene, touches)
    if gInterface then
        gInterface:getStateMachine():_sceneTouchesCancelled(scene, touches)
    end
end

local SceneTouchDown = function(scene, touch)
    if gInterface then
        gInterface:getStateMachine():_sceneTouchDown(scene, touch)
    end
end

local SceneTouchUp = function(scene, touch)
    if gInterface then
        gInterface:getStateMachine():_sceneTouchUp(scene, touch)
    end
end

local SceneTouchMove = function(scene, touch)
    if gInterface then
        gInterface:getStateMachine():_sceneTouchMove(scene, touch)
    end
end

local SceneTouchCancelled = function(scene, touch)
    if gInterface then
        gInterface:getStateMachine():_sceneTouchCancelled(scene, touch)
    end
end

local SceneMouseDown = function(scene, mouse)
    if gInterface then
        gInterface:getStateMachine():_sceneMouseDown(scene, mouse)
    end
end

local SceneMouseUp = function(scene, mouse)
    if gInterface then
        gInterface:getStateMachine():_sceneMouseUp(scene, mouse)
    end
end

local SceneMouseMove = function(scene, mouse)
    if gInterface then
        gInterface:getStateMachine():_sceneMouseMove(scene, mouse)
    end
end

local SceneReceivedMemoryWarning = function(scene)
    if gInterface then
        gInterface:getStateMachine():_sceneReceivedMemoryWarning(scene)
    end
end

local SceneWillResignActive = function(scene)
    if gInterface then
        gInterface:getStateMachine():_sceneWillResignActive(scene)
    end
end

local SceneDidBecomeActive = function(scene)
    if gInterface then
        gInterface:getStateMachine():_sceneDidBecomeActive(scene)
    end
end

local SceneDidEnterBackground = function(scene)
    if gInterface then
        gInterface:getStateMachine():_sceneDidEnterBackground(scene)
    end
end

local SceneWillEnterForeground = function(scene)
    if gInterface then
        gInterface:getStateMachine():_sceneWillEnterForeground(scene)
    end
end

local SceneWillTerminate = function(scene)
    if gInterface then
        gInterface:getStateMachine():_sceneWillTerminate(scene)
    end
end

local SceneInterrupt = function(scene)
    if gInterface then
        gInterface:getStateMachine():_sceneInterrupt(scene)
    end
end

local SceneResumeInterrupt = function(scene)
    if gInterface then
        gInterface:getStateMachine():_sceneResumeInterrupt(scene)
    end
end

local NodeEnterState = function(node)
    if gInterface then
        gInterface:getStateMachine():_nodeEnterState(node)
    end
end

local NodeUpdateState = function(node, timeStep)
    if gInterface then
        gInterface:getStateMachine():_nodeUpdateState(node, timeStep)
    end
end

local NodeExitState = function(node)
    if gInterface then
        gInterface:getStateMachine():_nodeExitState(node)
    end
end

local NodeOnMessage = function(node, message)
    if gInterface then
        gInterface:getStateMachine():_nodeOnMessage(node, message)
    end
end

local NodeCollide = function(node, otherNode, collisionPoint)
    if gInterface then
        gInterface:getStateMachine():_nodeCollide(node, otherNode, collisionPoint)
    end
end

local NodeNear = function(node, otherNode)
    if gInterface then
        gInterface:getStateMachine():_nodeNear(node, otherNode)
    end
end

local NodeActionUpdate = function(action, timeStep)
    if gInterface then
        gInterface:getStateMachine():_nodeActionUpdate(action, timeStep)
    end
end

local NodeActionComplete = function(action)
    if gInterface then
        gInterface:getStateMachine():_nodeActionComplete(action)
    end
end

local NodeRayTouchesDown = function(rayContact)
    if gInterface then
        gInterface:getStateMachine():_rayTouchesDown(rayContact)
    end
end

local NodeRayTouchesUp = function(rayContact)
    if gInterface then
        gInterface:getStateMachine():_rayTouchesUp(rayContact)
    end
end

local NodeRayTouchesMove = function(rayContact)
    if gInterface then
        gInterface:getStateMachine():_rayTouchesMove(rayContact)
    end
end

local NodeRayTouchesCancelled = function(rayContact)
    if gInterface then
        gInterface:getStateMachine():_rayTouchesCancelled(rayContact)
    end
end

local NodeRayTouchesMissed = function(node)
    if gInterface then
        gInterface:getStateMachine():_rayTouchesMissed(node)
    end
end

local NodeRayTouchDown = function(rayContact)
    if gInterface then
        gInterface:getStateMachine():_rayTouchDown(rayContact)
    end
end

local NodeRayTouchUp = function(rayContact)
    if gInterface then
        gInterface:getStateMachine():_rayTouchUp(rayContact)
    end
end

local NodeRayTouchMove = function(rayContact)
    if gInterface then
        gInterface:getStateMachine():_rayTouchMove(rayContact)
    end
end

local NodeRayTouchCancelled = function(rayContact)
    if gInterface then
        gInterface:getStateMachine():_rayTouchCancelled(rayContact)
    end
end

local NodeRayMouseDown = function(rayContact)
    if gInterface then
        gInterface:getStateMachine():_rayMouseDown(rayContact)
    end
end

local NodeRayMouseUp = function(rayContact)
    if gInterface then
        gInterface:getStateMachine():_rayMouseUp(rayContact)
    end
end

local NodeRayMouseMove = function(rayContact)
    if gInterface then
        gInterface:getStateMachine():_rayMouseMove(rayContact)
    end
end

local NodeRayTouchMissed = function(node)
    if gInterface then
        gInterface:getStateMachine():_rayTouchMissed(node)
    end
end

local NodeRayMouseMissed = function(node)
    if gInterface then
        gInterface:getStateMachine():_rayMouseMissed(node)
    end
end

local NodeKeyboardShow = function(node)
    if gInterface then
        gInterface:getStateMachine():_nodeKeyboardShow(node)
    end
end

local NodeKeyboardCancel = function(node)
    if gInterface then
        gInterface:getStateMachine():_nodeKeyboardCancel(node)
    end
end

local NodeKeyboardReturn = function(node)
    if gInterface then
        gInterface:getStateMachine():_nodeKeyboardReturn(node)
    end
end

local NodeRenderHUD = function(node)
    if gInterface then
        gInterface:getStateMachine():_nodeRenderHUD(node)
    end
end

local NodeGamePause = function(node)
    if gInterface then
        gInterface:getStateMachine():_nodeGamePause(node)
    end
end

local NodeGameUnPause = function(node)
    if gInterface then
        gInterface:getStateMachine():_nodeGameUnPause(node)
    end
end

local NodeTouchesDown = function(node, touches)
    if gInterface then
        gInterface:getStateMachine():_nodeTouchesDown(node, touches)
    end
end

local NodeTouchesUp = function(node, touches)
    if gInterface then
        gInterface:getStateMachine():_nodeTouchesUp(node, touches)
    end
end

local NodeTouchesMove = function(node, touches)
    if gInterface then
        gInterface:getStateMachine():_nodeTouchesMove(node, touches)
    end
end

local NodeTouchesCancelled = function(node, touches)
    if gInterface then
        gInterface:getStateMachine():_nodeTouchesCancelled(node, touches)
    end
end

local NodeTouchDown = function(node, touch)
    if gInterface then
        gInterface:getStateMachine():_nodeTouchDown(node, touch)
    end
end

local NodeTouchUp = function(node, touch)
    if gInterface then
        gInterface:getStateMachine():_nodeTouchUp(node, touch)
    end
end

local NodeTouchMove = function(node, touch)
    if gInterface then
        gInterface:getStateMachine():_nodeTouchMove(node, touch)
    end
end

local NodeTouchCancelled = function(node, touches)
    if gInterface then
        gInterface:getStateMachine():_nodeTouchCancelled(node, touches)
    end
end

local NodeMouseDown = function(node, mouse)
    if gInterface then
        gInterface:getStateMachine():_nodeMouseDown(node, mouse)
    end
end

local NodeMouseUp = function(node, mouse)
    if gInterface then
        gInterface:getStateMachine():_nodeMouseUp(node, mouse)
    end
end

local NodeMouseMove = function(node, mouse)
    if gInterface then
        gInterface:getStateMachine():_nodeMouseMove(node, mouse)
    end
end

RegisterCreate("Create", Create) 
RegisterDestroy("Destroy", Destroy)
RegisterUpdate("Update", Update)
RegisterRender("Render", Render)
RegisterResize("Resize", Resize)
RegisterTouchesDown("TouchesDown", TouchesDown)
RegisterTouchesUp("TouchesUp", TouchesUp)
RegisterTouchesMove("TouchesMove", TouchesMove)
RegisterTouchesCancelled("TouchesCancelled", TouchesCancelled)
RegisterTouchDown("TouchDown", TouchDown)
RegisterTouchUp("TouchUp", TouchUp)
RegisterTouchMove("TouchMove", TouchMove)
RegisterTouchCancelled("TouchCancelled", TouchCancelled)
RegisterMouseDown("MouseDown", MouseDown)
RegisterMouseUp("MouseUp", MouseUp)
RegisterMouseMove("MouseMove", MouseMove)
RegisterWorldEnterState("WorldEnterState", WorldEnterState)
RegisterWorldUpdateState("WorldUpdateState", WorldUpdateState)
RegisterWorldExitState("WorldExitState", WorldExitState)
RegisterWorldOnMessage("WorldOnMessage", WorldOnMessage)
RegisterWorldKeyboardShow("WorldKeyboardShow", WorldKeyboardShow)
RegisterWorldKeyboardCancel("WorldKeyboardCancel", WorldKeyboardCancel)
RegisterWorldKeyboardReturn("WorldKeyboardReturn", WorldKeyboardReturn)
RegisterWorldReceivedMemoryWarning("WorldReceivedMemoryWarning", WorldReceivedMemoryWarning)
RegisterWorldGamePause("WorldGamePause", WorldGamePause)
RegisterWorldGameUnPause("WorldGameUnPause", WorldGameUnPause)
RegisterWorldRenderHUD("WorldRenderHUD", WorldRenderHUD)
RegisterWorldTouchesDown("WorldTouchesDown", WorldTouchesDown)
RegisterWorldTouchesUp("WorldTouchesUp", WorldTouchesUp)
RegisterWorldTouchesMove("WorldTouchesMove", WorldTouchesMove)
RegisterWorldTouchesCancelled("WorldTouchesCancelled", WorldTouchesCancelled)
RegisterWorldTouchDown("WorldTouchDown", WorldTouchDown)
RegisterWorldTouchUp("WorldTouchUp", WorldTouchUp)
RegisterWorldTouchMove("WorldTouchMove", WorldTouchMove)
RegisterWorldTouchCancelled("WorldTouchCancelled", WorldTouchCancelled)
RegisterWorldMouseDown("WorldMouseDown", WorldMouseDown)
RegisterWorldMouseUp("WorldMouseUp", WorldMouseUp)
RegisterWorldMouseMove("WorldMouseMove", WorldMouseMove)
RegisterWorldWillResignActive("WorldWillResignActive", WorldWillResignActive)
RegisterWorldDidBecomeActive("WorldDidBecomeActive", WorldDidBecomeActive)
RegisterWorldDidEnterBackground("WorldDidEnterBackground", WorldDidEnterBackground)
RegisterWorldWillEnterForeground("WorldWillEnterForeground", WorldWillEnterForeground)
RegisterWorldWillTerminate("WorldWillTerminate", WorldWillTerminate)
RegisterWorldInterrupt("WorldInterrupt", WorldInterrupt)
RegisterWorldResumeInterrupt("WorldResumeInterrupt", WorldResumeInterrupt)
RegisterSceneEnterState("SceneEnterState", SceneEnterState)
RegisterSceneUpdateState("SceneUpdateState", SceneUpdateState)
RegisterSceneExitState("SceneExitState", SceneExitState)
RegisterSceneOnMessage("SceneOnMessage", SceneOnMessage)
RegisterSceneKeyboardShow("SceneKeyboardShow", SceneKeyboardShow)
RegisterSceneKeyboardCancel("SceneKeyboardCancel", SceneKeyboardCancel)
RegisterSceneKeyboardReturn("SceneKeyboardReturn", SceneKeyboardReturn)
RegisterSceneRenderHUD("SceneRenderHUD", SceneRenderHUD)
RegisterSceneGamePause("SceneGamePause", SceneGamePause)
RegisterSceneGameUnPause("SceneGameUnPause", SceneGameUnPause)
RegisterSceneTouchesDown("SceneTouchesDown", SceneTouchesDown)
RegisterSceneTouchesUp("SceneTouchesUp", SceneTouchesUp)
RegisterSceneTouchesMove("SceneTouchesMove", SceneTouchesMove)
RegisterSceneTouchesCancelled("SceneTouchesCancelled", SceneTouchesCancelled)
RegisterSceneTouchDown("SceneTouchDown", SceneTouchDown)
RegisterSceneTouchUp("SceneTouchUp", SceneTouchUp)
RegisterSceneTouchMove("SceneTouchMove", SceneTouchMove)
RegisterSceneTouchCancelled("SceneTouchCancelled", SceneTouchCancelled)
RegisterSceneMouseDown("SceneMouseDown", SceneMouseDown)
RegisterSceneMouseUp("SceneMouseUp", SceneMouseUp)
RegisterSceneMouseMove("SceneMouseMove", SceneMouseMove)
RegisterSceneReceivedMemoryWarning("SceneReceivedMemoryWarning", SceneReceivedMemoryWarning)
RegisterSceneWillResignActive("SceneWillResignActive", SceneWillResignActive)
RegisterSceneDidBecomeActive("SceneDidBecomeActive", SceneDidBecomeActive)
RegisterSceneDidEnterBackground("SceneDidEnterBackground", SceneDidEnterBackground)
RegisterSceneWillEnterForeground("SceneWillEnterForeground", SceneWillEnterForeground)
RegisterSceneWillTerminate("SceneWillTerminate", SceneWillTerminate)
RegisterSceneInterrupt("SceneInterrupt", SceneInterrupt)
RegisterSceneResumeInterrupt("SceneResumeInterrupt", SceneResumeInterrupt)
RegisterNodeEnterState("NodeEnterState", NodeEnterState)
RegisterNodeUpdateState("NodeUpdateState", NodeUpdateState)
RegisterNodeExitState("NodeExitState", NodeExitState)
RegisterNodeOnMessage("NodeOnMessage", NodeOnMessage)
RegisterNodeCollide("NodeCollide", NodeCollide)
RegisterNodeNear("NodeNear", NodeNear)
RegisterNodeActionUpdate("NodeActionUpdate", NodeActionUpdate)
RegisterNodeActionComplete("NodeActionComplete", NodeActionComplete)
RegisterNodeRayTouchesDown("NodeRayTouchesDown", NodeRayTouchesDown)
RegisterNodeRayTouchesUp("NodeRayTouchesUp", NodeRayTouchesUp)
RegisterNodeRayTouchesMove("NodeRayTouchesMove", NodeRayTouchesMove)
RegisterNodeRayTouchesCancelled("NodeRayTouchesCancelled", NodeRayTouchesCancelled)
RegisterNodeRayTouchesMissed("NodeRayTouchesMissed", NodeRayTouchesMissed)
RegisterNodeRayTouchDown("NodeRayTouchDown", NodeRayTouchDown)
RegisterNodeRayTouchUp("NodeRayTouchUp", NodeRayTouchUp)
RegisterNodeRayTouchMove("NodeRayTouchMove", NodeRayTouchMove)
RegisterNodeRayTouchCancelled("NodeRayTouchCancelled", NodeRayTouchCancelled)
RegisterNodeRayMouseDown("NodeRayMouseDown", NodeRayMouseDown)
RegisterNodeRayMouseUp("NodeRayMouseUp", NodeRayMouseUp)
RegisterNodeRayMouseMove("NodeRayMouseMove", NodeRayMouseMove)
RegisterNodeRayTouchMissed("NodeRayTouchMissed", NodeRayTouchMissed)
RegisterNodeRayMouseMissed("NodeRayMouseMissed", NodeRayMouseMissed)
RegisterNodeKeyboardShow("NodeKeyboardShow", NodeKeyboardShow)
RegisterNodeKeyboardCancel("NodeKeyboardCancel", NodeKeyboardCancel)
RegisterNodeKeyboardReturn("NodeKeyboardReturn", NodeKeyboardReturn)
RegisterNodeRenderHUD("NodeRenderHUD", NodeRenderHUD)
RegisterNodeGamePause("NodeGamePause", NodeGamePause)
RegisterNodeGameUnPause("NodeGameUnPause", NodeGameUnPause)
RegisterNodeTouchesDown("NodeTouchesDown", NodeTouchesDown)
RegisterNodeTouchesUp("NodeTouchesUp", NodeTouchesUp)
RegisterNodeTouchesMove("NodeTouchesMove", NodeTouchesMove)
RegisterNodeTouchesCancelled("NodeTouchesCancelled", NodeTouchesCancelled)
RegisterNodeTouchDown("NodeTouchDown", NodeTouchDown)
RegisterNodeTouchUp("NodeTouchUp", NodeTouchUp)
RegisterNodeTouchMove("NodeTouchMove", NodeTouchMove)
RegisterNodeTouchCancelled("NodeTouchCancelled", NodeTouchCancelled)
RegisterNodeMouseDown("NodeMouseDown", NodeMouseDown)
RegisterNodeMouseUp("NodeMouseUp", NodeMouseUp)
RegisterNodeMouseMove("NodeMouseMove", NodeMouseMove)

--return gInterface

