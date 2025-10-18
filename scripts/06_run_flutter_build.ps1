# gh auth login
$env:GH_REPO = "gabrielgilvan/rustdesk"

# Verificar se o workflow existe
gh workflow list
gh workflow view flutter-build.yml

# Disparar
gh workflow run flutter-build.yml --ref master
gh run watch --exit-status

# Baixar artefatos quando concluir
$last = (gh run list --limit 1 --json databaseId -q ".[0].databaseId")
if ($last) { gh run download $last -D ".\artifacts\flutter-build" }
