
<#
.SYNOPSIS
Lists external groups available in an organization. You can query the groups using the display_name parameter, only groups with a group_name containing the text provided in the display_name parameter will be returned. You can also limit your page results using the per_page parameter. GitHub generates a url-encoded page token using a cursor value for where the next page begins. For more information on cursor pagination, see "Offset and Cursor Pagination explained."
You can manage team membership with your identity provider using Enterprise Managed Users for GitHub Enterprise Cloud. For more information, see "GitHub's products" in the GitHub Help documentation.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page token
         
.PARAMETER display_name
Limits the list to groups containing the text in the group name


.LINK
https://docs.github.com/en/rest/reference/teams
#>
Function List-ExternalGroupsInAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$page,
		[Parameter(Mandatory=$FALSE)][string]$display_name
    )
    $QueryStrings = @("per_page=$per_page","page=$page","display_name=$display_name") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/external-groups?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/external-groups"
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

