<#
.SYNOPSIS
Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see GitHub's products in the GitHub Help documentation.
Protecting a branch requires admin or owner permissions to the repository.
Note: Passing new arrays of users and teams replaces their previous values.
Note: The list of users, apps, and teams in total is limited to 100 items.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER branch
The name of the branch.
         
.PARAMETER required_status_checks
Required. Require status checks to pass before merging. Set to null to disable.
         
.PARAMETER enforce_admins
Required. Enforce all configured restrictions for administrators. Set to true to enforce required status checks for repository administrators. Set to null to disable.
         
.PARAMETER required_pull_request_reviews
Required. Require at least one approving review on a pull request, before merging. Set to null to disable.
         
.PARAMETER restrictions
Required. Restrict who can push to the protected branch. User, app, and team restrictions are only available for organization-owned repositories. Set to null to disable.
         
.PARAMETER required_linear_history
Enforces a linear commit Git history, which prevents anyone from pushing merge commits to a branch. Set to true to enforce a linear commit history. Set to false to disable a linear commit Git history. Your repository must allow squash merging or rebase merging before you can enable a linear commit history. Default: false. For more information, see "Requiring a linear commit history" in the GitHub Help documentation.
         
.PARAMETER allow_force_pushes
Permits force pushes to the protected branch by anyone with write access to the repository. Set to true to allow force pushes. Set to false or null to block force pushes. Default: false. For more information, see "Enabling force pushes to a protected branch" in the GitHub Help documentation."
         
.PARAMETER allow_deletions
Allows deletion of the protected branch by anyone with write access to the repository. Set to false to prevent deletion of the protected branch. Default: false. For more information, see "Enabling force pushes to a protected branch" in the GitHub Help documentation.
         
.PARAMETER block_creations
Blocks creation of new branches which match the branch protection pattern. Set to true to prohibit new branch creation. Default: false.
         
.PARAMETER required_conversation_resolution
Requires all conversations on code to be resolved before a pull request can be merged into a branch that matches this rule. Set to false to disable. Default: false.


.LINK
https://docs.github.com/en/rest/reference/branches

.OUTPUTS

#>
Function Update-BranchProtection
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$branch,
		[Parameter(Mandatory=$FALSE)][string]$required_status_checks,
		[Parameter(Mandatory=$FALSE)][string]$enforce_admins,
		[Parameter(Mandatory=$FALSE)][string]$required_pull_request_reviews,
		[Parameter(Mandatory=$FALSE)][string]$restrictions,
		[Parameter(Mandatory=$FALSE)][bool]$required_linear_history,
		[Parameter(Mandatory=$FALSE)][string]$allow_force_pushes,
		[Parameter(Mandatory=$FALSE)][bool]$allow_deletions,
		[Parameter(Mandatory=$FALSE)][bool]$block_creations,
		[Parameter(Mandatory=$FALSE)][bool]$required_conversation_resolution
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "required_status_checks",
		"enforce_admins",
		"required_pull_request_reviews",
		"restrictions",
		"required_linear_history",
		"allow_force_pushes",
		"allow_deletions",
		"block_creations",
		"required_conversation_resolution" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/branches/$branch/protection?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/branches/$branch/protection"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
