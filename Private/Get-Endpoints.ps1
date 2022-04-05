. "$PSScriptRoot\Get-FunctionFromDiv.ps1"
. "$PSScriptRoot\New-FunctionFromObject.ps1"

Function Get-Endpoints
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$TRUE)][string]$SectionUrl
    )
    
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
                # Generate a PowerShell function from our function object and add it to our output
                $funcObj | Select-Object *, @{
                    Name="Code"
                    Expression = { New-FunctionFromObject -FunctionObject $_ -DocumentationURL $SectionURL }
                } | Write-Output
            }
        }
    }
}
