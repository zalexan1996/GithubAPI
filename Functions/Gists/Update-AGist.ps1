<#
.SYNOPSIS
Allows you to update or delete a gist file and rename gist files. Files from the previous version of the gist that aren't explicitly changed during an edit are unchanged.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER gist_id
gist_id parameter
         
.PARAMETER description
Description of the gist
         
.PARAMETER files
Names of files to be updated


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
Function Update-AGist
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$gist_id,
		[Parameter(Mandatory=$FALSE)][string]$description,
		[Parameter(Mandatory=$FALSE)][object]$files
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "description",
		"files" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/gists/$gist_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/gists/$gist_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
