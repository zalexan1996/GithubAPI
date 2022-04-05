
<#
.SYNOPSIS
List the custom repository roles available in this organization. In order to see custom repository roles in an organization, the authenticated user must be an organization owner.
For more information on custom repository roles, see "Managing custom repository roles for an organization".

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER organization_id



.LINK
https://docs.github.com/en/rest/reference/orgs
#>
Function List-CustomRepositoryRolesInAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$organization_id
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/organizations/$organization_id/custom_roles?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/organizations/$organization_id/custom_roles"
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

