

Describe "Repositories" {
    BeforeAll {
        Import-Module "$(Split-Path $PSScriptRoot)\GithubAPI.psm1" -ArgumentList $FALSE, "Repositories"
    }

    It "Creates a private repository called ApiTestHooyDooy" {

        $CreateParams = @{
            Name = "ApiTestHooyDooy"
            Description = "It's just a test. Why you hafta be mad?"
            Private = $TRUE
        }

        { Create-ARepositoryForTheAuthenticatedUser @CreateParams } | Should -Not -Throw
    }
    It "Sets the description for ApiTestHooyDooy" {
        { Update-ARepository -Owner "Zalexan1996" -Repo "ApiTestHooyDooy" -Description "This is a new description" } | Should -Not -Throw
    }

    It "Deletes ApiTestHooyDooy" {
        Delete-ARepository -Owner "Zalexan1996" -Repo "ApiTestHooyDooy" | Out-NULL
        { Get-ARepository -owner "Zalexan1996" -Repo "ApiTestHooyDooy" -ErrorAction Stop } | Should -Throw
    }
}