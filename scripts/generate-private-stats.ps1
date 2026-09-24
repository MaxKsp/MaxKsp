$ErrorActionPreference='SilentlyContinue'
$repoRoot='C:\Users\TEMP.EZSOFT.002\workplace\MaxKsp'
$roots=@('C:\Users\TEMP.EZSOFT.002\Desktop','C:\Users\TEMP.EZSOFT.002\Documents','C:\Users\TEMP.EZSOFT.002\Downloads','C:\Users\TEMP.EZSOFT.002\workplace')
$repos=@()
foreach($root in $roots){if(Test-Path $root){$repos+=Get-ChildItem $root -Directory -Recurse -Force -Filter .git | % {$_.Parent.FullName}}}
$repos=$repos|Sort-Object -Unique|? {$_ -notmatch '-output$'}
$start=(Get-Date).Date.AddDays(-365)
$dates=@(); $total=0; $ext=@{}
$map=@{'.java'='Java';'.ts'='TypeScript';'.tsx'='TypeScript';'.js'='JavaScript';'.jsx'='JavaScript';'.py'='Python';'.php'='PHP';'.sql'='SQL';'.cs'='C#';'.go'='Go';'.rs'='Rust';'.html'='HTML';'.css'='CSS'}
foreach($repo in $repos){
  $d=git -C $repo log --all --since=$($start.ToString('yyyy-MM-dd')) --author='Max' --date=short --pretty=format:'%ad' 2>$null
  foreach($x in $d){$dates+=$x;$total++}
  $files=git -C $repo ls-files 2>$null
  foreach($f in $files){$e=[IO.Path]::GetExtension($f).ToLower();if($map.ContainsKey($e)){if(!$ext.ContainsKey($map[$e])){$ext[$map[$e]]=0};$ext[$map[$e]]++}}
}
$active=($dates|Sort-Object -Unique).Count
$top=$ext.GetEnumerator()|Sort-Object Value -Descending|Select-Object -First 5
$svg=[Text.StringBuilder]::new()
[void]$svg.AppendLine('<svg xmlns="http://www.w3.org/2000/svg" width="1180" height="310" viewBox="0 0 1180 310">')
[void]$svg.AppendLine('<defs><linearGradient id="g" x1="0" x2="1"><stop stop-color="#7C3AED"/><stop offset=".5" stop-color="#A855F7"/><stop offset="1" stop-color="#E879F9"/></linearGradient><filter id="glow"><feGaussianBlur stdDeviation="4" result="b"/><feMerge><feMergeNode in="b"/><feMergeNode in="SourceGraphic"/></feMerge></filter></defs>')
[void]$svg.AppendLine('<rect width="1180" height="310" rx="24" fill="#0B0614"/><rect x="18" y="18" width="1144" height="274" rx="18" fill="#140A24" stroke="#3B1B58"/>')
[void]$svg.AppendLine('<text x="48" y="58" fill="#A855F7" font-family="JetBrains Mono,Consolas,monospace" font-size="14" font-weight="700">ESTATISTICAS.LOCAIS</text>')
[void]$svg.AppendLine('<text x="1130" y="58" text-anchor="end" fill="#8F7AAE" font-family="monospace" font-size="12">snapshot://ultimos-365-dias</text>')
[void]$svg.AppendLine('<g font-family="JetBrains Mono,Consolas,monospace">')
[void]$svg.AppendLine(('<g transform="translate(48 90)"><rect width="235" height="92" rx="14" fill="#1A0E2B" stroke="#4C1D95"/><text x="20" y="30" fill="#8F7AAE" font-size="11">COMMITS</text><text x="20" y="67" fill="#F5F3FF" font-size="28" font-weight="700">'+$total+'</text></g>'))
[void]$svg.AppendLine(('<g transform="translate(303 90)"><rect width="235" height="92" rx="14" fill="#1A0E2B" stroke="#7C3AED"/><text x="20" y="30" fill="#8F7AAE" font-size="11">REPOS LOCAIS</text><text x="20" y="67" fill="#F5F3FF" font-size="28" font-weight="700">'+$repos.Count+'</text></g>'))
[void]$svg.AppendLine(('<g transform="translate(558 90)"><rect width="235" height="92" rx="14" fill="#1A0E2B" stroke="#A855F7"/><text x="20" y="30" fill="#8F7AAE" font-size="11">DIAS ATIVOS</text><text x="20" y="67" fill="#F5F3FF" font-size="28" font-weight="700">'+$active+'</text></g>'))
[void]$svg.AppendLine('<g transform="translate(813 90)"><rect width="319" height="92" rx="14" fill="#1A0E2B" stroke="#C084FC"/><text x="20" y="30" fill="#8F7AAE" font-size="11">COBERTURA</text><text x="20" y="65" fill="#F5F3FF" font-size="16">publicos + privados locais</text><circle cx="280" cy="46" r="6" fill="#E879F9" filter="url(#glow)"><animate attributeName="opacity" values=".2;1;.2" dur="2.2s" repeatCount="indefinite"/></circle></g>')
[void]$svg.AppendLine('</g>')
$barX=48;$barY=225;$max=1;if($top.Count -gt 0){$max=($top|Measure-Object Value -Maximum).Maximum}
$i=0
foreach($e in $top){$w=[int](170*($e.Value/[double]$max));$x=$barX+$i*215;[void]$svg.AppendLine(('<text x="'+$x+'" y="216" fill="#BFA9E8" font-family="monospace" font-size="11">'+$e.Name+'</text><rect x="'+$x+'" y="'+$barY+'" width="180" height="9" rx="4.5" fill="#251339"/><rect x="'+$x+'" y="'+$barY+'" width="'+$w+'" height="9" rx="4.5" fill="url(#g)"><animate attributeName="width" from="0" to="'+$w+'" dur="'+(1.2+$i*.18)+'s" fill="freeze"/></rect>'));$i++}
[void]$svg.AppendLine('<text x="48" y="270" fill="#765495" font-family="monospace" font-size="10">fonte://Git local · inclui historico privado existente nesta maquina · linguagens por arquivos rastreados</text>')
[void]$svg.AppendLine('</svg>')
[IO.File]::WriteAllText("$repoRoot\assets\private-stats.svg",$svg.ToString(),[Text.UTF8Encoding]::new($false))
Write-Output ("repos="+$repos.Count+" commits="+$total+" activeDays="+$active)