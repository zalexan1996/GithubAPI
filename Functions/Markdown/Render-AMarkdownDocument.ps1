
<#
.SYNOPSIS


        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER text
Required. The Markdown text to render in HTML.
         
.PARAMETER mode
The rendering mode. Can be either markdown or gfm.
Default: markdown
         
.PARAMETER context
The repository context to use when creating references in gfm mode. For example, setting context to octo-org/octo-repo will change the text #42 into an HTML link to issue 42 in the octo-org/octo-repo repository.


.LINK
https://docs.github.com/en/rest/reference/markdown
#>
Function Render-AMarkdownDocument
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$text,
		[Parameter(Mandatory=$FALSE)][string]$mode,
		[Parameter(Mandatory=$FALSE)][string]$context
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/markdown?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/markdown"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"text" = "$text"
	"mode" = "$mode"
	"context" = "$context"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

