Describe "GithubAPI" {
    BeforeAll {
        Test-Path "$(Split-Path $PSScriptRoot)\GithubAPI.psm1" | Should -Be $TRUE
    }
    Context "Branches" {
        . "$PSScriptRoot\Branches.tests.ps1"
    }
    Context "Repositories" {
        . "$PSScriptRoot\Repositories.tests.ps1"
    }
}