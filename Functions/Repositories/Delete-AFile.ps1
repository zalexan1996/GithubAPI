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
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "message",
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
    $Output = Invoke-RestMethod -Method DELETE -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
