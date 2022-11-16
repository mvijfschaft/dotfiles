<#
.SYNOPSIS
    Creates a new dotnet solution with Core, CLI, and API projects, and opens it
    in the text editor.
#>
function New-Solution {
    param (
        [string]
        $Path = '.'
    )

    if (-not (Test-Path $Path)) {
        mkdir $Path | Out-Null
    }
    elseif (Get-ChildItem $Path -Force) {
        throw 'Error: Directory not empty'
    }

    Push-Location $Path
    dotnet new sln
    dotnet new editorconfig

    Set-Content Directory.Build.props @(
        '<Project>'
        '    <PropertyGroup>'
        '        <AssemblyName>$(SolutionName).$(MSBuildProjectName)</AssemblyName>'
        '        <RootNamespace>$(AssemblyName.Replace(" ", "_"))</RootNamespace>'
        '        <Deterministic>true</Deterministic>'
        '    </PropertyGroup>'
        '</Project>'
    )

    mkdir Core | Push-Location
    dotnet new classlib @args
    Remove-Item *.cs
    dotnet sln .. add .
    Pop-Location

    mkdir Cli | Push-Location
    dotnet new console @args
    dotnet add reference ../Core
    dotnet sln .. add .
    Pop-Location

    mkdir Api | Push-Location
    dotnet new webapi --no-https @args
    dotnet add reference ../Core
    dotnet sln .. add .
    Pop-Location

    mkdir Api.Tests | Push-Location
    dotnet new xunit @args
    dotnet add reference ../Api
    dotnet sln .. add .
    Pop-Location

    dotnet new gitignore
    git init
    git commit --no-edit --allow-empty --allow-empty-message
    git add --all
    git commit --message Initial

    edit . ./Api/Controllers/WeatherForecastController.cs

    Pop-Location
}
