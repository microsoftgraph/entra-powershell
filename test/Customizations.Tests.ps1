BeforeAll {    
    . (join-path $psscriptroot "../src/CompatibilityAdapter.ps1")
    if((Get-Module -Name Microsoft.Graph.Compatibility.AzureAD) -eq $null){
        Import-Module Microsoft.Graph.Compatibility.AzureAD
    }
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
        $files = Get-ChildItem -Path (join-path $psscriptroot "..\customizations") -Filter '*.ps1'        
    }

    It 'Checking naming conventios' {
        $files | ForEach-Object {
            $name = $_.Name.Replace(".ps1","")
            if("Generic" -ne $name){
                $value = . $_.FullName
                $name | Should -Be $value.SourceName 
            }            
        }
    }

    It 'Checking that customizations produce commands' {
        $files | ForEach-Object {
            $name = $_.Name.Replace(".ps1","")
            $name = $name.Replace("AzureAD","CompatAD")
            if("Generic" -ne $name){
                $module = Get-Module Microsoft.Graph.Compatibility.AzureAD
                $module.ExportedCommands.ContainsKey($name) | Should -BeTrue
            }
        }
    }
}