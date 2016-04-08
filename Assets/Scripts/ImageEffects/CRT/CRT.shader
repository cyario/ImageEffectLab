Shader "Custom/Division" {

	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}

	SubShader
	{
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}

			sampler2D _MainTex;

			fixed4 frag (v2f i) : SV_Target
			{
				float2 texUV = i.uv;
				float3 col = tex2D(_MainTex, texUV);
				col -= abs(sin(texUV.y * 100.0 + _Time * 5.0))  * 0.08;
				col -= abs(sin(texUV.y * 300.0 - _Time * 10.0)) * 0.05;
				return fixed4(col, 1.0).rgba;
			}
			ENDCG
		}
	}
}