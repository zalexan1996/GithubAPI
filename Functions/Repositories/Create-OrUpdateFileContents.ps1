<#
.SYNOPSIS
Creates a new file or replaces an existing file in a repository.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER path
path parameter
         
.PARAMETER message
Required. The commit message.
         
.PARAMETER content
Required. The new file content, using Base64 encoding.
         
.PARAMETER sha
Required if you are updating a file. The blob SHA of the file being replaced.
         
.PARAMETER branch
The branch name. Default: the repository’s default branch (usually master)
         
.PARAMETER committer
The person that committed the file. Default: the authenticated user.
         
.PARAMETER author
The author of the file. Default: The committer or the authenticated user if you omit committer.


.LINK
https://docs.github.com/en/rest/reference/repos
#>
Function Create-OrUpdateFileContents
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$path,
		[Parameter(Mandatory=$FALSE)][string]$message,
		[Parameter(Mandatory=$FALSE)][string]$content,
		[Parameter(Mandatory=$FALSE)][string]$sha,
		[Parameter(Mandatory=$FALSE)][string]$branch,
		[Parameter(Mandatory=$FALSE)][object]$committer,
		[Parameter(Mandatory=$FALSE)][object]$author
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "message",
		"content",
		"sha",
		"branch",
		"committer",
		"author" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/contents/$path?$($QueryStrings -join '&')"
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
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
