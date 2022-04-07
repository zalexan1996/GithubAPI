<#
.SYNOPSIS
The self-hosted runner groups REST API is available with GitHub Enterprise Cloud. For more information, see "GitHub's products."
Replaces the list of self-hosted runners that are part of an organization runner group.
You must authenticate using an access token with the admin:org scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER runner_group_id
Unique identifier of the self-hosted runner group.
         
.PARAMETER runners
Required. List of runner IDs to add to the runner group.


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS

#>
Function Set-Self-HostedRunnersInAGroupForAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][int]$runner_group_id,
		[Parameter(Mandatory=$FALSE)][int[]]$runners
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "runners" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/runner-groups/$runner_group_id/runners?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/runner-groups/$runner_group_id/runners"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
