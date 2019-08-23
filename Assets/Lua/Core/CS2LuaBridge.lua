--CS=>Lua的中间件，lua中减少直接调用cs接口中暴露的方法和属性

Application = UnityEngine.Application
GameObject = UnityEngine.GameObject
Transform = UnityEngine.Transform

--创建 gameobject
function newGameObject(prefab)
	if prefab == nil then
		return GameObject.New()
	else
		return GameObject.Instantiate(prefab)
	end
end

--删除 gameobject 或 component
function destroy(go)
	if go then
		GameObject.Destroy(go)
	end
end

