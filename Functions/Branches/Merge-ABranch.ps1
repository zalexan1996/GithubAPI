
<#
.SYNOPSIS


        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER base
Required. The name of the base branch that the head will be merged into.
         
.PARAMETER head
Required. The head to merge. This can be a branch name or a commit SHA1.
         
.PARAMETER commit_message
Commit message to use for the merge commit. If omitted, a default message will be used.


.LINK
https://docs.github.com/en/rest/reference/branches
#>
Function Merge-ABranch
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$base,
		[Parameter(Mandatory=$FALSE)][string]$head,
		[Parameter(Mandatory=$FALSE)][string]$commit_message
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/merges?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/merges"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"base" = "$base"
	"head" = "$head"
	"commit_message" = "$commit_message"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

