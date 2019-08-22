using UnityEditor;
using UnityEngine;
using LuaInterface;

public class Packager {

    [MenuItem("Packager/Pack")]
	public static void Pack()
    {
        ToLuaMenu.ClearAllLuaFiles();
        string destDir = Application.streamingAssetsPath + "/Lua";
        ToLuaMenu.CopyLuaBytesFiles(LuaConst.luaDir, destDir, false);
        ToLuaMenu.CopyLuaBytesFiles(LuaConst.toluaDir, destDir, false);
        AssetDatabase.Refresh();
    }
}
