
<#
.SYNOPSIS
Fetches a single user migration. The response includes the state of the migration, which can be one of the following values:
pending - the migration hasn't started yet.
exporting - the migration is in progress.
exported - the migration finished successfully.
failed - the migration failed.
Once the migration has been exported you can download the migration archive.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER migration_id
migration_id parameter
         
.PARAMETER exclude



.LINK
https://docs.github.com/en/rest/reference/migrations
#>
Function Get-AUserMigrationStatus
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$migration_id,
		[Parameter(Mandatory=$FALSE)][string]$exclude
    )
    $QueryStrings = @("exclude=$exclude") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user/migrations/$migration_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/migrations/$migration_id"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

