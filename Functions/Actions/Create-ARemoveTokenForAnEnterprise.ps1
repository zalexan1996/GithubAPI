<#
.SYNOPSIS
Returns a token that you can pass to the config script to remove a self-hosted runner from an enterprise. The token expires after one hour.
You must authenticate using an access token with the manage_runners:enterprise scope to use this endpoint.
Example using remove token
To remove your self-hosted runner from an enterprise, replace TOKEN with the remove token provided by this endpoint.
./config.sh remove --token TOKEN

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS
 {
  "token": "AABF3JGZDX3P5PMEXLND6TS6FCWO6",
  "expires_at": "2020-01-29T12:13:35.123-08:00"
}
#>
Function Create-ARemoveTokenForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runners/remove-token?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runners/remove-token"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
