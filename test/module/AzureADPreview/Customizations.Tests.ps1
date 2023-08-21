BeforeAll {    
    if((Get-Module -Name Microsoft.Graph.Compatibility.AzureAD.Preview) -eq $null){
        Import-Module Microsoft.Graph.Compatibility.AzureAD.Preview
    }
}



Describe 'Checking Files'{
    BeforeAll {
        $files = Get-ChildItem -Path (join-path $psscriptroot "..\..\..\module\AzureADPreview\customizations") -Filter '*.ps1'        
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
                $module = Get-Module Microsoft.Graph.Compatibility.AzureAD.Preview
                $module.ExportedCommands.ContainsKey($name) | Should -BeTrue
            }
        }
    }
}