<#--- Auto update the csproj <Version> to the current yyyy.MM.dd.HHmm when project is built ---#>

<#--- Add the following to your YourProject.Client csproj ---#>
<#
  <Target Name="PostBuild" AfterTargets="PostBuildEvent">
    <Exec Command="powershell.exe -ExecutionPolicy Unrestricted -NoProfile -NonInteractive -File $(ProjectDir)\post-build.ps1 -ProjectDir $(ProjectDir) -ProjectPath $(ProjectPath)" />
  </Target>
#>

param([string]$ProjectDir, [string]$ProjectPath);

$currentDate = get-date -format yyyy.MM.dd.HHmm;
$find = "<Version>(.|\n)*?</Version>";
$replace = "<Version>" + $currentDate + "</Version>";
$csproj = Get-Content $ProjectPath
$csprojUpdated = $csproj -replace $find, $replace

Set-Content -Path $ProjectPath -Value $csprojUpdated