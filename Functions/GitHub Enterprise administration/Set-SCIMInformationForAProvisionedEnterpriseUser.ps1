<#
.SYNOPSIS
Note: The SCIM API endpoints for enterprise accounts are currently in beta and are subject to change.
Replaces an existing provisioned user's information. You must provide all the information required for the user as if you were provisioning them for the first time. Any existing user information that you don't provide will be removed. If you want to only update a specific attribute, use the Update an attribute for a SCIM user endpoint instead.
You must at least provide the required values for the user: userName, name, and emails.
Warning: Setting active: false removes the user from the enterprise, deletes the external identity, and deletes the associated {scim_user_id}.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER scim_user_id
scim_user_id parameter
         
.PARAMETER schemas
Required. The SCIM schema URIs.
         
.PARAMETER userName
Required. The username for the user.
         
.PARAMETER name
Required.
         
.PARAMETER emails
Required. List of user emails.
         
.PARAMETER groups
List of SCIM group IDs the user is a member of.


.LINK
https://docs.github.com/en/rest/reference/enterprise-admin
#>
Function Set-SCIMInformationForAProvisionedEnterpriseUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][string]$scim_user_id,
		[Parameter(Mandatory=$FALSE)][string[]]$schemas,
		[Parameter(Mandatory=$FALSE)][string]$userName,
		[Parameter(Mandatory=$FALSE)][object]$name,
		[Parameter(Mandatory=$FALSE)][object[]]$emails,
		[Parameter(Mandatory=$FALSE)][object[]]$groups
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "schemas",
		"userName",
		"name",
		"emails",
		"groups" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/scim/v2/enterprises/$enterprise/Users/$scim_user_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/scim/v2/enterprises/$enterprise/Users/$scim_user_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
