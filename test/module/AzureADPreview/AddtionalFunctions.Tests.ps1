BeforeAll {    
    if((Get-Module -Name Microsoft.Graph.Compatibility.AzureAD.Preview) -eq $null){
        Import-Module Microsoft.Graph.Compatibility.AzureAD.Preview
    }
}

Describe 'Checking Files'{
    BeforeAll {
        $files = Get-ChildItem -Path (join-path $psscriptroot "..\..\..\module\AzureADPreview\AdditionalFunctions") -Filter '*.ps1'        
    }

    It 'Checking that AdditionalFunctions produce commands' {
        $files | ForEach-Object {
            $name = $_.Name.Replace(".ps1","")
            $module = Get-Module Microsoft.Graph.Compatibility.AzureAD.Preview
            $module.ExportedCommands.ContainsKey($name) | Should -BeTrue
        }
    }
}

AfterAll {
    Remove-Module -Name Microsoft.Graph.Compatibility.AzureAD.Preview -Force
}