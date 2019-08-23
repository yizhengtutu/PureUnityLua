--主入口函数。从这里开始lua逻辑
function Main()					
	print("Lua Main Start ==================")
	startupCoreLogic()
	gameStart()
end

--场景切换通知
function OnLevelWasLoaded(level)
	collectgarbage("collect")
	Time.timeSinceLevelLoad = 0
end

function OnApplicationQuit()

end

--开启核心脚本
function startupCoreLogic()
	require "Core/CS2LuaBridge"
	
	require "Core/BTree"
	BTree.Init()
	
	
end

function gameStart()
	local go = newGameObject()
	newGameObject(go)
	
	require "event"
	local testEvent = event("testEvent")
	testEvent:AddListener(testEvent:CreateListener(function(para) print('trigger2 ' .. para) end, 666))
	testEvent()
end