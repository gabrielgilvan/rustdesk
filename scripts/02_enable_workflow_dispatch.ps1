$wf = ".github\workflows\flutter-build.yml"
if (-not (Test-Path $wf)) { throw "Arquivo não encontrado: $wf" }

$content = Get-Content $wf -Raw

if ($content -notmatch 'workflow_dispatch:') {
  if ($content -match '(?m)^\s*on:\s*$') {
    $content = $content -replace '(?m)^(\s*on:\s*)$', '$1`r`n  workflow_dispatch:'
  } elseif ($content -match '(?m)^\s*on:\s*[\r\n]+') {
    $content = $content -replace '(?m)^(\s*on:\s*[\r\n]+)', '$1  workflow_dispatch:`r`n'
  } else {
    $content = "on:`r`n  workflow_dispatch:`r`n" + $content
  }
  Set-Content $wf $content -Encoding UTF8
  git add $wf
  git commit -m "ci: acrescenta workflow_dispatch no flutter-build"
  git push origin master
} else {
  Write-Host "workflow_dispatch já presente."
}
