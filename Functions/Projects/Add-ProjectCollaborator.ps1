<#
.SYNOPSIS
Adds a collaborator to an organization project and sets their permission level. You must be an organization owner or a project admin to add a collaborator.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER project_id

         
.PARAMETER username

         
.PARAMETER permission
The permission to grant the collaborator.
Default: write


.LINK
https://docs.github.com/en/rest/reference/projects
#>
Function Add-ProjectCollaborator
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$project_id,
		[Parameter(Mandatory=$FALSE)][string]$username,
		[Parameter(Mandatory=$FALSE)][string]$permission
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "permission" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/projects/$project_id/collaborators/$username?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/projects/$project_id/collaborators/$username"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
