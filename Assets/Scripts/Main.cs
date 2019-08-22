using UnityEngine;
using System.Collections;

public class Main : MonoBehaviour {

    private GameObject m_go;
    private Transform m_tf;

    IEnumerator Start()
    {
        m_go = gameObject;
        m_tf = m_go.transform;

        //资源初始化
        yield return StartCoroutine(m_go.AddComponent<ResourceManager>().Init());

        //lua虚拟机初始化后调用 Main.lua => Main()
        m_go.AddComponent<LuaClient>();
    }
}