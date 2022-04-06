<#
.SYNOPSIS
Draft pull requests are available in public repositories with GitHub Free and GitHub Free for organizations, GitHub Pro, and legacy per-repository billing plans, and in public and private repositories with GitHub Team and GitHub Enterprise Cloud. For more information, see GitHub's products in the GitHub Help documentation.
Lists details of a pull request by providing its number.
When you get, create, or edit a pull request, GitHub creates a merge commit to test whether the pull request can be automatically merged into the base branch. This test commit is not added to the base branch or the head branch. You can review the status of the test commit using the mergeable key. For more information, see "Checking mergeability of pull requests".
The value of the mergeable attribute can be true, false, or null. If the value is null, then GitHub has started a background job to compute the mergeability. After giving the job time to complete, resubmit the request. When the job finishes, you will see a non-null value for the mergeable attribute in the response. If mergeable is true, then merge_commit_sha will be the SHA of the test merge commit.
The value of the merge_commit_sha attribute changes depending on the state of the pull request. Before merging a pull request, the merge_commit_sha attribute holds the SHA of the test merge commit. After merging a pull request, the merge_commit_sha attribute changes depending on how you merged the pull request:
If merged as a merge commit, merge_commit_sha represents the SHA of the merge commit.
If merged via a squash, merge_commit_sha represents the SHA of the squashed commit on the base branch.
If rebased, merge_commit_sha represents the commit that the base branch was updated to.
Pass the appropriate media type to fetch diff and patch formats.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER pull_number



.LINK
https://docs.github.com/en/rest/reference/pulls
#>
Function Get-APullRequest
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$pull_number
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pulls/$pull_number?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pulls/$pull_number"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
