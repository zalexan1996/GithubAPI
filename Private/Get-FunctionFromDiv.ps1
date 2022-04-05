Function Get-FunctionFromDiv
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$TRUE, Position=0, ValueFromPipeline)][Object]$FunctionDiv
    )
        
    # Get the function name
    $Text = (Get-Culture).TextInfo.ToTitleCase($functionDiv.FindElementsByXPath("h3").Text)
    $hyphenIndex = $text.IndexOf(" ")
    $__Title = $Text.Replace(" ", "").Insert($hyphenIndex, '-').Replace("(","_").Replace(")","_")

    # Skip this one if it is a legacy function
    # if ($__Title -like "*(Legacy)*") { return; }

    # Get the help docs
    $__Synopsis = $functionDiv.FindElementsByXPath("(div)[1]").Text

    # Get the method
    $connectionString = $functionDiv.FindElementsByXPath("(div)[2]").Text -split " "
    $__Method = $connectionString[0]

    # Get the URI
    $__formattedUri = "https://api.github.com$($connectionString[1] -replace "{", "$" -replace "}", '')"


    # Get the parameters
    $parameterRows = $functionDiv.FindElementsByXPath("table[contains(@class, 'ParameterTable')]/tbody/tr")

    # Temporarily set the timeout to a small value. We'll be looking for <code> tags that may or may not be there.
    # We also aren't navigating so there SHOULDN'T be a problem with this.
    $oldTimeout = $Driver.Manage().Timeouts().ImplicitWait
    $Driver.Manage().Timeouts().ImplicitWait = [timespan]::FromMilliseconds(10)

    $__Parameters = @()
    Foreach ($parameterRow in $ParameterRows)
    {
        $tds = $ParameterRow.findElementsByTagName("td")
        if ($tds.Count -gt 2)
        {
            $__Parameters = $__Parameters + [PSCustomObject]@{
                Name = $tds[0].Text
                Type = [String]::IsNullOrEmpty($Param.Type) ? ("string") : ($tds[1].Text) # If a type isn't specified, we can most likely get away with using string.
                In = $tds[2].Text
                Description = $tds[3].Text
                Default = $tds[3].FindElementsByTagName("code") | Select-Object -Expand Text
            }
        }
    }
    $Driver.Manage().Timeouts().ImplicitWait = $oldTimeout

    [PSCustomObject]@{
        Synopsis = $__Synopsis
        FunctionName = $__Title
        Method = $__Method
        Parameters = $__Parameters
        Uri = $__formattedUri
    } | Write-Output
}