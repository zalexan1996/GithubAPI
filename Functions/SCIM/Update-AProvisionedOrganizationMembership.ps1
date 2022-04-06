<#
.SYNOPSIS
Replaces an existing provisioned user's information. You must provide all the information required for the user as if you were provisioning them for the first time. Any existing user information that you don't provide will be removed. If you want to only update a specific attribute, use the Update an attribute for a SCIM user endpoint instead.
You must at least provide the required values for the user: userName, name, and emails.
Warning: Setting active: false removes the user from the organization, deletes the external identity, and deletes the associated {scim_user_id}.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER scim_user_id
scim_user_id parameter
         
.PARAMETER schemas

         
.PARAMETER displayName
The name of the user, suitable for display to end-users
         
.PARAMETER externalId

         
.PARAMETER groups

         
.PARAMETER active

         
.PARAMETER userName
Required. Configured by the admin. Could be an email, login, or username
         
.PARAMETER name
Required.
         
.PARAMETER emails
Required. user emails


.LINK
https://docs.github.com/en/rest/reference/scim
#>
Function Update-AProvisionedOrganizationMembership
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$scim_user_id,
		[Parameter(Mandatory=$FALSE)][string[]]$schemas,
		[Parameter(Mandatory=$FALSE)][string]$displayName,
		[Parameter(Mandatory=$FALSE)][string]$externalId,
		[Parameter(Mandatory=$FALSE)][string[]]$groups,
		[Parameter(Mandatory=$FALSE)][bool]$active,
		[Parameter(Mandatory=$FALSE)][string]$userName,
		[Parameter(Mandatory=$FALSE)][object]$name,
		[Parameter(Mandatory=$FALSE)][object[]]$emails
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "schemas",
		"displayName",
		"externalId",
		"groups",
		"active",
		"userName",
		"name",
		"emails" 
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
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
