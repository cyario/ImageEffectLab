using UnityEngine;
using System.Collections;

[ExecuteInEditMode()]
public class ImageEffect : MonoBehaviour
{
	[SerializeField] private Material _material;

	void OnRenderImage(RenderTexture src, RenderTexture dest)
	{
		Graphics.Blit(src, dest, _material);
	}
}