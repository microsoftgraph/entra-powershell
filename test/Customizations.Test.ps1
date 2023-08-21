BeforeAll {    
    . (join-path $psscriptroot "../src/CompatibilityAdapter.ps1")
}

Describe 'Adding Customizations' {
    It 'Adding a valid customizations' {
        $mapper = [CompatibilityAdapterBuilder]::new($false)
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
        $mapper = [CompatibilityAdapterBuilder]::new($false)
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