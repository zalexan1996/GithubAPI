<#
.SYNOPSIS
Sets the actions and reusable workflows that are allowed in an enterprise. To use this endpoint, the enterprise permission policy for allowed_actions must be configured to selected. For more information, see "Set GitHub Actions permissions for an enterprise."
You must authenticate using an access token with the admin:enterprise scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER github_owned_allowed
Whether GitHub-owned actions are allowed. For example, this includes the actions in the actions organization.
         
.PARAMETER verified_allowed
Whether actions from GitHub Marketplace verified creators are allowed. Set to true to allow all actions by GitHub Marketplace verified creators.
         
.PARAMETER patterns_allowed
Specifies a list of string-matching patterns to allow specific action(s) and reusable workflow(s). Wildcards, tags, and SHAs are allowed. For example, monalisa/octocat@*, monalisa/octocat@v2, monalisa/*."


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS

#>
Function Set-AllowedActionsAndReusableWorkflowsForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][bool]$github_owned_allowed,
		[Parameter(Mandatory=$FALSE)][bool]$verified_allowed,
		[Parameter(Mandatory=$FALSE)][string[]]$patterns_allowed
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "github_owned_allowed",
		"verified_allowed",
		"patterns_allowed" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/permissions/selected-actions?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/permissions/selected-actions"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
