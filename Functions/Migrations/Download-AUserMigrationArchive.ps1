<#
.SYNOPSIS
Fetches the URL to download the migration archive as a tar.gz file. Depending on the resources your repository uses, the migration archive can contain JSON files with data for these objects:
attachments
bases
commit_comments
issue_comments
issue_events
issues
milestones
organizations
projects
protected_branches
pull_request_reviews
pull_requests
releases
repositories
review_comments
schema
users
The archive will also contain an attachments directory that includes all attachment files uploaded to GitHub.com and a repositories directory that contains the repository's Git data.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER migration_id
migration_id parameter


.LINK
https://docs.github.com/en/rest/reference/migrations

.OUTPUTS

#>
Function Download-AUserMigrationArchive
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$migration_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/user/migrations/$migration_id/archive?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/migrations/$migration_id/archive"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
