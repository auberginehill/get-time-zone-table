<!-- Visual Studio Code: For a more comfortable reading experience, use the key combination Ctrl + Shift + V
     Visual Studio Code: To crop the tailing end space characters out, please use the key combination Ctrl + Shift + X
     Visual Studio Code: To improve the formatting of HTML code, press Shift + Alt + F and the selected area will be reformatted in a html file.


   _____      _       _______ _                ______             _______    _     _
  / ____|    | |     |__   __(_)              |___  /            |__   __|  | |   | |
 | |  __  ___| |_ ______| |   _ _ __ ___   ___   / / ___  _ __   ___| | __ _| |__ | | ___
 | | |_ |/ _ \ __|______| |  | | '_ ` _ \ / _ \ / / / _ \| '_ \ / _ \ |/ _` | '_ \| |/ _ \
 | |__| |  __/ |_       | |  | | | | | | |  __// /_| (_) | | | |  __/ | (_| | |_) | |  __/
  \_____|\___|\__|      |_|  |_|_| |_| |_|\___/_____\___/|_| |_|\___|_|\__,_|_.__/|_|\___|              -->



## Get-TimeZoneTable.ps1

<table>
    <tr>
        <td style="padding:6px"><strong>OS:</strong></td>
        <td style="padding:6px">Windows</td>
    </tr>
    <tr>
        <td style="padding:6px"><strong>Type:</strong></td>
        <td style="padding:6px">A Windows PowerShell script</td>
    </tr>
    <tr>
        <td style="padding:6px"><strong>Language:</strong></td>
        <td style="padding:6px">Windows PowerShell</td>
    </tr>
    <tr>
        <td style="padding:6px"><strong>Description:</strong></td>
        <td style="padding:6px">Get-TimeZoneTable queries the general Time Zone information list from the Windows registry under the "<code>HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones\</code>" key and stores the found properties (subkeys, of which, in essence, each subkey contains the data of an individual time zone) as an collection of objects. In addition to the Windows registry query Get-TimeZoneTable uses Windows Management Instrumentation (WMI) to retrieve the current Time Zone and other basic computer information. The results are displayed in a pop-up window (Out-GridView), written to a HTML Time Zone Table -file and to a CSV-file. The files are saved to the path defined by a parameter called <code>-Path</code> and <code>-Sort</code> and <code>-Descending</code> parameters toggle, how the results are written to those files.</td>
    </tr>
    <tr>
        <td style="padding:6px"><strong>Homepage:</strong></td>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-time-zone-table">https://github.com/auberginehill/get-time-zone-table</a>
            <br />Short URL: <a href="http://tinyurl.com/h5z2de6">http://tinyurl.com/h5z2de6</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><strong>Version:</strong></td>
        <td style="padding:6px">1.0</td>
    </tr>
    <tr>
        <td style="padding:6px"><strong>Sources:</strong></td>
        <td style="padding:6px">
            <table>
                <tr>
                    <td style="padding:6px">Emojis:</td>
                    <td style="padding:6px"><a href="https://api.github.com/emojis">https://api.github.com/emojis</a></td>
                </tr>
                <tr>
                    <td style="padding:6px">Josh Free:</td>
                    <td style="padding:6px"><a href="https://blogs.msdn.microsoft.com/bclteam/2007/06/07/exploring-windows-time-zones-with-system-timezoneinfo-josh-free/">Exploring Windows Time Zones with System.TimeZoneInfo</a></td>
                </tr>
                <tr>
                    <td style="padding:6px">Martin Pugh:</td>
                    <td style="padding:6px"><a href="https://community.spiceworks.com/scripts/show/1738-get-foldersizes">Get-FolderSizes</a></td>
                </tr>
                <tr>
                    <td style="padding:6px">CB.:</td>
                    <td style="padding:6px"><a href="http://stackoverflow.com/questions/15114615/dynamic-parameter-accessing-default-value">Dynamic parameter accessing default value</a></td>
                </tr>
                <tr>
                    <td style="padding:6px">PowerTip:</td>
                    <td style="padding:6px"><a href="https://blogs.technet.microsoft.com/heyscriptingguy/2016/09/16/powertip-use-powershell-to-retrieve-the-date-and-time-of-the-given-time-zone-id/">Use PowerShell to retrieve the date and time of the given time zone ID</a></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td style="padding:6px"><strong>Downloads:</strong></td>
        <td style="padding:6px">For instance <a href="https://raw.githubusercontent.com/auberginehill/get-time-zone-table/master/Get-TimeZoneTable.ps1">Get-TimeZoneTable.ps1</a>. Or <a href="https://github.com/auberginehill/get-time-zone-table/archive/master.zip">everything as a .zip-file</a>.</td>
    </tr>
</table>




### Parameters

<table>
    <tr>
        <th>:triangular_ruler:</th>
        <td style="padding:6px">
            <ul>
                <li>
                    <h5>Parameter <code>-Path</code></h5>
                    <p>which has an alias called <code>-ReportPath</code> (so they both act exactly the same way). The <code>-Path</code> parameter specifies where the HTML Time Zone Table and the adjacent CSV-file is to be saved. The default save location is <code>$env:temp</code>, which points to the current temporary file location, which is set in the system. The default <code>-Path</code> save location is defined at line 12 with the <code>$Path</code> variable. If no save location is defined in the command, the files are saved to <code>$env:temp</code>.</p>
                    <p>It's not always mandatory to write <code>-Path</code> in the command to invoke the <code>-Path</code> parameter, as is shown in the Examples below, since Get-TimeZoneTable is trying to decipher the inputted commands as good as it is machinely possible within a 50 KB size limit.</p>
                    <p>The save location path should be valid file system path to a directory (a full path name of a directory (i.e. folder path such as <code>C:\Windows</code>)). In case the path name includes space characters, please add quotation marks around the path name. For usage, please see the Examples below and for more information about <code>$env:temp</code>, please see the Notes section below.</p>
                </li>
            </ul>
        </td>
    </tr>
    <tr>
        <th></th>
        <td style="padding:6px">
            <ul>
                <p>
                    <li>
                        <h5>Parameter <code>-Sort</code></h5>
                        <p>Specifies which column is the primary sort column in the HTML Time Zone Table and other outputs. Only one column may be selected in one command as the primary column. If <code>-Sort</code> parameter is not defined, Get-TimeZoneTable will try to sort by Date (Current), Time (Current) and Time Zone Id in an ascending order.</p>
                        <p>In the HTML Time Zone Table and other outputs all the headers are sortable (with the commands) and some headers have aliases, too. Valid <code>-Sort</code> values are listed below. Please also see the Examples section for further usage examples.</p>
                        <p>In the HTML
                        <ol>
                            <h4>Valid <code>-Sort</code> values:</h4>
                            <p>
                                <table>
                                    <tr>
                                        <td style="padding:6px"><strong>Value</strong></td>
                                        <td style="padding:6px"><strong>Sort Behavior</strong></td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>"Time Zone Id"</code></td>
                                        <td style="padding:6px">Sort by Time Zone Id</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>Name</code></td>
                                        <td style="padding:6px">Sort by Time Zone Id</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>Id</code></td>
                                        <td style="padding:6px">Sort by Time Zone Id</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>English</code></td>
                                        <td style="padding:6px">Sort by Time Zone Id</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>"Date (Current)"</code></td>
                                        <td style="padding:6px">Sort by Date (Current)</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>Date</code></td>
                                        <td style="padding:6px">Sort by Date (Current)</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>"Time (Current)"</code></td>
                                        <td style="padding:6px">Sort by Time (Current)</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>Time</code></td>
                                        <td style="padding:6px">Sort by Time (Current)</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>Offset</code></td>
                                        <td style="padding:6px">Sort by Offset</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>Display</code></td>
                                        <td style="padding:6px">Sort by Offset</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>Value</code></td>
                                        <td style="padding:6px">Sort by Offset</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>UTC</code></td>
                                        <td style="padding:6px">Sort by UTC</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>"Standard Time (in system language)"</code></td>
                                        <td style="padding:6px">Sort by Standard Time (in system language)</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>"Standard Time"</code></td>
                                        <td style="padding:6px">Sort by Standard Time (in system language)</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>Standard</code></td>
                                        <td style="padding:6px">Sort by Standard Time (in system language)</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>Winter</code></td>
                                        <td style="padding:6px">Sort by Standard Time (in system language)</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>"Daylight Saving Time (in system language)"</code></td>
                                        <td style="padding:6px">Sort by Daylight Saving Time (in system language)</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>"Daylight Saving Time"</code></td>
                                        <td style="padding:6px">Sort by Daylight Saving Time (in system language)</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>Daylight</code></td>
                                        <td style="padding:6px">Sort by Daylight Saving Time (in system language)</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>Summer</code></td>
                                        <td style="padding:6px">Sort by Daylight Saving Time (in system language)</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>PSDrive</code></td>
                                        <td style="padding:6px">Sort by PSDrive</td>
                                    </tr>
                                    <tr>
                                        <td style="padding:6px"><code>PSPath</code></td>
                                        <td style="padding:6px">Sort by PSPath</td>
                                    </tr>
                                </table>
                            </p>
                        </ol>
                        </p>
                    </li>
                </p>
                <p>
                    <li>
                        <h5>Parameter <code>-Descending</code></h5>
                        <p>A switch to control how directories get sorted in the HTML Time Zone Table and other outputs, when also the <code>-Sort</code> parameter is used. By default Get-TimeZoneTable tries to sort everything in an ascending order. After defining the primary sort column with the <code>-Sort</code> parameter the prevalent ascending sort order may be reversed by adding the <code>-Descending</code> parameter to the command.</p>
                    </li>
                </p>
            </ul>
        </td>
    </tr>
</table>




### Outputs

<table>
    <tr>
        <th>:arrow_right:</th>
        <td style="padding:6px">
            <ul>
                <li>Generates an HTML Time Zone Table and an adjacent CSV-file in a specified Path (<code>$Path = "$env:temp"</code> at line 12), which is user-settable with the <code>-Path</code> parameter. Displays the prevalent time zone in console. In addition to that...</li>
            </ul>
        </td>
    </tr>
    <tr>
        <th></th>
        <td style="padding:6px">
            <ul>
                <p>
                    <li>One pop-up window "<code>$results_selection</code>" (Out-GridView) with sortable headers (with a click):</li>
                </p>
                <ol>
                    <p>
                        <table>
                            <tr>
                                <td style="padding:6px"><strong>Name</strong></td>
                                <td style="padding:6px"><strong>Description</strong></td>
                            </tr>
                            <tr>
                                <td style="padding:6px"><code>$results_selection</code></a></td>
                                <td style="padding:6px">Displays the Time Zone Table</td>
                            </tr>
                        </table>
                    </p>
                </ol>
                <p>
                    <li>And also the aforementioned HTML-file "Time Zone Table" and CSV-file at <code>$Path</code>. The HTML-file "Time Zone Table" is opened automatically in the default browser after the query is finished.</li>
                </p>
                <ol>
                    <p>
                        <table>
                            <tr>
                                <td style="padding:6px"><strong>Path</strong></td>
                                <td style="padding:6px"><strong>Type</strong></td>
                                <td style="padding:6px"><strong>Name</strong></td>
                            </tr>
                            <tr>
                                <td style="padding:6px"><code>$env:temp\time_zones.html</code></td>
                                <td style="padding:6px">HTML-file</td>
                                <td style="padding:6px"><code>time_zones.html</code></td>
                            </tr>
                            <tr>
                                <td style="padding:6px"><code>$env:temp\time_zones.csv</code></td>
                                <td style="padding:6px">CSV-file</td>
                                <td style="padding:6px"><code>time_zones.csv</code></td>
                            </tr>
                        </table>
                    </p>
                </ol>
            </ul>
        </td>
    </tr>
</table>




### Notes

<table>
    <tr>
        <th>:warning:</th>
        <td style="padding:6px">
            <ul>
                <li>Please note that all the parameters can be used in one query command and that each of the parameters can be "tab completed" before typing them fully (by pressing the <code>[tab]</code> key).</li>
            </ul>
        </td>
    </tr>
    <tr>
        <th></th>
        <td style="padding:6px">
            <ul>
                <p>
                    <li>Please also note that the two files are created in a directory, which is end-user settable in each query command with the <code>-Path</code> parameter. The default save location is defined with the <code>$Path</code> variable (at line 12) and the <code>-Path</code> parameter also has an alias called <code>-ReportPath</code>. The default save location <code>$env:temp</code> variable points to the current temp folder. The default value of the <code>$env:temp</code> variable is <code>C:\Users\&lt;username&gt;\AppData\Local\Temp</code> (i.e. each user account has their own separate temp folder at path <code>%USERPROFILE%\AppData\Local\Temp</code>). To see the current temp path, for instance a command
                    <br />
                    <br /><code>[System.IO.Path]::GetTempPath()</code>
                    <br />
                    <br />may be used at the PowerShell prompt window <code>[PS>]</code>. To change the temp folder for instance to <code>C:\Temp</code>, please, for example, follow the instructions at <a href="http://www.eightforums.com/tutorials/23500-temporary-files-folder-change-location-windows.html">Temporary Files Folder - Change Location in Windows</a>, which in essence are something along the lines:
                        <ol>
                           <li>Right click on Computer and click on Properties (or select Start → Control Panel → System). In the resulting window with the basic information about the computer...</li>
                           <li>Click on Advanced system settings on the left panel and select Advanced tab on the resulting pop-up window.</li>
                           <li>Click on the button near the bottom labeled Environment Variables.</li>
                           <li>In the topmost section labeled User variables both TMP and TEMP may be seen. Each different login account is assigned its own temporary locations. These values can be changed by double clicking a value or by highlighting a value and selecting Edit. The specified path will be used by Windows and many other programs for temporary files. It's advisable to set the same value (a directory path) for both TMP and TEMP.</li>
                           <li>Any running programs need to be restarted for the new values to take effect. In fact, probably also Windows itself needs to be restarted for it to begin using the new values for its own temporary files.</li>
                        </ol>
                    </li>
                </p>
            </ul>
        </td>
    </tr>
</table>




### Examples

<table>
    <tr>
        <th>:book:</th>
        <td style="padding:6px">To open this code in Windows PowerShell, for instance:</td>
   </tr>
   <tr>
        <th></th>
        <td style="padding:6px">
            <ol>
                <p>
                    <li><code>./Get-TimeZoneTable</code><br />
                    Run the script. Please notice to insert <code>./</code> or <code>.\</code> before the script name. Uses the default location (<code>$env:temp</code>) for storing the generated HTML Time Zone Table and the adjacent CSV-file to. Outputs the Time Zone Table also in in a pop-up window (Out-GridView). The data is sorted by Date (Current), Time (Current) and Time Zone Id in an ascending order.</li>
                </p>
                <p>
                    <li><code>help ./Get-TimeZoneTable -Full</code><br />
                    Display the help file.</li>
                </p>
                <p>
                    <li><code>./Get-TimeZoneTable -Path "C:\Scripts"</code><br />
                    Run the script and store the two Time Zone Table files to C:\Scripts. The output is sorted, as per default, on the properties Date (Current), Time (Current) and Time Zone Id in an ascending order. Since the -Path variable has an alias of -ReportPath, a command
                    <br />
                    <br /><code>./Get-TimeZoneTable -ReportPath "C:\Scripts"</code>
                    <br />
                    <br />will do the exactly same thing. Please note that the <code>-Path</code> is not mandatory in this example and that the quotation marks can be left out, since the path name doesn't contain any space characters (<code>./Get-TimeZoneTable C:\Scripts</code>).</li>
                </p>
                <p>
                    <li><code>./Get-TimeZoneTable -Path E:\chiore -Sort psdrive -Descending</code><br />
                    Run the script and save the files to <code>E:\chiore</code>. Sort the data based on the "PSDRIVE" column and arrange the rows as descending so that the last alphabets come to the top and first alphabets will be at the bottom. To sort the same query in an ascending order the <code>-Descending</code> parameter may be left out from the query command (<code>./Get-TimeZoneTable -Path E:\chiore -Sort psdrive</code>).</li>
                </p>
                <p>
                    <li><code>./Get-TimeZoneTable -Path C:\Scripts -Sort daylight -Descending</code><br />
                    Run the script and save the HTML Time Zone Table and the adjacent CSV-file to <code>C:\Scripts</code>. Sort the data by the column name "Daylight Saving Time (in system language)" in a descending order. This command will work, because daylight is defined as an alias to the "Daylight Saving Time (in system language)" in the script. Please also note, that <code>-Path</code> can be omitted in this example, because a command
                    <br />
                    <br /><code>./Get-TimeZoneTable C:\Scripts -Sort daylight -Descending</code>
                    <br />
                    <br />in essence, has an exact same outcome.</li>
                </p>
                <p>
                    <li><p><code>Set-ExecutionPolicy remotesigned</code><br />
                    This command is altering the Windows PowerShell rights to enable script execution. Windows PowerShell has to be run with elevated rights (run as an administrator) to actually be able to change the script execution properties. The default value is "<code>Set-ExecutionPolicy restricted</code>".</p>
                        <p>Parameters:
                                <ol>
                                    <table>
                                        <tr>
                                            <td style="padding:6px"><code>Restricted</code></td>
                                            <td style="padding:6px">Does not load configuration files or run scripts. Restricted is the default execution policy.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>AllSigned</code></td>
                                            <td style="padding:6px">Requires that all scripts and configuration files be signed by a trusted publisher, including scripts that you write on the local computer.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>RemoteSigned</code></td>
                                            <td style="padding:6px">Requires that all scripts and configuration files downloaded from the Internet be signed by a trusted publisher.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>Unrestricted</code></td>
                                            <td style="padding:6px">Loads all configuration files and runs all scripts. If you run an unsigned script that was downloaded from the Internet, you are prompted for permission before it runs.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>Bypass</code></td>
                                            <td style="padding:6px">Nothing is blocked and there are no warnings or prompts.</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:6px"><code>Undefined</code></td>
                                            <td style="padding:6px">Removes the currently assigned execution policy from the current scope. This parameter will not remove an execution policy that is set in a Group Policy scope.</td>
                                        </tr>
                                    </table>
                                </ol>
                        </p>
                    <p>For more information, please type "<code>help Set-ExecutionPolicy -Full</code>" or visit <a href="https://technet.microsoft.com/en-us/library/hh849812.aspx">Set-ExecutionPolicy</a>.</p>
                    </li>
                </p>
                <p>
                    <li><code>New-Item -ItemType File -Path C:\Temp\Get-TimeZoneTable.ps1</code><br />
                    Creates an empty ps1-file to the <code>C:\Temp</code> directory. The <code>New-Item</code> cmdlet has an inherent <code>-NoClobber</code> mode built into it, so that the procedure will halt, if overwriting (replacing the contents) of an existing file is about to happen. Overwriting a file with the <code>New-Item</code> cmdlet requires using the <code>Force</code>.<br />
                    For more information, please type "<code>help New-Item -Full</code>".</li>
                </p>
            </ol>
        </td>
    </tr>
</table>




### Contributing

<p>Find a bug? Have a feature request? Here is how you can contribute to this project:</p>

 <table>
   <tr>
      <th><img class="emoji" title="contributing" alt="contributing" height="28" width="28" align="absmiddle" src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f33f.png"></th>
      <td style="padding:6px"><strong>Bugs:</strong></td>
      <td style="padding:6px"><a href="https://github.com/auberginehill/get-time-zone-table/issues">Submit bugs</a> and help us verify fixes.</td>
   </tr>
   <tr>
      <th rowspan="2"></th>
      <td style="padding:6px"><strong>Feature Requests:</strong></td>
      <td style="padding:6px">Feature request can be submitted by <a href="https://github.com/auberginehill/get-time-zone-table/issues">creating an Issue</a>.</td>
   </tr>
   <tr>
      <td style="padding:6px"><strong>Edit Source Files:</strong></td>
      <td style="padding:6px"><a href="https://github.com/auberginehill/get-time-zone-table/pulls">Submit pull requests</a> for bug fixes and features and discuss existing proposals.</td>
   </tr>
 </table>




### www

<table>
    <tr>
        <th><img class="emoji" title="www" alt="www" height="28" width="28" align="absmiddle" src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f310.png"></th>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-time-zone-table">Script Homepage</a></td>
    </tr>
    <tr>
        <th rowspan="13"></th>
        <td style="padding:6px">Josh Free: <a href="https://blogs.msdn.microsoft.com/bclteam/2007/06/07/exploring-windows-time-zones-with-system-timezoneinfo-josh-free/">Exploring Windows Time Zones with System.TimeZoneInfo</a></td>
    </tr>
    <tr>
        <td style="padding:6px">Martin Pugh: <a href="https://community.spiceworks.com/scripts/show/1738-get-foldersizes">Get-FolderSizes</a></td>
    </tr>
    <tr>
        <td style="padding:6px">CB.: <a href="http://stackoverflow.com/questions/15114615/dynamic-parameter-accessing-default-value">Dynamic parameter accessing default value</a></td>
    </tr>
    <tr>
        <td style="padding:6px">PowerTip: <a href="https://blogs.technet.microsoft.com/heyscriptingguy/2016/09/16/powertip-use-powershell-to-retrieve-the-date-and-time-of-the-given-time-zone-id/">Use PowerShell to retrieve the date and time of the given time zone ID</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://technet.microsoft.com/en-us/library/hh847796.aspx">about_Preference_Variables</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://technet.microsoft.com/en-us/magazine/hh360993.aspx">Windows PowerShell: Build a Better Function</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://msdn.microsoft.com/en-us/library/ms714434(v=vs.85).aspx">ValidateSet Attribute Declaration</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://technet.microsoft.com/en-us/library/hh847743.aspx">about_Functions_Advanced_Parameters</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="http://social.technet.microsoft.com/wiki/contents/articles/15994.powershell-advanced-function-parameter-attributes.aspx">PowerShell: Advanced Function Parameter Attributes</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://technet.microsoft.com/en-us/library/ee692803.aspx">Windows PowerShell Tip of the Week</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://technet.microsoft.com/en-us/magazine/2007.11.powershell.aspx">Windows PowerShell: Writing Regular Expressions</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="http://www.johndcook.com/blog/powershell_perl_regex/">Regular expressions in PowerShell and Perl</a></td>
    </tr>
    <tr>
        <td style="padding:6px">ASCII Art: <a href="http://www.figlet.org/">http://www.figlet.org/</a> and <a href="http://www.network-science.de/ascii/">ASCII Art Text Generator</a></td>
    </tr>
</table>




### Related scripts

 <table>
    <tr>
        <th><img class="emoji" title="www" alt="www" height="28" width="28" align="absmiddle" src="https://assets-cdn.github.com/images/icons/emoji/unicode/0023-20e3.png"></th>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-ascii-table">Get-AsciiTable</a></td>
    </tr>
    <tr>
        <th rowspan="9"></th>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-battery-info">Get-BatteryInfo</a></td>
    </tr>
    <tr>        
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-computer-info">Get-ComputerInfo</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-directory-size">Get-DirectorySize</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-installed-programs">Get-InstalledPrograms</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-installed-windows-updates">Get-InstalledWindowsUpdates</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-ram-info">Get-RAMInfo</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://gist.github.com/auberginehill/eb07d0c781c09ea868123bf519374ee8">Get-TimeDifference</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/get-unused-drive-letters">Get-UnusedDriveLetters</a></td>
    </tr>
    <tr>
        <td style="padding:6px"><a href="https://github.com/auberginehill/update-adobe-flash-player">Update-AdobeFlashPlayer</a></td>
    </tr>
</table>
