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
		[Parameter(Mandatory=$FALSE)][int]$migration_id,
		[Parameter(Mandatory=$FALSE)][array]$exclude
    )
    $QueryStrings = @(
        "exclude=$exclude"
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user/migrations/$migration_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/migrations/$migration_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
