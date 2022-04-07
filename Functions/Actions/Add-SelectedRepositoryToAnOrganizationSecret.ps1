<#
.SYNOPSIS
Adds a repository to an organization secret when the visibility for repository access is set to selected. The visibility is set when you Create or update an organization secret. You must authenticate using an access token with the admin:org scope to use this endpoint. GitHub Apps must have the secrets organization permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER secret_name
secret_name parameter
         
.PARAMETER repository_id



.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS

#>
Function Add-SelectedRepositoryToAnOrganizationSecret
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$secret_name,
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
        $FinalURL = "https://api.github.com/orgs/$org/actions/secrets/$secret_name/repositories/$repository_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/secrets/$secret_name/repositories/$repository_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
