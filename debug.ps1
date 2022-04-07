Remove-Module GithubAPI -ErrorAction SilentlyContinue

Import-Module $PSScriptRoot/GithubAPI.psm1 -ArgumentList @('Activity', $TRUE)