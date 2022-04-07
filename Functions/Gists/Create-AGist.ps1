<#
.SYNOPSIS
Allows you to add a new gist with one or more files.
Note: Don't name your files "gistfile" with a numerical suffix. This is the format of the automatic naming scheme that Gist uses internally.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER description
Description of the gist
         
.PARAMETER files
Required. Names and content for the files that make up the gist
         
.PARAMETER public
Flag indicating whether the gist is public


.LINK
https://docs.github.com/en/rest/reference/gists

.OUTPUTS
 {
  "url": "https://api.github.com/gists/aa5a315d61ae9438b18d",
  "forks_url": "https://api.github.com/gists/aa5a315d61ae9438b18d/forks",
  "commits_url": "https://api.github.com/gists/aa5a315d61ae9438b18d/commits",
  "id": "aa5a315d61ae9438b18d",
  "node_id": "MDQ6R2lzdGFhNWEzMTVkNjFhZTk0MzhiMThk",
  "git_pull_url": "https://gist.github.com/aa5a315d61ae9438b18d.git",
  "git_push_url": "https://gist.github.com/aa5a315d61ae9438b18d.git",
  "html_url": "https://gist.github.com/aa5a315d61ae9438b18d",
  "created_at": "2010-04-14T02:15:15Z",
  "updated_at": "2011-06-20T11:34:15Z",
  "description": "Hello World Examples",
  "comments": 0,
  "comments_url": "https://api.github.com/gists/aa5a315d61ae9438b18d/comments/"
}
#>
Function Create-AGist
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$description,
		[Parameter(Mandatory=$FALSE)][object]$files,
		[Parameter(Mandatory=$FALSE)][string]$public
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "description",
		"files",
		"public" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/gists?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/gists"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
