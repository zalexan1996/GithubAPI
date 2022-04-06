<#
.SYNOPSIS
Unlocks a repository. You can lock repositories when you start a user migration. Once the migration is complete you can unlock each repository to begin using it again or delete the repository if you no longer need the source data. Returns a status of 404 Not Found if the repository is not locked.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER migration_id
migration_id parameter
         
.PARAMETER repo_name
repo_name parameter


.LINK
https://docs.github.com/en/rest/reference/migrations
#>
Function Unlock-AUserRepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$migration_id,
		[Parameter(Mandatory=$FALSE)][string]$repo_name
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user/migrations/$migration_id/repos/$repo_name/lock?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/migrations/$migration_id/repos/$repo_name/lock"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method DELETE -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
