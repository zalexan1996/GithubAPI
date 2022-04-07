<#
.SYNOPSIS
Add a single repository to an installation. The authenticated user must have admin access to the repository.
You must use a personal access token (which you can create via the command line or Basic Authentication) to access this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER installation_id
installation_id parameter
         
.PARAMETER repository_id



.LINK
https://docs.github.com/en/rest/reference/apps

.OUTPUTS

#>
Function Add-ARepositoryToAnAppInstallation
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$installation_id,
		[Parameter(Mandatory=$FALSE)][int]$repository_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/user/installations/$installation_id/repositories/$repository_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/installations/$installation_id/repositories/$repository_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
