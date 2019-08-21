using LuaInterface;
using UnityEngine;
using System;

public class LuaManager : MonoBehaviour {
    
    [SerializeField]
    private TextAsset lua_main;
    private readonly string MAIN_CHUNK_NAME = "__MainChunk";

    private LuaState m_luaState;

    public void Startup()
    {
        if(m_luaState == null)
        {
            m_luaState = new LuaState();
            m_luaState.Start();
            LuaBinder.Bind(m_luaState);

            m_luaState.DoString(lua_main.text, MAIN_CHUNK_NAME);
            m_luaState.Call("Main", true);
            m_luaState.CheckTop();
        }
    }

    private void OnDestroy()
    {
        if(m_luaState != null)
        {
            m_luaState.CheckTop();
            m_luaState.Dispose();
            m_luaState = null;
        }
    }
}
