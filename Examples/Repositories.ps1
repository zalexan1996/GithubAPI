# Import the module
Import-Module "$(Split-Path $PSScriptRoot)\GithubAPI.psm1" -ArgumentList "Repositories"

# Create a repository
$CreateParams = @{
    Name = "ApiTestHooyDooy"
    Description = "It's just a test. Why you hafta be mad?"
    Private = $TRUE
}
Create-ARepositoryForTheAuthenticatedUser @CreateParams


# Updates a repository's description
Update-ARepository -Owner "Zalexan1996" -Repo "ApiTestHooyDooy" -Description "This is a new description"

# Deletes a repository.
Delete-ARepository -Owner "Zalexan1996" -Repo "ApiTestHooyDooy"