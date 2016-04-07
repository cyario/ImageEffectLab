Shader "Custom/GameBoy" {

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
				float3 color = tex2D(_MainTex, i.uv).rgb;

				float gamma = 1.5;
				color.r = pow(color.r, gamma);
				color.g = pow(color.g, gamma);
				color.b = pow(color.b, gamma);

				float3 col1 = float3(0.612, 0.725, 0.086);
				float3 col2 = float3(0.549, 0.667, 0.078);
				float3 col3 = float3(0.188, 0.392, 0.188);
				float3 col4 = float3(0.063, 0.247, 0.063);

				float dist1 = length(color - col1);
				float dist2 = length(color - col2);
				float dist3 = length(color - col3);
				float dist4 = length(color - col4);

				float d = min(dist1, dist2);
				d = min(d, dist3);
				d = min(d, dist4);

				if (d == dist1) {
					color = col1;
				}    
				else if (d == dist2) {
					color = col2;
				}    
				else if (d == dist3) {
					color = col3;
				}    
				else {
					color = col4;
				}

				return float4(color, 1.0).rgba;
            }
            ENDCG
        }
    }
}