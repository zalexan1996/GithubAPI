<#
.SYNOPSIS
Gets a single organization secret without revealing its encrypted value. You must authenticate using an access token with the admin:org scope to use this endpoint. GitHub Apps must have the secrets organization permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER secret_name
secret_name parameter


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS
 {
  "name": "GH_TOKEN",
  "created_at": "2019-08-10T14:59:22Z",
  "updated_at": "2020-01-10T14:59:22Z",
  "visibility": "selected",
  "selected_repositories_url": "https://api.github.com/orgs/octo-org/actions/secrets/SUPER_SECRET/repositories"
}
#>
Function Get-AnOrganizationSecret
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$secret_name
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/secrets/$secret_name?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/secrets/$secret_name"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
