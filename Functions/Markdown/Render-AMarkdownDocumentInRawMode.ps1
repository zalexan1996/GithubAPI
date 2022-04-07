<#
.SYNOPSIS
You must send Markdown as plain text (using a Content-Type header of text/plain or text/x-markdown) to this endpoint, rather than using JSON format. In raw mode, GitHub Flavored Markdown is not supported and Markdown will be rendered in plain format like a README.md file. Markdown content must be 400 KB or less.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.


.LINK
https://docs.github.com/en/rest/reference/markdown

.OUTPUTS

#>
Function Render-AMarkdownDocumentInRawMode
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/markdown/raw?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/markdown/raw"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
