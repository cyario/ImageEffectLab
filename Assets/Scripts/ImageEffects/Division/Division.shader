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

			float2 mod(float2 a, float2 b)
			{
				return a - floor(a / b) * b;
			}

			sampler2D _MainTex;

			float4 frag (v2f i) : SV_Target
			{
				float n = 2.0;
				float2 pos = mod(i.uv, 1.0 / n) * n;
				return tex2D(_MainTex, pos);
			}
			ENDCG
		}
	}
}