
<#
.SYNOPSIS
You must send Markdown as plain text (using a Content-Type header of text/plain or text/x-markdown) to this endpoint, rather than using JSON format. In raw mode, GitHub Flavored Markdown is not supported and Markdown will be rendered in plain format like a README.md file. Markdown content must be 400 KB or less.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.


.LINK
https://docs.github.com/en/rest/reference/markdown
#>
Function Render-AMarkdownDocumentInRawMode
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/markdown/raw?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/markdown/raw"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

