$ErrorActionPreference='SilentlyContinue'
$roots=@(
  'C:\Users\TEMP.EZSOFT.002\Desktop',
  'C:\Users\TEMP.EZSOFT.002\Documents',
  'C:\Users\TEMP.EZSOFT.002\Downloads',
  'C:\Users\TEMP.EZSOFT.002\workplace'
)
$repos=@()
foreach($root in $roots){
  if(Test-Path $root){
    $repos += Get-ChildItem $root -Directory -Recurse -Force -Filter .git |
      ForEach-Object {$_.Parent.FullName}
  }
}
$repos=$repos | Sort-Object -Unique | Where-Object {$_ -notmatch '-output$'}
$today=(Get-Date).Date
$start=$today.AddDays(-370)
$counts=@{}
$total=0
foreach($repo in $repos){
  $lines=git -C $repo log --all --since=$($start.ToString('yyyy-MM-dd')) --until=$($today.AddDays(1).ToString('yyyy-MM-dd')) --author='Max' --date=short --pretty=format:'%ad' 2>$null
  foreach($d in $lines){
    if(-not $counts.ContainsKey($d)){$counts[$d]=0}
    $counts[$d]++; $total++
  }
}
$w=1180; $h=265; $cell=13; $gap=4; $step=$cell+$gap
$x0=205; $y0=96
$startSunday=$today.AddDays(-370)
$startSunday=$startSunday.AddDays(-[int]$startSunday.DayOfWeek)
$sb=[Text.StringBuilder]::new()
[void]$sb.AppendLine('<svg xmlns="http://www.w3.org/2000/svg" width="1180" height="265" viewBox="0 0 1180 265">')
[void]$sb.AppendLine('<defs><linearGradient id="sweep" x1="0" x2="1"><stop stop-color="#7C3AED" stop-opacity="0"/><stop offset=".5" stop-color="#E879F9"/><stop offset="1" stop-color="#7C3AED" stop-opacity="0"/></linearGradient><filter id="glow"><feGaussianBlur stdDeviation="4" result="b"/><feMerge><feMergeNode in="b"/><feMergeNode in="SourceGraphic"/></feMerge></filter></defs>')
[void]$sb.AppendLine('<rect width="1180" height="265" rx="24" fill="#0B0614"/><rect x="18" y="18" width="1144" height="229" rx="18" fill="#140A24" stroke="#3B1B58"/>')
[void]$sb.AppendLine('<text x="48" y="56" fill="#A855F7" font-family="JetBrains Mono,Consolas,monospace" font-size="14" font-weight="700">ATIVIDADE.DE.DESENVOLVIMENTO</text>')
[void]$sb.AppendLine(('<text x="1130" y="56" text-anchor="end" fill="#BFA9E8" font-family="monospace" font-size="12">'+$total+' commits locais · inclui repositórios privados disponíveis</text>'))
$days=@('dom','seg','ter','qua','qui','sex','sáb')
for($r=0;$r -lt 7;$r++){ $yy=$y0+$r*$step+10; [void]$sb.AppendLine(('<text x="170" y="'+$yy+'" text-anchor="end" fill="#765495" font-family="monospace" font-size="10">'+$days[$r]+'</text>')) }
[void]$sb.AppendLine('<g id="cells" opacity="0"><animate attributeName="opacity" from="0" to="1" dur="1.2s" fill="freeze"/>')
for($week=0;$week -lt 53;$week++){
  for($day=0;$day -lt 7;$day++){
    $date=$startSunday.AddDays($week*7+$day)
    if($date -gt $today){continue}
    $key=$date.ToString('yyyy-MM-dd'); $n=0
    if($counts.ContainsKey($key)){$n=[int]$counts[$key]}
    $fill=if($n -eq 0){'#251339'}elseif($n -eq 1){'#4C1D95'}elseif($n -le 3){'#7C3AED'}elseif($n -le 6){'#A855F7'}else{'#E879F9'}
    $x=$x0+$week*$step; $y=$y0+$day*$step
    [void]$sb.AppendLine(('<rect x="'+$x+'" y="'+$y+'" width="'+$cell+'" height="'+$cell+'" rx="3" fill="'+$fill+'"><title>'+$key+' · '+$n+' commit(s)</title></rect>'))
  }
}
[void]$sb.AppendLine('</g>')
$currentWeek=[math]::Floor((($today-$startSunday).Days)/7); $currentDay=[int]$today.DayOfWeek
$cx=$x0+$currentWeek*$step; $cy=$y0+$currentDay*$step
[void]$sb.AppendLine(('<rect x="'+($cx-2)+'" y="'+($cy-2)+'" width="'+($cell+4)+'" height="'+($cell+4)+'" rx="5" fill="none" stroke="#E879F9" stroke-width="1.5"><animate attributeName="opacity" values=".25;1;.25" dur="2s" repeatCount="indefinite"/></rect>'))
[void]$sb.AppendLine('<rect x="196" y="89" width="42" height="130" fill="url(#sweep)" opacity=".14"><animate attributeName="x" values="196;1090;196" dur="9s" repeatCount="indefinite"/></rect>')
[void]$sb.AppendLine('<circle cx="1060" cy="56" r="4" fill="#C084FC" filter="url(#glow)"><animate attributeName="opacity" values=".2;1;.2" dur="2.4s" repeatCount="indefinite"/></circle>')
[void]$sb.AppendLine('<text x="48" y="228" fill="#765495" font-family="monospace" font-size="10">fonte://histórico Git local · sem nomes de repositório · snapshot atual</text>')
[void]$sb.AppendLine('</svg>')
$out='C:\Users\TEMP.EZSOFT.002\workplace\MaxKsp\assets\contributions-private.svg'
[IO.File]::WriteAllText($out,$sb.ToString(),[Text.UTF8Encoding]::new($false))
Write-Output ("repos="+$repos.Count+" total="+$total+" output="+$out)
