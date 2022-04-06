<#
.SYNOPSIS
Updates a codespace owned by the authenticated user. Currently only the codespace's machine type and recent folders can be modified using this endpoint.
If you specify a new machine type it will be applied the next time your codespace is started.
You must authenticate using an access token with the codespace scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER codespace_name
The name of the codespace.
         
.PARAMETER machine
A valid machine to transition this codespace to.
         
.PARAMETER display_name
Display name for this codespace
         
.PARAMETER recent_folders
Recently opened folders inside the codespace. It is currently used by the clients to determine the folder path to load the codespace in.


.LINK
https://docs.github.com/en/rest/reference/codespaces
#>
Function Update-ACodespaceForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$codespace_name,
		[Parameter(Mandatory=$FALSE)][string]$machine,
		[Parameter(Mandatory=$FALSE)][string]$display_name,
		[Parameter(Mandatory=$FALSE)][string[]]$recent_folders
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "machine",
		"display_name",
		"recent_folders" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user/codespaces/$codespace_name?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/codespaces/$codespace_name"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
