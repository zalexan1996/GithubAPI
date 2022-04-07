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

.OUTPUTS

#>
Function Move-AProjectCard
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$card_id,
		[Parameter(Mandatory=$FALSE)][string]$position,
		[Parameter(Mandatory=$FALSE)][int]$column_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "position",
		"column_id" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/projects/columns/cards/$card_id/moves?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/projects/columns/cards/$card_id/moves"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
