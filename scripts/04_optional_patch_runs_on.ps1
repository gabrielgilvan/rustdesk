# Se o YAML estiver fixo em windows-latest, alterna para self-hosted/Windows/X64
$wf = ".github\workflows\flutter-build.yml"
$c = Get-Content $wf -Raw
if ($c -match "runs-on:\s*windows-latest") {
  $c = $c -replace "runs-on:\s*windows-latest", "runs-on: [self-hosted, Windows, X64]"
  $c | Set-Content $wf -Encoding UTF8
  git add $wf
  git commit -m "ci: usar runner self-hosted Windows"
  git push origin master
}
