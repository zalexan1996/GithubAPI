
<#
.SYNOPSIS


        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER card_id
card_id parameter
         
.PARAMETER position
Required. The position of the card in a column. Can be one of: top, bottom, or after:<card_id> to place after the specified card.
         
.PARAMETER column_id
The unique identifier of the column the card should be moved to


.LINK
https://docs.github.com/en/rest/reference/projects
#>
Function Move-AProjectCard
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$card_id,
		[Parameter(Mandatory=$FALSE)][string]$position,
		[Parameter(Mandatory=$FALSE)][string]$column_id
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/projects/columns/cards/$card_id/moves?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/projects/columns/cards/$card_id/moves"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"position" = "$position"
	"column_id" = "$column_id"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

