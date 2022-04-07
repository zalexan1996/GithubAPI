<#
.SYNOPSIS
Given a section url (https://docs.github.com/en/rest/reference/actions), it will scrape the webpage and return an array of PSCustomObjects
that represent the functions in the section

.OUTPUTS
Returns all endpoint objects for the specified section:

[PSCustomObject[]]@{
    Synopsis = The Synopsis text of the endpoint
    FunctionName = The name of the function. 
    Method = The HTTP method of the function
    Parameters = @(
            @{
                Name = The name of the parameter
                Type = The datatype of the parameter
                In = Where the parameter is supplied to (Header, Body, Query, Path)
                Description = A short description of the paramater. Not all parameters have a scrapable Description field
                Default = "N/A"
            }
        }
    )
    Uri = The URI of the endpoint
    ExpectedOutput = The text from the Response box of the documentation page.
    Code = The generated powershell code of this function
}
#>
Function Get-Endpoints
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$TRUE)][string]$SectionUrl
    )
    . "$PSScriptRoot\Get-FunctionFromDiv.ps1"
    . "$PSScriptRoot\New-FunctionFromObject.ps1"

    # Navigate to the section URL
    Enter-SeUrl -Driver $Driver -Url $SectionUrl

    # Get a list of all subsections. 
    $subSectionDivs = $Driver.FindElementsByXPath("//div[contains(@class, 'markdown-body')]/div")

    # Parse each function in every subsection. 
    Foreach ($subSectionDiv in $subSectionDivs)
    {
        # Get all the functions in this section
        $functionDivs = $subSectionDiv.FindElementsByXPath("div")

        # The first div is a synopsis of this subsection so skip it.
        for ($i = 1; $i -lt $functionDivs.Count; $i++)
        {
            # Parse the function div and return an object representation of the HTML
            $funcObj = Get-FunctionFromDiv -FunctionDiv $functionDivs[$i]
            if ($funcObj.FunctionName -notlike "*_Legacy_*")
            {
                Write-Verbose "`t$($funcObj.FunctionName)"
                # Generate a PowerShell function from our function object and add it to our output
                $funcObj | Select-Object *, @{
                    Name="Code"
                    Expression = { New-FunctionFromObject -FunctionObject $_ -DocumentationURL $SectionURL }
                } | Write-Output
            }
        }
    }
}
