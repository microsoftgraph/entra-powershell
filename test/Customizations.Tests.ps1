BeforeAll {    
    . (join-path $psscriptroot "../src/CompatibilityAdapter.ps1")
}

Describe 'Adding Customizations' {
    It 'Adding a valid customizations' {
        $mapper = [CompatibilityAdapterBuilder]::new()
        $custom = @{
            SourceName = "ADTest"
            TargetName = "MgTest"
            Parameters = @(
                @{
                    SourceName = "ParamOLD"
                    TargetName = "ParamNew"
                    ConversionType = "Name"
                    SpecialMapping = $null
                }
            )
            Outputs = @(
                @{
                    SourceName = "ParamOLD"
                    TargetName = "ParamNew"
                    ConversionType = "Name"
                    SpecialMapping = $null
                }
            )
        }
        $mapper.AddCustomization($custom) | Should -Be $null
    }

    It 'Adding a invalid customizations' {
        $mapper = [CompatibilityAdapterBuilder]::new()
        $custom = @{
            SourceName = "ADTest"
            TargetName = "MgTest"
            Parameters = @(
                @{
                    SourceName = "ParamOLD"
                    TargetName = "ParamNew"
                    ConversionType = "CAT"
                    SpecialMapping = $null
                }
            )
            Outputs = $null
        }
        { $mapper.AddCustomization($custom) } | Should -Throw "*ConversionType*"
    }
}

Describe 'Checking Files'{
    BeforeAll {
        $files = Get-ChildItem -Path ..\customizations\ -Filter '*.ps1'
    }

    It 'Checking naming conventios' {
        $files | ForEach-Object {
            $name = $_.Name.Replace(".ps1","")
            if("Generic" -eq $name){
                continue
            }
            $value = . $_.FullName
            $name | Should -Be $value.SourceName 
        }
    }
}