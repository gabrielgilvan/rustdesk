# PowerShell (de preferência como Admin)
$repo     = "gabrielgilvan/rustdesk"
$workflow = "flutter-build.yml"

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
  Write-Host "Instalando GitHub CLI..."
  winget install --id GitHub.cli -e --source winget
  $env:Path += ";$env:ProgramFiles\GitHub CLI"
}

gh --version
gh auth login
gh workflow list -R $repo
gh workflow view $workflow -R $repo
gh workflow run  $workflow -R $repo --ref master
gh run watch     -R $repo --exit-status

$run = (gh run list -R $repo --limit 1 --json databaseId -q ".[0].databaseId")
if ($run) { gh run download -R $repo $run -D "$PSScriptRoot\..\artifacts\flutter-build" }
