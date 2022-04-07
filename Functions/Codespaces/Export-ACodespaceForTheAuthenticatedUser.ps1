<#
.SYNOPSIS
Triggers an export of the specified codespace and returns a URL and ID where the status of the export can be monitored.
You must authenticate using a personal access token with the codespace scope to use this endpoint.
GitHub Apps must have write access to the codespaces_lifecycle_admin repository permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER codespace_name
The name of the codespace.


.LINK
https://docs.github.com/en/rest/reference/codespaces

.OUTPUTS
 {
  "state": "succeeded",
  "completed_at": "2022-01-01T14:59:22Z",
  "branch": "codespace-monalisa-octocat-hello-world-g4wpq6h95q",
  "sha": "fd95a81ca01e48ede9f39c799ecbcef817b8a3b2",
  "id": "latest",
  "export_url": "https://api.github.com/user/codespaces/:name/exports/latest"
}
#>
Function Export-ACodespaceForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$codespace_name
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/user/codespaces/$codespace_name/exports?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/codespaces/$codespace_name/exports"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
