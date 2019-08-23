using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ResourceManager : MonoBehaviour {
    private static readonly string KEY_FIRST_INSTALL = "First Install";

    public IEnumerator Init()
    {
        //下载远程资源
        yield return null;
    }
}