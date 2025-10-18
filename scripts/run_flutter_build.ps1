# Requer GitHub CLI autenticado: gh auth login
$env:GH_REPO = "gabrielgilvan/rustdesk"

gh workflow list
gh workflow view flutter-build.yml
gh workflow run flutter-build.yml --ref master
gh run watch --exit-status

# baixar artefatos do último run
$run = (gh run list --limit 1 --json databaseId -q ".[0].databaseId")
if ($run) { gh run download $run -D ".\artifacts\flutter-build" }
