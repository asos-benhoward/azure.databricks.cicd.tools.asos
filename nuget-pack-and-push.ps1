########
# pack
########
& ./nuget.exe pack 'azure.databricks.cicd.tools.asos.nuspec'


#get package just created
$package = Get-ChildItem -Path .\ -Filter 'azure.databricks.cicd.tools.asos.*.nupkg' | Sort-Object LastWriteTime -Descending | Select-Object -First 1

########
# push
########
Write-Host ("Pushing package: $($package.FullName)")

& ./nuget.exe push -Source "PE-ASOSPackages" -ApiKey az $package.FullName -SkipDuplicate

if ($LASTEXITCODE -ne 0) {
    Write-Host "NuGet push failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
} else {
    Write-Host "NuGet push succeeded."
}
