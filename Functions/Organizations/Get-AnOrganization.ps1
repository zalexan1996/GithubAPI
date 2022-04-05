
<#
.SYNOPSIS
To see many of the organization response values, you need to be an authenticated organization owner with the admin:org scope. When the value of two_factor_requirement_enabled is true, the organization requires all members, billing managers, and outside collaborators to enable two-factor authentication.
GitHub Apps with the Organization plan permission can use this endpoint to retrieve information about an organization's GitHub plan. See "Authenticating with GitHub Apps" for details. For an example response, see 'Response with GitHub plan information' below."

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org



.LINK
https://docs.github.com/en/rest/reference/orgs
#>
Function Get-AnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org"
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

