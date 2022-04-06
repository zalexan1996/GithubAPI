<#
.SYNOPSIS


        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER column_id
column_id parameter
         
.PARAMETER note
Required. The project card's note
         
.PARAMETER content_id
Required. The unique identifier of the content associated with the card
         
.PARAMETER content_type
Required. The piece of content associated with the card


.LINK
https://docs.github.com/en/rest/reference/projects
#>
Function Create-AProjectCard
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$column_id,
		[Parameter(Mandatory=$FALSE)][string]$note,
		[Parameter(Mandatory=$FALSE)][int]$content_id,
		[Parameter(Mandatory=$FALSE)][string]$content_type
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "note",
		"content_id",
		"content_type" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/projects/columns/$column_id/cards?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/projects/columns/$column_id/cards"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
