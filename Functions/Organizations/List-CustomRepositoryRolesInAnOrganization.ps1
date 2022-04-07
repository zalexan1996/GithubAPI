<#
.SYNOPSIS
List the custom repository roles available in this organization. In order to see custom repository roles in an organization, the authenticated user must be an organization owner.
For more information on custom repository roles, see "Managing custom repository roles for an organization".

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER organization_id



.LINK
https://docs.github.com/en/rest/reference/orgs

.OUTPUTS
 {
  "total_count": 2,
  "custom_roles": [
    {
      "id": 8030,
      "name": "Developer"
    },
    {
      "id": 8031,
      "name": "Designer"
    }
  ]
}
#>
Function List-CustomRepositoryRolesInAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$organization_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/organizations/$organization_id/custom_roles?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/organizations/$organization_id/custom_roles"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
