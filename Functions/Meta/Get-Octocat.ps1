
<#
.SYNOPSIS
Get the octocat as ASCII art

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER s
The words to show in Octocat's speech bubble


.LINK
https://docs.github.com/en/rest/reference/meta
#>
Function Get-Octocat
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$s
    )
    $QueryStrings = @("s=$s") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/octocat?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/octocat"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

