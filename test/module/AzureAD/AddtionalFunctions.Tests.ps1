BeforeAll {    
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
}

Describe 'Checking Files'{
    BeforeAll {
        $files = Get-ChildItem -Path (join-path $psscriptroot "..\..\..\module\AzureAD\AdditionalFunctions") -Filter '*.ps1'        
    }

    It 'Checking that AdditionalFunctions produce commands' {
        $files | ForEach-Object {
            $name = $_.Name.Replace(".ps1","")
            $module = Get-Module Microsoft.Graph.Entra
            $module.ExportedCommands.ContainsKey($name) | Should -BeTrue
        }
    }
}