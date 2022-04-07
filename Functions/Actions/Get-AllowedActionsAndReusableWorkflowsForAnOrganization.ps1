<#
.SYNOPSIS
Gets the selected actions and reusable workflows that are allowed in an organization. To use this endpoint, the organization permission policy for allowed_actions must be configured to selected. For more information, see "Set GitHub Actions permissions for an organization.""
You must authenticate using an access token with the admin:org scope to use this endpoint. GitHub Apps must have the administration organization permission to use this API.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org



.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS
 {
  "github_owned_allowed": true,
  "verified_allowed": false,
  "patterns_allowed": [
    "monalisa/octocat@*",
    "docker/*"
  ]
}
#>
Function Get-AllowedActionsAndReusableWorkflowsForAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/permissions/selected-actions?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/permissions/selected-actions"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
