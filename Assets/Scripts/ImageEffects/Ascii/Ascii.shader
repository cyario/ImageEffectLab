Shader "Custom/Ascii" {

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

			float character(float n, float2 p)
			{
				p = floor(p*float2(4.0, -4.0) + 2.5);
				if (clamp(p.x, 0.0, 4.0) == p.x && clamp(p.y, 0.0, 4.0) == p.y)
				{
					if (int(fmod(n/exp2(p.x + 5.0*p.y), 2.0)) == 1) return 1.0;
				}	
				return 0.0;
			}

//			float4 frag (v2f i) : SV_Target
//			{
//				float3 col = tex2D(_MainTex, i.uv).rgb;
//				float gray = (col.r + col.g + col.b) / 3.0;
//				float pixelSize = 1.0 / 50.0;
//
//				float n =  65536.0;             // .
//				if (gray > 0.2) n = 65600.0;    // :
//				if (gray > 0.3) n = 332772.0;   // *
//				if (gray > 0.4) n = 15255086.0; // o
//				if (gray > 0.5) n = 23385164.0; // &
//				if (gray > 0.6) n = 15252014.0; // 8
//				if (gray > 0.7) n = 13199452.0; // @
//				if (gray > 0.8) n = 11512810.0; // #
//				float2 p = fmod( i.uv / ( pixelSize * 0.5 ), 2.0) - float2(1.0, 1.0);
//
//				return character(n, p);
//			}

			float4 frag (v2f i) : SV_Target
			{
				float2 uv = i.uv.xy;
				//float3 col = tex2D(_MainTex, floor(uv/8.0)*8.0/_ScreenParams.xy).rgb;
				float3 col = tex2D(_MainTex, uv).rgb;

				float gray = (col.r + col.g + col.b)/3.0;

				float n =  65536.0;             // .
				if (gray > 0.2) n = 65600.0;    // :
				if (gray > 0.3) n = 332772.0;   // *
				if (gray > 0.4) n = 15255086.0; // o 
				if (gray > 0.5) n = 23385164.0; // &
				if (gray > 0.6) n = 15252014.0; // 8
				if (gray > 0.7) n = 13199452.0; // @
				if (gray > 0.8) n = 11512810.0; // #

				float2 p = fmod(uv/((1.0/50.0)*0.5), 2.0) - float2(1.0, 1.0);

				col = gray*character(n, p);
				//col = col*character(n, p);

				return float4(col, 1.0);
			}

			ENDCG
		}
	}
}