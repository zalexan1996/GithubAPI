<#
.SYNOPSIS
This endpoint makes use of a Hypermedia relation to determine which URL to access. The endpoint you call to upload release assets is specific to your release. Use the upload_url returned in the response of the Create a release endpoint to upload a release asset.
You need to use an HTTP client which supports SNI to make calls to this endpoint.
Most libraries will set the required Content-Length header automatically. Use the required Content-Type header to provide the media type of the asset. For a list of media types, see Media Types. For example:
application/zip
GitHub expects the asset data in its raw binary form, rather than JSON. You will send the raw binary content of the asset as the request body. Everything else about the endpoint is the same as the rest of the API. For example, you'll still need to pass your authentication to be able to upload an asset.
When an upstream failure occurs, you will receive a 502 Bad Gateway status. This may leave an empty asset with a state of starter. It can be safely deleted.
Notes:
GitHub renames asset filenames that have special characters, non-alphanumeric characters, and leading or trailing periods. The "List assets for a release" endpoint lists the renamed filenames. For more information and help, contact GitHub Support.
If you upload an asset with the same filename as another uploaded asset, you'll receive an error and must delete the old file before you can re-upload the new asset.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER release_id
release_id parameter
         
.PARAMETER name

         
.PARAMETER label



.LINK
https://docs.github.com/en/rest/reference/releases
#>
Function Upload-AReleaseAsset
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$release_id,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$label
    )
    $QueryStrings = @(
        "name=$name",
		"label=$label"
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/releases/$release_id/assets?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/releases/$release_id/assets"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
