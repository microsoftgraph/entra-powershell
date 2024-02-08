BeforeAll {    
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
}


Describe 'Checking Files'{
    BeforeAll {
        $files = Get-ChildItem -Path (join-path $psscriptroot "..\..\..\module\Entra\customizations") -Filter '*.ps1'        
    }

    It 'Checking naming conventios' {
        $files | ForEach-Object {
            $name = $_.Name -ireplace ".ps1",""
            if(("Generic" -ne $name) -and ("Types" -ne $name)){
                Write-Host "Checking $name"
                $value = . $_.FullName
                $name | Should -Be $value.SourceName 
            }            
        }
    }

    It 'Checking that customizations produce commands' {
        $files | ForEach-Object {
            $name = $_.Name -ireplace ".ps1",""
            $name = $name -ireplace "AzureAD","Entra"
            if(("Generic" -ne $name) -and ("Types" -ne $name)){
                Write-Host "Checking $name"
                $module = Get-Module Microsoft.Graph.Entra
                $module.ExportedCommands.ContainsKey($name) | Should -BeTrue
            }
        }
    }
}