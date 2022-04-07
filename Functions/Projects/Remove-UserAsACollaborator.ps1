<#
.SYNOPSIS
Removes a collaborator from an organization project. You must be an organization owner or a project admin to remove a collaborator.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER project_id

         
.PARAMETER username



.LINK
https://docs.github.com/en/rest/reference/projects

.OUTPUTS

#>
Function Remove-UserAsACollaborator
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$project_id,
		[Parameter(Mandatory=$FALSE)][string]$username
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/projects/$project_id/collaborators/$username?$($Querys -join '&')"
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
    $Output = Invoke-RestMethod -Method DELETE -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
