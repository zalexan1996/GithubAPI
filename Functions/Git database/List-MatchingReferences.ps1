<#
.SYNOPSIS
Returns an array of references from your Git database that match the supplied name. The :ref in the URL must be formatted as heads/<branch name> for branches and tags/<tag name> for tags. If the :ref doesn't exist in the repository, but existing refs start with :ref, they will be returned as an array.
When you use this endpoint without providing a :ref, it will return an array of all the references from your Git database, including notes and stashes if they exist on the server. Anything in the namespace is returned, not just heads and tags.
Note: You need to explicitly request a pull request to trigger a test merge commit, which checks the mergeability of pull requests. For more information, see "Checking mergeability of pull requests".
If you request matching references for a branch named feature but the branch feature doesn't exist, the response can still include other matching head refs that start with the word feature, such as featureA and featureB.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER ref
ref parameter
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/git

.OUTPUTS
 [
  {
    "ref": "refs/heads/feature-a",
    "node_id": "MDM6UmVmcmVmcy9oZWFkcy9mZWF0dXJlLWE=",
    "url": "https://api.github.com/repos/octocat/Hello-World/git/refs/heads/feature-a",
    "object": {
      "type": "commit",
      "sha": "aa218f56b14c9653891f9e74264a383fa43fefbd",
      "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/aa218f56b14c9653891f9e74264a383fa43fefbd"
    }
  },
  {
    "ref": "refs/heads/feature-b",
    "node_id": "MDM6UmVmcmVmcy9oZWFkcy9mZWF0dXJlLWI=",
    "url": "https://api.github.com/repos/octocat/Hello-World/git/refs/heads/feature-b",
    "object": {
      "type": "commit",
      "sha": "612077ae6dffb4d2fbd8ce0cccaa58893b07b5ac",
      "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/612077ae6dffb4d2fbd8ce0cccaa58893b07b5ac"
    }
  }
]
#>
Function List-MatchingReferences
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$ref,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page
    )
    $Querys = @()
    $QueryStrings = @(
        "per_page",
		"page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/git/matching-refs/$ref?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/git/matching-refs/$ref"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
