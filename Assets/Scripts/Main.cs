using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using LuaInterface;

public class Main : MonoBehaviour {
	void Start () {
        var luaMgr = GameObject.FindObjectOfType<LuaManager>();
        luaMgr.Startup();
    }
}
