function run {
  $Command = $args.ForEach( {
          if ($_ -isnot [string]) { return $_ }
          $Qualify = $_.ToCharArray().ForEach( { [char]::IsWhiteSpace($_) -or $_ -in @('"', "'") } ).Contains($true)
          $Value = $_.Replace("'", "''")
          if ($Qualify) { "'$Value'" } else { $Value }
      } ) -join ' '

  if (!$Quiet) { Write-Host "> $Command" -ForegroundColor DarkGray }
  Invoke-Expression $Command
}

function quietly { $Quiet = $true; run @args }
