<#
.SYNOPSIS
OAuth applications can use a special API method for checking OAuth token validity without exceeding the normal rate limits for failed login attempts. Authentication works differently with this particular endpoint. You must use Basic Authentication to use this endpoint, where the username is the OAuth application client_id and the password is its client_secret. Invalid tokens will return 404 NOT FOUND.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER client_id
The client ID of your GitHub app.
         
.PARAMETER access_token
Required. The access_token of the OAuth application.


.LINK
https://docs.github.com/en/rest/reference/apps
#>
Function Check-AToken
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$client_id,
		[Parameter(Mandatory=$FALSE)][string]$access_token
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "access_token" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/applications/$client_id/token?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/applications/$client_id/token"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
