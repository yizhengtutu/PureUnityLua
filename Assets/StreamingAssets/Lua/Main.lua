--主入口函数。从这里开始lua逻辑
function Main()					
	print("Lua Main Start ==================")
	startupCoreLogic()
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
	require "Core/BTree"
	BTree.Init()
	
	--开始游戏逻辑
	gameStart()
end

function gameStart()
	local root = BTree.CreateSequenceNode(true)
	root:Add(BTree.CreateTimerNode(1))
	root:Add(BTree.CreateActionNode(function()
		print(UnityEngine.Application.persistentDataPath)
		return true
	end))
end