# PowerShell como Admin
$RepoUrl = "https://github.com/gabrielgilvan/rustdesk"
$Base    = "C:\ActionsRunner\rustdesk-win\runner"

Set-Location $Base
if (-not (Test-Path .\config.cmd)) { throw "config.cmd não encontrado em $Base" }

# limpa config parcial se existir
$Token = Read-Host "Cole o TOKEN da página Settings > Actions > Runners > New self-hosted runner"
cmd /c ".\config.cmd remove --token $Token" 2>$null

# configura do zero
cmd /c ".\config.cmd --url $RepoUrl --token $Token --name runner-rustdesk-win --labels self-hosted,Windows,X64 --work _work"

# inicia em modo interativo; deixe essa janela aberta
Start-Process -NoNewWindow -FilePath ".\run.cmd"
