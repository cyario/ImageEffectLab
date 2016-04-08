Shader "Custom/Sandstorm" {

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

			float rand(float2 co)
			{
				return frac(sin(dot(co.xy ,float2(12.9898,78.233))) * 43758.5453);
			}

			float3 mix(float3 x, float3 y, float z )
			{
				return (x * (1-z)) + (y*z);
			}

			float4 frag (v2f i) : SV_Target
			{
				float3 color = tex2D(_MainTex, i.uv).rgb;
				float2 pos = i.uv;

				pos *= sin(_Time);
				float r = rand(pos);
				float3 noise = float3(r, r, r);
				float noise_intensity = 0.5;
				color = mix(color, noise, noise_intensity);

				return float4(color, 1.0).rgba;
			}
			ENDCG
		}
	}
}