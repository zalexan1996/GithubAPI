<#
.SYNOPSIS
This endpoint triggers notifications. Creating content too quickly using this endpoint may result in secondary rate limiting. See "Secondary rate limits" and "Dealing with secondary rate limits" for details.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER pull_number

         
.PARAMETER commit_title
Title for the automatic commit message.
         
.PARAMETER commit_message
Extra detail to append to automatic commit message.
         
.PARAMETER sha
SHA that pull request head must match to allow merge.
         
.PARAMETER merge_method
Merge method to use. Possible values are merge, squash or rebase. Default is merge.


.LINK
https://docs.github.com/en/rest/reference/pulls

.OUTPUTS
 {
  "sha": "6dcb09b5b57875f334f61aebed695e2e4193db5e",
  "merged": true,
  "message": "Pull Request successfully merged"
}
#>
Function Merge-APullRequest
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$pull_number,
		[Parameter(Mandatory=$FALSE)][string]$commit_title,
		[Parameter(Mandatory=$FALSE)][string]$commit_message,
		[Parameter(Mandatory=$FALSE)][string]$sha,
		[Parameter(Mandatory=$FALSE)][string]$merge_method
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "commit_title",
		"commit_message",
		"sha",
		"merge_method" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pulls/$pull_number/merge?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pulls/$pull_number/merge"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
