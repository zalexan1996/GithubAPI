<#
.SYNOPSIS


        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER gist_id
gist_id parameter
         
.PARAMETER comment_id
comment_id parameter


.LINK
https://docs.github.com/en/rest/reference/gists
#>
Function Get-AGistComment
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$gist_id,
		[Parameter(Mandatory=$FALSE)][int]$comment_id
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/gists/$gist_id/comments/$comment_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/gists/$gist_id/comments/$comment_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
