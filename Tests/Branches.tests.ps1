Describe "Branches" {
    BeforeAll {
        Import-Module "$(Split-Path $PSScriptRoot)\GithubAPI.psm1" -ArgumentList "Branches" -DisableNameChecking
    }
    AfterAll {
        Remove-Module "GithubAPI"
    }

    Context "GET" {
        It "Gets a list of branches from my repo" {
            $Branches = List-Branches -owner "Zalexan1996" -repo "GithubAPI"
            $Branches | Should -Not -Be $NULL
            $Branches.Count | Should -BeGreaterOrEqual 2 # I will always have at least 2 branches (main and dev)
        }
        It "Gets the main branch from my repo" {
            $Branch = Get-ABranch -owner Zalexan1996 -repo GithubAPI -branch main | Select-Object Name, 
                @{N="SHA"; E={$_.commit.sha}}, 
                @{N="Link";E={$_._links.self}}
    
            $Branch | Should -Not -Be $NULL
            $Branch.Name | Should -Be "main"
        }
    }
}