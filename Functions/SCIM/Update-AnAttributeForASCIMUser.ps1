<#
.SYNOPSIS
Allows you to change a provisioned user's individual attributes. To change a user's values, you must provide a specific Operations JSON format that contains at least one of the add, remove, or replace operations. For examples and more information on the SCIM operations format, see the SCIM specification.
Note: Complicated SCIM path selectors that include filters are not supported. For example, a path selector defined as "path": "emails[type eq \"work\"]" will not work.
Warning: If you set active:false using the replace operation (as shown in the JSON example below), it removes the user from the organization, deletes the external identity, and deletes the associated :scim_user_id.
{
  "Operations":[{
    "op":"replace",
    "value":{
      "active":false
    }
  }]
}

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER scim_user_id
scim_user_id parameter
         
.PARAMETER schemas

         
.PARAMETER Operations
Required. Set of operations to be performed


.LINK
https://docs.github.com/en/rest/reference/scim
#>
Function Update-AnAttributeForASCIMUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$scim_user_id,
		[Parameter(Mandatory=$FALSE)][string[]]$schemas,
		[Parameter(Mandatory=$FALSE)][object[]]$Operations
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "schemas",
		"Operations" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/scim/v2/organizations/$org/Users/$scim_user_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/scim/v2/organizations/$org/Users/$scim_user_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
