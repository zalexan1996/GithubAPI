<#
.SYNOPSIS
You can import repositories from Subversion, Mercurial, and TFS that include files larger than 100MB. This ability is powered by Git LFS. You can learn more about our LFS feature and working with large files on our help site.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER use_lfs
Required. Can be one of opt_in (large files will be stored using Git LFS) or opt_out (large files will be removed during the import).


.LINK
https://docs.github.com/en/rest/reference/migrations

.OUTPUTS
 {
  "vcs": "subversion",
  "use_lfs": true,
  "vcs_url": "http://svn.mycompany.com/svn/myproject",
  "status": "complete",
  "status_text": "Done",
  "has_large_files": true,
  "large_files_size": 132331036,
  "large_files_count": 1,
  "authors_count": 4,
  "url": "https://api.github.com/repos/octocat/socm/import",
  "html_url": "https://import.github.com/octocat/socm/import",
  "authors_url": "https://api.github.com/repos/octocat/socm/import/authors",
  "repository_url": "https://api.github.com/repos/octocat/socm"
}
#>
Function Update-GitLFSPreference
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$use_lfs
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "use_lfs" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/import/lfs?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/import/lfs"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
