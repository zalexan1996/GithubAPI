<#
.SYNOPSIS
The self-hosted runner groups REST API is available with GitHub Enterprise Cloud. For more information, see "GitHub's products."
Adds a repository to the list of selected repositories that can access a self-hosted runner group. The runner group must have visibility set to selected. For more information, see "Create a self-hosted runner group for an organization."
You must authenticate using an access token with the admin:org scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER runner_group_id
Unique identifier of the self-hosted runner group.
         
.PARAMETER repository_id



.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function Add-RepositoryAccessToASelf-HostedRunnerGroupInAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][int]$runner_group_id,
		[Parameter(Mandatory=$FALSE)][int]$repository_id
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/runner-groups/$runner_group_id/repositories/$repository_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/runner-groups/$runner_group_id/repositories/$repository_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
