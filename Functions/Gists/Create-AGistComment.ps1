
<#
.SYNOPSIS


        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER gist_id
gist_id parameter
         
.PARAMETER body
Required. The comment text.


.LINK
https://docs.github.com/en/rest/reference/gists
#>
Function Create-AGistComment
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$gist_id,
		[Parameter(Mandatory=$FALSE)][string]$body
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/gists/$gist_id/comments?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/gists/$gist_id/comments"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"body" = "$body"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}
