BeforeAll {    
    . (join-path $psscriptroot "../src/CompatibilityAdapter.ps1")
    if((Get-Module -Name Microsoft.Graph.Compatibility.AzureAD) -eq $null){
        Import-Module Microsoft.Graph.Compatibility.AzureAD
    }
}

Describe 'Checking Files'{
    BeforeAll {
        $files = Get-ChildItem -Path (join-path $psscriptroot "..\AdditionalFunctions") -Filter '*.ps1'        
    }

    It 'Checking that AdditionalFunctions produce commands' {
        $files | ForEach-Object {
            $name = $_.Name.Replace(".ps1","")
            $module = Get-Module Microsoft.Graph.Compatibility.AzureAD
            $module.ExportedCommands.ContainsKey($name) | Should -BeTrue
        }
    }
}