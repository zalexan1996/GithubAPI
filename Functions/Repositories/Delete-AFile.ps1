<#
.SYNOPSIS
Deletes a file in a repository.
You can provide an additional committer parameter, which is an object containing information about the committer. Or, you can provide an author parameter, which is an object containing information about the author.
The author section is optional and is filled in with the committer information if omitted. If the committer information is omitted, the authenticated user's information is used.
You must provide values for both name and email, whether you choose to use author or committer. Otherwise, you'll receive a 422 status code.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER path
path parameter
         
.PARAMETER message
Required. The commit message.
         
.PARAMETER sha
Required. The blob SHA of the file being replaced.
         
.PARAMETER branch
The branch name. Default: the repository’s default branch (usually master)
         
.PARAMETER committer
object containing information about the committer.
         
.PARAMETER author
object containing information about the author.


.LINK
https://docs.github.com/en/rest/reference/repos

.OUTPUTS
 {
  "content": null,
  "commit": {
    "sha": "7638417db6d59f3c431d3e1f261cc637155684cd",
    "node_id": "MDY6Q29tbWl0NzYzODQxN2RiNmQ1OWYzYzQzMWQzZTFmMjYxY2M2MzcxNTU2ODRjZA==",
    "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/7638417db6d59f3c431d3e1f261cc637155684cd",
    "html_url": "https://github.com/octocat/Hello-World/git/commit/7638417db6d59f3c431d3e1f261cc637155684cd",
    "author": {
      "date": "2014-11-07T22:01:45Z",
      "name": "Monalisa Octocat",
      "email": "octocat@github.com"
    },
    "committer": {
      "date": "2014-11-07T22:01:45Z",
      "name": "Monalisa Octocat",
      "email": "octocat@github.com"
    },
    "message": "my commit message",
    "tree": {
      "url": "https://api.github.com/repos/octocat/Hello-World/git/trees/691272480426f78a0138979dd3ce63b77f706feb",
      "sha": "691272480426f78a0138979dd3ce63b77f706feb"
    },
    "parents": [
      {
        "url": "https://api.github.com/repos/octocat/Hello-World/git/commits/1acc419d4d6a9ce985db7be48c6349a0475975b5",
        "html_url": "https://github.com/octocat/Hello-World/git/commit/1acc419d4d6a9ce985db7be48c6349a0475975b5",
        "sha": "1acc419d4d6a9ce985db7be48c6349a0475975b5"
      }
    ],
    "verification": {
      "verified": false,
      "reason": "unsigned",
      "signature": null,
      "payload": null
    }
  }
}
#>
Function Delete-AFile
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$path,
		[Parameter(Mandatory=$FALSE)][string]$message,
		[Parameter(Mandatory=$FALSE)][string]$sha,
		[Parameter(Mandatory=$FALSE)][string]$branch,
		[Parameter(Mandatory=$FALSE)][object]$committer,
		[Parameter(Mandatory=$FALSE)][object]$author
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "message",
		"sha",
		"branch",
		"committer",
		"author" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/contents/$path?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/contents/$path"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method DELETE -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
