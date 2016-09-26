<#
Get-TimeZoneTable.ps1
#>


[CmdletBinding()]
Param (
    [Parameter(ValueFromPipeline=$true,
    ValueFromPipelineByPropertyName=$true,
      HelpMessage='In which folder, directory or path would you like to save the generated Time Zone Tables to? Please enter a valid file system path to a directory (a full path name of a directory (a.k.a. a folder) i.e. folder path such as C:\Windows). If the path name includes space characters, please add quotation marks around the path name.')]
    [Alias("ReportPath")]
	[string]$Path = "$env:temp",
    [string]$Sort = "Default",
    [switch]$Descending
)




Begin {


    # Establish some common variables such as an empty array for the results
    $computer = $env:COMPUTERNAME
    $date = Get-Date -Format g
    $results  = @()
    $os_info = @()
    $skipped = @()
    $skipped_path_names = @()
    $empty_line = ""


    # Extra parameters for $Sort which could be used after ValidateSet attribute              # Credit: Martin Pugh: "Get-FolderSizes"
    Switch ($Sort)  {
        "name"                  { $Sort = "Time Zone Id";Break }
        "id"                    { $Sort = "Time Zone Id";Break }
        "english"               { $Sort = "Time Zone Id";Break }
        "date"                  { $Sort = "Date (Current)";Break }
        "time"                  { $Sort = "Time (Current)";Break }
        "display"               { $Sort = "Offset";Break }
        "value"                 { $Sort = "Offset";Break }
        "standard time"         { $Sort = "Standard Time (in system language)";Break }
        "standard"              { $Sort = "Standard Time (in system language)";Break }
        "winter"                { $Sort = "Standard Time (in system language)";Break }
        "daylight saving time"  { $Sort = "Daylight Saving Time (in system language)";Break }
        "daylight"              { $Sort = "Daylight Saving Time (in system language)";Break }
        "summer"                { $Sort = "Daylight Saving Time (in system language)";Break }
    } # switch


    # Establish a default sort order
    If ($Sort -eq "Default") {
        $sort_command = { Sort-Object -property @{Expression="Date (Current)";Descending=$false}, @{Expression="Time (Current)";Descending=$false}, @{Expression="Time Zone Id";Descending=$false} }
    } Else {
        $sort_command = { Sort-Object -property $Sort -Descending:$Descending }
    } #  Else


    # Function used to convert the Time Zone Offset from minutes to hours
    function DayLight {
        param($minutes)
        If ($minutes -gt 0) {
            $hours = ($minutes / 60)
            [string]'+' + $hours + ' h'
        } ElseIf ($minutes -lt 0) {
            $hours = ($minutes / 60)
            [string]$hours + ' h'
        } ElseIf ($minutes -eq 0) {
            [string]'0 h (GMT)'
        } Else {
            [string]''
        } # else
    } # function




    # A function for creating alternating rows in HTML documents                              # Credit: Martin Pugh: "Get-FolderSizes"
    Function Set-AlternatingRows {
        [CmdletBinding()]
        Param (
            [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
            [object[]]$lines,

            [Parameter(Mandatory=$true)]
            [string]$CSS_even_class,

            [Parameter(Mandatory=$true)]
            [string]$CSS_odd_class
        )
        Begin {
            $class_name = $CSS_even_class
        } # Begin

        Process {
            ForEach ($line in $lines) {

                $line = $line.Replace("<tr>","<tr class=""$class_name"">")

                If ($class_name -eq $CSS_even_class) {
                    $class_name = $CSS_odd_class
                } Else {
                    $class_name = $CSS_even_class
                } # Else

                Return $line

            } # ForEach
        } # Process

    } # function (Set-AlternatingRows)




    # Test if the path exists
    If ((Test-Path $Path) -eq $false) {

        $invalid_path_was_found = $true

        # Display an error message in console
        $empty_line | Out-String
        Write-Warning "'$Path' doesn't seem to be a valid path name."
        $empty_line | Out-String
        Write-Verbose "Please consider checking that the save location path '$Path' was typed correctly and that it is a valid file system path, which points to a directory. If the path contains space characters, please add quotation marks around the path name." -verbose
        $empty_line | Out-String
        Write-Verbose "In which folder, directory or path would you like to save the generated Time Zone Tables to? Please enter a valid file system path to a directory (a full path name of a directory (a.k.a. a folder) i.e. folder path such as C:\Windows). If the path name includes space characters, please add quotation marks around the path name."
        $empty_line | Out-String
        $skip_text = "Couldn't open '$Path'..."
        Write-Output $skip_text


                # Add the path as an object (with properties) to a collection of skipped paths
                $skipped += $obj_skipped = New-Object -TypeName PSCustomObject -Property @{

                            'Unresolved Path Names'     = $Path
                            'Owner'                     = ""
                            'Created on'                = ""
                            'Last Updated'              = ""
                            'Size'                      = "-"
                            'Error'                     = "The path was not found on $computer."
                            'raw_size'                  = 0

                    } # New-Object


        # Add the path name to a list of failed path names
        $skipped_path_names += $Path


    } Else {

        # Resolve path (if path is specified as relative)
        $Path = Resolve-Path -Path $Path

    } # else (if)

} # begin




Process {


    # Retrieve basic os and time zone related information from the local computer
    $os = Get-WmiObject -class Win32_OperatingSystem -ComputerName $computer
    $timezone = Get-WmiObject -class Win32_TimeZone -ComputerName $computer


                $os_info += $obj_osinfo = New-Object -TypeName PSCustomObject -Property @{

                    'Computer'                      = $computer
                    'Country Code'                  = $os.CountryCode
                    'Date'                          = $date
                    'Daylight Bias'                 = ((DayLight($timezone.DaylightBias)) + ' (' + $timezone.DaylightName + ')')
                    'Time Offset (Current)'         = (DayLight($timezone.Bias))
                    'Time Offset (Normal)'          = (DayLight($os.CurrentTimeZone))
                    'Time (Current)'                = (Get-Date).ToShortTimeString()
                    'Time (Normal)'                 = (((Get-Date).AddMinutes($timezone.DaylightBias)).ToShortTimeString() + ' (' + $timezone.StandardName + ')')
                #    'Daylight In Effect'            = $compsys.DaylightInEffect        # $compsys = Get-WmiObject -class Win32_ComputerSystem -ComputerName $computer
                    'Daylight In Effect'            = (Get-Date).IsDaylightSavingTime()
                    'Offset'                        = $timezone.Description

                } # New-Object


    # Gather the time zone list
    # For a complete list of supported time zone entries, refer to the values listed in the registry under HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones on a computer running Windows Vista or later.
    $time_zone_keys = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones\*'
    $find_this_pattern_and_replace_it_with = ".\w*.\d+.\d+.."


                        <# Regex Splat
                        # To be taken with a grain of salt...
                            A character class is a broader form of wildcard, representing an entire group of characters.

                                .   matches any one character -like ?.
                                *   matches any number of characters, including zero occurances of an instance.
                                +   matches any number of characters, and at least one has to be present.
                                \w  matches any word character, meaning letters and numbers.
                                \s  matches any white space character, such as tabs, spaces, and so forth.
                                \d  matches any digit character.

                            There are also negative character classes: \W matches any non-word character, \S matches non-white space characters, and \D matches non-digits.

                            After a match PowerShell creates an array $matches with $matches[n] refering to the match case number.
                        #>


    ForEach ($zone in $time_zone_keys) {

        # Add each HKLM key (an individual timezone) as an object (with properties) to a collection of results
        $results += $obj_time_zone = New-Object -TypeName PSCustomObject -Property @{

            'PSPath'                                    = $zone.PSPath
            'PSParentPath'                              = $zone.PSParentPath
            'Time Zone Id'                              = $zone.PSChildName
            'Date (Current)'                            = ([System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now,"$($zone.PSChildName)")).ToShortDateString()
            'Time (Current)'                            = ([System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now,"$($zone.PSChildName)")).ToString("HH:mm tt")

            'UTC'                                       = [regex]::matches($zone.Display, "\w*.\d+.\d+") | Select-Object -ExpandProperty Value
            'Area'                                      = [regex]::replace($zone.Display, $find_this_pattern_and_replace_it_with, "$empty_line")

            'PSDrive'                                   = $zone.PSDrive
            'PSProvider'                                = $zone.PSProvider
            'MUI_Display'                               = $zone.MUI_Display
            'MUI_Dlt'                                   = $zone.MUI_Dlt
            'MUI_Std'                                   = $zone.MUI_Std
            'Offset'                                    = $zone.Display
            'Daylight Saving Time (in system language)' = $zone.Dlt
            'Standard Time (in system language)'        = $zone.Std
            'TZI'                                       = $zone.TZI

            } # New-Object

        } # ForEach


} # Process




End {


    # Display Time Zone info in console
    $os_info.PSObject.TypeNames.Insert(0,"Time Zone Info")
    $os_info_selection = $os_info | Select-Object 'Computer','Country Code','Date','Daylight Bias','Time Offset (Current)','Time Offset (Normal)','Time (Current)','Time (Normal)','Daylight In Effect','Offset'
    $empty_line | Out-String
    $os_info_header = "Time Zone"
    $os_info_coline = "---------"
    Write-Output $os_info_header
    $os_info_coline | Out-String
    Write-Output $os_info_selection


    # Output the time zone list in a pop-up window (Out-GridView - the sorting probably needs to be further processed, since the output is actually not sorted according to any widely known sort mechanism)
    $results.PSObject.TypeNames.Insert(0,"Time Zones")
    $results_selection = $results | Select-Object 'Time Zone Id','Date (Current)','Time (Current)','Offset','UTC','Area','Standard Time (in system language)','Daylight Saving Time (in system language)','PSDrive','MUI_Std','MUI_Dlt','MUI_Display','TZI','PSProvider','PSParentPath','PSPath' | Invoke-Command -ScriptBlock $sort_command
    $results_selection | Out-GridView


    # If the path couldn't be resolved, notify the user (the else below html) - otherwise write the files (at the upper part of if statement)
    If (($invalid_path_was_found) -ne $true) {
        $enumeration_went_succesfully = $true


            # Write the characters to a CSV-file
            If ($characters_selection -ne $null) {
                $results_selection | Export-Csv $path\time_zones.csv -Delimiter ';' -NoTypeInformation -Encoding UTF8
            } Else {
                $continue = $true
            } # else


        # Create a HTML Time Zone Table                                                       # Credit: Martin Pugh: "Get-FolderSizes"

        # Define the HTML header
        # In the CSS style section .even and .odd apply to the custom function Set-AlternatingRows (Outlook ignores "nth-child" definitions in CSS).
        # So after defining the custom function Set-AlternatingRows the .odd and .even are specified in the CSS style section.
        # After ConvertTo-Html has outputted to a pipeline Set-AlternatingRows is then allowed to change lines (from "<tr>" to "<tr class='$class_name'>") in the source code at hand.
        # To improve the formatting of HTML code in Visual Studio Code, press Shift + Alt + F and the selected area will be reformatted.


        $header = @"
<style>
    table {
        border-width: 1px;
        border-style: solid;
        border-color: black;
        border-collapse: collapse;
    }

    th {
        border-width: 1px;
        padding: 3px;
        border-style: solid;
        border-color: black;
        background-color: #6495ED;
    }

    td {
        border-width: 1px;
        padding: 3px;
        border-style: solid;
        border-color: black;
    }

    .odd {
        background-color: #ffffff;
    }

    .even {
        background-color: #dddddd;
    }
</style>
<title>
    Time Zone Table
</title>
"@


        $timezone_os_summary = $os_info_selection | ConvertTo-Html -Fragment -As Table | Set-AlternatingRows -CSS_even_class odd -CSS_odd_class even | Out-String
        $results_selection_html = $results | Select-Object 'Time Zone Id','Date (Current)','Time (Current)','Offset','UTC','Area','Standard Time (in system language)','Daylight Saving Time (in system language)','PSDrive','PSPath' | Invoke-Command -ScriptBlock $sort_command
        $pre = "<h1>Time Zone Table</h1><h3>Listing the $($results_selection_html.Count) supported Time Zone entries found on $computer</h3>"
        $post = "<h3>Total: $($results_selection_html.Count) Time Zones</h3><br /><br /><h2>The Time Zone in Use on $computer</h2> $timezone_os_summary <p>Generated: $(Get-Date -Format g)<br />Computer: $computer</p>"


        # Create the Time Zone Table and save it to a file
        $HTML = $results_selection_html | ConvertTo-Html -PreContent $pre -PostContent $post -Head $header -As Table | Set-AlternatingRows -CSS_even_class even -CSS_odd_class odd | Out-File -Encoding UTF8 $Path\time_zones.html


        # Display the Time Zone Table in the default browser
        # & $Path\time_zones.html
        Start-Process -FilePath "$Path\time_zones.html" | Out-Null


    } Else {
        $enumeration_went_succesfully = $false

        # Display the skipped path names in console
        $empty_line | Out-String
        $skipped.PSObject.TypeNames.Insert(0,"Skipped Path Names")
        $skipped_selection = $skipped | Select-Object 'Unresolved Path Names','Size','Error' | Sort-Object 'Unresolved Path Names'
        $skipped_selection | Format-Table -auto
        $stats_text = "The files were not created."
        $empty_line | Out-String
        Write-Output $stats_text
        $empty_line | Out-String

    } # else

} # End




# [End of Line]


<#


   _____
  / ____|
 | (___   ___  _   _ _ __ ___ ___
  \___ \ / _ \| | | | '__/ __/ _ \
  ____) | (_) | |_| | | | (_|  __/
 |_____/ \___/ \__,_|_|  \___\___|




https://blogs.msdn.microsoft.com/bclteam/2007/06/07/exploring-windows-time-zones-with-system-timezoneinfo-josh-free/    # Josh Free: "Exploring Windows Time Zones with System.TimeZoneInfo"
https://community.spiceworks.com/scripts/show/1738-get-foldersizes                            # Martin Pugh: "Get-FolderSizes"
http://stackoverflow.com/questions/15114615/dynamic-parameter-accessing-default-value         #  CB.: "Dynamic parameter accessing default value"
https://blogs.technet.microsoft.com/heyscriptingguy/2016/09/16/powertip-use-powershell-to-retrieve-the-date-and-time-of-the-given-time-zone-id/ "PowerTip: Use PowerShell to retrieve the date and time of the given time zone ID"



  _    _      _
 | |  | |    | |
 | |__| | ___| |_ __
 |  __  |/ _ \ | '_ \
 | |  | |  __/ | |_) |
 |_|  |_|\___|_| .__/
               | |
               |_|
#>

<#

.SYNOPSIS
Generates Time Zone tables to a specified location.

.DESCRIPTION
Get-TimeZoneTable queries the general Time Zone information list from the Windows 
registry under the
"HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones\" key and stores
the found properties (subkeys, of which, in essence, each subkey contains the data
of an individual time zone) as an collection of objects. In addition to the 
Windows registry query Get-TimeZoneTable uses Windows Management Instrumentation 
(WMI) to retrieve the current Time Zone and other basic computer information. The 
results are displayed in a pop-up window (Out-GridView), written to a HTML Time 
Zone Table -file and to a CSV-file. The files are saved to the path defined by 
a parameter called -Path and -Sort and -Descending parameters toggle, how the 
results are written to those files.

.PARAMETER Path
which has an alias called -ReportPath (so they both act exactly the same way).
The -Path parameter specifies where the HTML Time Zone Table and the adjacent
CSV-file is to be saved. The default save location is $env:temp, which points to
the current temporary file location, which is set in the system. The default -Path
save location is defined at line 12 with the $Path variable. If no save location
is defined in the command, the files are saved to $env:temp.

It's not always mandatory to write -Path in the command to invoke the -Path
parameter, as is shown in the Examples below, since Get-TimeZoneTable is trying to
decipher the inputted commands as good as it is machinely possible within a 50 KB
size limit.

The save location path should be valid file system path to a directory (a full path
name of a directory (i.e. folder path such as C:\Windows)). In case the path name
includes space characters, please add quotation marks around the path name. For
usage, please see the Examples below and for more information about $env:temp,
please see the Notes section below.

.PARAMETER Sort
Specifies which column is the primary sort column in the HTML Time Zone Table and other
outputs. Only one column may be selected in one command as the primary column.
If -Sort parameter is not defined, Get-TimeZoneTable will try to sort by Date (Current),
Time (Current) and Time Zone Id in an ascending order.

In the HTML Time Zone Table and other outputs all the headers are sortable (with the
commands) and some headers have aliases, too. Valid -Sort values are listed below.
Please also see the Examples section for further usage examples.


    Valid -Sort values:


    Value                                       Sort Behavior
    -----                                       -------------
    "Time Zone Id"                              Sort by Time Zone Id
    Name                                        Sort by Time Zone Id
    Id                                          Sort by Time Zone Id
    English                                     Sort by Time Zone Id
    "Date (Current)"                            Sort by Date (Current)
    Date                                        Sort by Date (Current)
    "Time (Current)"                            Sort by Time (Current)
    Time                                        Sort by Time (Current)
    Offset                                      Sort by Offset
    Display                                     Sort by Offset
    Value                                       Sort by Offset
    UTC                                         Sort by UTC
    Area                                        Sort by Area
    "Standard Time (in system language)"        Sort by Standard Time (in system language)
    "Standard Time"                             Sort by Standard Time (in system language)
    Standard                                    Sort by Standard Time (in system language)
    Winter                                      Sort by Standard Time (in system language)
    "Daylight Saving Time (in system language)" Sort by Daylight Saving Time (in system language)
    "Daylight Saving Time"                      Sort by Daylight Saving Time (in system language)
    Daylight                                    Sort by Daylight Saving Time (in system language)
    Summer                                      Sort by Daylight Saving Time (in system language)
    PSDrive                                     Sort by PSDrive
    PSPath                                      Sort by PSPath


.PARAMETER Descending
A switch to control how directories get sorted in the HTML Time Zone Table and other
outputs, when also the -Sort parameter is used. By default Get-TimeZoneTable tries
to sort everything in an ascending order. After defining the primary sort column
with the -Sort parameter the prevalent ascending sort order may be reversed by adding the
-Descending parameter to the command.

.OUTPUTS
Generates an HTML Time Zone Table and an adjacent CSV-file in a specified Path
($Path = "$env:temp" at line 12), which is user-settable with the -Path parameter. Displays 
the prevalent time zone in console. In addition to that...


One pop-up window "$results_selection" (Out-GridView) with sortable headers (with a click):

        Name                                Description
        ----                                -----------
        $results_selection                  Displays the Time Zone Table


And also the aforementioned HTML-file "Time Zone Table" and CSV-file at
$Path. The HTML-file "Time Zone Table" is opened automatically in the
default browser after the query is finished.

$env:temp\time_zones.html           : HTML-file          : time_zones.html
$env:temp\time_zones.csv            : CSV-file           : time_zones.csv

.NOTES
Please note that all the parameters can be used in one query command and that each
of the parameters can be "tab completed" before typing them fully (by pressing
the [tab] key).

Please also note that the two files are created in a directory, which is end-user
settable in each command with the -Path parameter. The default save location is
defined with the $Path variable (at line 12) and the -Path parameter also has an
alias called -ReportPath. The default save location $env:temp variable points to
the current temp folder. The default value of the $env:temp variable is
C:\Users\<username>\AppData\Local\Temp (i.e. each user account has their own
separate temp folder at path %USERPROFILE%\AppData\Local\Temp). To see the
current temp path, for instance a command

    [System.IO.Path]::GetTempPath()

may be used at the PowerShell prompt window [PS>]. To change the temp folder for
instance to C:\Temp, please, for example, follow the instructions at
http://www.eightforums.com/tutorials/23500-temporary-files-folder-change-location-windows.html

    Homepage:           https://github.com/auberginehill/get-time-zone-table
                        Short URL: http://tinyurl.com/h5z2de6
    Version:            1.0

.EXAMPLE
./Get-TimeZoneTable

Run the script. Please notice to insert ./ or .\ before the script name.
Uses the default location ($env:temp) for storing the generated HTML Time Zone Table
and the adjacent CSV-file to. Outputs the Time Zone Table also in in a pop-up window
(Out-GridView). The data is sorted by Offset and would be tried to be arranged in an
ascending order.

.EXAMPLE
help ./Get-TimeZoneTable -Full
Display the help file.

.EXAMPLE
./Get-TimeZoneTable -Path "C:\Scripts"

Run the script and store the two Time Zone Table files to C:\Scripts. The output is
sorted, as per default, on the Offset property and tried to arrange in an ascending
order. Since the -Path variable has an alias of -ReportPath, a command

    ./Get-TimeZoneTable -ReportPath "C:\Scripts"

will do the exactly same thing. Please note that the -Path is not mandatory in this
example and that the quotation marks can be left out, since the path name doesn't
contain any space characters (./Get-TimeZoneTable C:\Scripts).

.EXAMPLE
./Get-TimeZoneTable -Path E:\chiore -Sort psdrive -Descending

Run the script and save the files to E:\chiore. Sort the data based on the "PSDRIVE"
column and arrange the rows as descending so that the last alphabets come to
the top and first alphabets will be at the bottom. To sort the same query in
an ascending order the -Descending parameter may be left out from the query command
(./Get-TimeZoneTable -Path E:\chiore -Sort psdrive).

.EXAMPLE
./Get-TimeZoneTable -Path C:\Scripts -Sort daylight -Descending

Run the script and save the HTML Time Zone Table and the adjacent CSV-file to C:\Scripts.
Sort the data by the column name "Daylight Saving Time (in system language)" in a
descending order. This command will work, because daylight is defined as an alias to the
"Daylight Saving Time (in system language)" in the script. Please also note, that -Path
can be omitted in this example, because a command

    ./Get-TimeZoneTable C:\Scripts -Sort daylight -Descending

in essence, has an exact same outcome.

.EXAMPLE
Set-ExecutionPolicy remotesigned

This command is altering the Windows PowerShell rights to enable script execution. Windows PowerShell
has to be run with elevated rights (run as an administrator) to actually be able to change the script
execution properties. The default value is "Set-ExecutionPolicy restricted".


    Parameters:

    Restricted      Does not load configuration files or run scripts. Restricted is the default
                    execution policy.

    AllSigned       Requires that all scripts and configuration files be signed by a trusted
                    publisher, including scripts that you write on the local computer.

    RemoteSigned    Requires that all scripts and configuration files downloaded from the Internet
                    be signed by a trusted publisher.

    Unrestricted    Loads all configuration files and runs all scripts. If you run an unsigned
                    script that was downloaded from the Internet, you are prompted for permission
                    before it runs.

    Bypass          Nothing is blocked and there are no warnings or prompts.

    Undefined       Removes the currently assigned execution policy from the current scope.
                    This parameter will not remove an execution policy that is set in a Group
                    Policy scope.


For more information, please type "help Set-ExecutionPolicy -Full" or visit
https://technet.microsoft.com/en-us/library/hh849812.aspx.

.EXAMPLE
New-Item -ItemType File -Path C:\Temp\Get-TimeZoneTable.ps1

Creates an empty ps1-file to the C:\Temp directory. The New-Item cmdlet has an inherent -NoClobber mode
built into it, so that the procedure will halt, if overwriting (replacing the contents) of an existing
file is about to happen. Overwriting a file with the New-Item cmdlet requires using the Force.
For more information, please type "help New-Item -Full".

.LINK
https://blogs.msdn.microsoft.com/bclteam/2007/06/07/exploring-windows-time-zones-with-system-timezoneinfo-josh-free/
https://community.spiceworks.com/scripts/show/1738-get-foldersizes
http://stackoverflow.com/questions/15114615/dynamic-parameter-accessing-default-value
https://blogs.technet.microsoft.com/heyscriptingguy/2016/09/16/powertip-use-powershell-to-retrieve-the-date-and-time-of-the-given-time-zone-id/
https://technet.microsoft.com/en-us/library/hh847796.aspx
https://technet.microsoft.com/en-us/magazine/hh360993.aspx
https://msdn.microsoft.com/en-us/library/ms714434(v=vs.85).aspx
https://technet.microsoft.com/en-us/library/hh847743.aspx
http://social.technet.microsoft.com/wiki/contents/articles/15994.powershell-advanced-function-parameter-attributes.aspx
https://technet.microsoft.com/en-us/library/ee692803.aspx
https://technet.microsoft.com/en-us/magazine/2007.11.powershell.aspx
http://www.johndcook.com/blog/powershell_perl_regex/

#>



