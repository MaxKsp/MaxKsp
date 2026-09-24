$repo='C:\Users\TEMP.EZSOFT.002\workplace\MaxKsp'
$svg=@'
<svg xmlns="http://www.w3.org/2000/svg" width="1180" height="390" viewBox="0 0 1180 390">
<defs>
<radialGradient id="core"><stop stop-color="#A855F7"/><stop offset="1" stop-color="#4C1D95"/></radialGradient>
<filter id="glow"><feGaussianBlur stdDeviation="6" result="b"/><feMerge><feMergeNode in="b"/><feMergeNode in="SourceGraphic"/></feMerge></filter>
</defs>
<rect width="1180" height="390" rx="24" fill="#0B0614"/>
<rect x="18" y="18" width="1144" height="354" rx="18" fill="#140A24" stroke="#3B1B58"/>
<text x="48" y="58" fill="#A855F7" font-family="JetBrains Mono,Consolas,monospace" font-size="14" font-weight="700">MAPA.DE.ATUACAO</text>
<text x="1130" y="58" text-anchor="end" fill="#8F7AAE" font-family="monospace" font-size="12">produto · software · automacao · IA</text>
<g stroke="#7C3AED" stroke-width="1.6" stroke-opacity=".38" fill="none">
<path d="M590 194L218 105M590 194L210 278M590 194L430 105M590 194L750 105M590 194L970 105M590 194L970 278"/>
</g>
<g stroke="#C084FC" stroke-width="2.2" stroke-dasharray="8 13" fill="none">
<path d="M590 194L218 105"><animate attributeName="stroke-dashoffset" values="0;-42" dur="3s" repeatCount="indefinite"/></path>
<path d="M590 194L210 278"><animate attributeName="stroke-dashoffset" values="0;-42" dur="3.4s" repeatCount="indefinite"/></path>
<path d="M590 194L430 105"><animate attributeName="stroke-dashoffset" values="0;-42" dur="3.8s" repeatCount="indefinite"/></path>
<path d="M590 194L750 105"><animate attributeName="stroke-dashoffset" values="0;-42" dur="4.2s" repeatCount="indefinite"/></path>
<path d="M590 194L970 105"><animate attributeName="stroke-dashoffset" values="0;-42" dur="4.6s" repeatCount="indefinite"/></path>
<path d="M590 194L970 278"><animate attributeName="stroke-dashoffset" values="0;-42" dur="5s" repeatCount="indefinite"/></path>
</g><g font-family="JetBrains Mono,Consolas,monospace" text-anchor="middle">
<g transform="translate(590 194)"><circle r="72" fill="url(#core)" filter="url(#glow)"><animate attributeName="r" values="68;75;68" dur="4s" repeatCount="indefinite"/></circle><circle r="88" fill="none" stroke="#A855F7" stroke-opacity=".24" stroke-dasharray="5 12"><animateTransform attributeName="transform" type="rotate" from="0" to="360" dur="18s" repeatCount="indefinite"/></circle><text y="-4" fill="#F5F3FF" font-size="18" font-weight="700">Max Keller</text><text y="22" fill="#E9D5FF" font-size="11">Engenharia de Software</text></g>
<g transform="translate(218 105)"><circle r="50" fill="#1A0E2B" stroke="#A855F7"/><text y="4" fill="#F5F3FF" font-size="13">BACKEND</text></g>
<g transform="translate(210 278)"><circle r="50" fill="#1A0E2B" stroke="#C084FC"/><text y="4" fill="#F5F3FF" font-size="13">FRONTEND</text></g>
<g transform="translate(430 105)"><circle r="50" fill="#1A0E2B" stroke="#7C3AED"/><text y="4" fill="#F5F3FF" font-size="13">APIs</text></g>
<g transform="translate(750 105)"><circle r="50" fill="#1A0E2B" stroke="#C084FC"/><text y="4" fill="#F5F3FF" font-size="13">AUTOMACAO</text></g>
<g transform="translate(970 105)"><circle r="50" fill="#1A0E2B" stroke="#A855F7"/><text y="4" fill="#F5F3FF" font-size="13">IA + MCP</text></g>
<g transform="translate(970 278)"><circle r="50" fill="#1A0E2B" stroke="#E879F9"/><text y="4" fill="#F5F3FF" font-size="13">OBSERVAB.</text></g>
</g>
<g fill="#E879F9" filter="url(#glow)">
<circle r="4"><animateMotion dur="5s" repeatCount="indefinite" path="M590 194L218 105"/></circle>
<circle r="4"><animateMotion dur="5.8s" repeatCount="indefinite" path="M590 194L210 278"/></circle>
<circle r="4"><animateMotion dur="6.6s" repeatCount="indefinite" path="M590 194L970 105"/></circle>
<circle r="4"><animateMotion dur="7.2s" repeatCount="indefinite" path="M590 194L970 278"/></circle>
</g>
<text x="48" y="345" fill="#765495" font-family="monospace" font-size="10">fluxo://produto → arquitetura → integracao → automacao → operacao</text>
</svg>
'@
[IO.File]::WriteAllText("$repo\assets\role-map.svg",$svg,[Text.UTF8Encoding]::new($false))
Write-Output 'role-map generated'