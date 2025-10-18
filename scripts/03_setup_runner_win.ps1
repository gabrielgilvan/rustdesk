# PowerShell como Admin
$RepoUrl = "https://github.com/gabrielgilvan/rustdesk"
$Base    = "C:\ActionsRunner\rustdesk-win"
$Api     = "https://api.github.com/repos/actions/runner/releases/latest"

mkdir -Force $Base | Out-Null
cd $Base

$rel  = Invoke-RestMethod $Api
$ver  = $rel.tag_name.TrimStart("v")
$zip  = "actions-runner-win-x64-$ver.zip"
$url  = "https://github.com/actions/runner/releases/download/v$ver/$zip"

Invoke-WebRequest $url -OutFile $zip
Expand-Archive $zip -DestinationPath "$Base\runner" -Force
cd "$Base\runner"

$Token = "<TOKEN_GERADO_EM: Settings > Actions > Runners > New self-hosted runner>"
.\config.cmd --url $RepoUrl --token $Token --labels "self-hosted","Windows","X64" --name "runner-rustdesk-win"
.\svc.cmd install
.\svc.cmd start
