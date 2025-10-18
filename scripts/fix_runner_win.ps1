# PowerShell como Admin
$RepoUrl = "https://github.com/gabrielgilvan/rustdesk"   # URL do REPOSITÓRIO
$Base    = "C:\ActionsRunner\rustdesk-win"
$Ver     = "2.320.0"  # ajuste se quiser outra versão
$Zip     = "actions-runner-win-x64-$Ver.zip"
$Url     = "https://github.com/actions/runner/releases/download/v$Ver/$Zip"

# limpa
Stop-Service actions.runner* -ErrorAction SilentlyContinue
Start-Sleep 1
Remove-Item $Base -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $Base | Out-Null
Set-Location $Base

# baixa e extrai
Invoke-WebRequest $Url -OutFile $Zip
Expand-Archive $Zip -DestinationPath "$Base\runner" -Force
Set-Location "$Base\runner"

# VERIFIQUE: precisa existir config.cmd, run.cmd e svc.cmd
Get-ChildItem *.cmd

# gere um token NOVO em: https://github.com/gabrielgilvan/rustdesk/settings/actions/runners  (Repo-level)
$Token = Read-Host "Cole o TOKEN do passo 'New self-hosted runner' (Windows)"

# registra; se quiser serviço, use --runasservice
.\config.cmd --url $RepoUrl --token $Token --labels "self-hosted","Windows","X64" --name "runner-rustdesk-win"

# se existir svc.cmd: instala e inicia serviço
if (Test-Path .\svc.cmd) {
  .\svc.cmd install
  .\svc.cmd start
} else {
  Write-Host "svc.cmd não encontrado. Rodando em modo interativo (janela dedicada)."
  Start-Process -NoNewWindow cmd.exe "/c run.cmd"
}
