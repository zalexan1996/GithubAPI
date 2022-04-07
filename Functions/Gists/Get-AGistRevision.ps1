<#
.SYNOPSIS


        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER gist_id
gist_id parameter
         
.PARAMETER sha



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
Function Get-AGistRevision
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$gist_id,
		[Parameter(Mandatory=$FALSE)][string]$sha
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/gists/$gist_id/$sha?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/gists/$gist_id/$sha"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
