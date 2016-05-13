Shader "Custom/Drunk" {

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

			float4 frag (v2f i) : SV_Target
			{
				float2 pos = i.uv;

				float sq = sin( _Time.y ) * 0.05;
				float4 tc = tex2D(_MainTex, i.uv);
				float4 tl = tex2D(_MainTex, i.uv - float2(sin(sq),0.));
				float4 tR = tex2D(_MainTex, i.uv + float2(sin(sq),0.));
				float4 tD = tex2D(_MainTex, i.uv - float2(0.,sin(sq)));
				float4 tU = tex2D(_MainTex, i.uv + float2(0.,sin(sq)));

				return (tc + tl + tR + tD + tU) / 5.;
			}
			ENDCG
		}
	}
}