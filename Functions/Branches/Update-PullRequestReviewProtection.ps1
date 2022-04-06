<#
.SYNOPSIS
Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see GitHub's products in the GitHub Help documentation.
Updating pull request review enforcement requires admin or owner permissions to the repository and branch protection to be enabled.
Note: Passing new arrays of users and teams replaces their previous values.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER branch
The name of the branch.
         
.PARAMETER dismissal_restrictions
Specify which users and teams can dismiss pull request reviews. Pass an empty dismissal_restrictions object to disable. User and team dismissal_restrictions are only available for organization-owned repositories. Omit this parameter for personal repositories.
         
.PARAMETER dismiss_stale_reviews
Set to true if you want to automatically dismiss approving reviews when someone pushes a new commit.
         
.PARAMETER require_code_owner_reviews
Blocks merging pull requests until code owners have reviewed.
         
.PARAMETER required_approving_review_count
Specifies the number of reviewers required to approve pull requests. Use a number between 1 and 6 or 0 to not require reviewers.
         
.PARAMETER bypass_pull_request_allowances
Allow specific users or teams to bypass pull request requirements.


.LINK
https://docs.github.com/en/rest/reference/branches
#>
Function Update-PullRequestReviewProtection
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$branch,
		[Parameter(Mandatory=$FALSE)][object]$dismissal_restrictions,
		[Parameter(Mandatory=$FALSE)][bool]$dismiss_stale_reviews,
		[Parameter(Mandatory=$FALSE)][bool]$require_code_owner_reviews,
		[Parameter(Mandatory=$FALSE)][int]$required_approving_review_count,
		[Parameter(Mandatory=$FALSE)][object]$bypass_pull_request_allowances
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "dismissal_restrictions",
		"dismiss_stale_reviews",
		"require_code_owner_reviews",
		"required_approving_review_count",
		"bypass_pull_request_allowances" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/branches/$branch/protection/required_pull_request_reviews?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/branches/$branch/protection/required_pull_request_reviews"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
