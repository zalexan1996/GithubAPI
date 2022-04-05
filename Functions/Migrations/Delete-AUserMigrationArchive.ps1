
<#
.SYNOPSIS
Deletes a previous migration archive. Downloadable migration archives are automatically deleted after seven days. Migration metadata, which is returned in the List user migrations and Get a user migration status endpoints, will continue to be available even after an archive is deleted.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER migration_id
migration_id parameter


.LINK
https://docs.github.com/en/rest/reference/migrations
#>
Function Delete-AUserMigrationArchive
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$migration_id
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user/migrations/$migration_id/archive?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/migrations/$migration_id/archive"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method DELETE -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}
