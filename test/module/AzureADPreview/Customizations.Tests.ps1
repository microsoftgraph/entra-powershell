BeforeAll {    
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta
    }
}



Describe 'Checking Files'{
    BeforeAll {
        $files = Get-ChildItem -Path (join-path $psscriptroot "..\..\..\module\AzureADPreview\customizations") -Filter '*.ps1'        
    }

    It 'Checking naming conventios' {
        $files | ForEach-Object {
            $name = $_.Name -ireplace ".ps1",""
            if(("Generic" -ne $name) -and ("Types" -ne $name)){
                Write-Host "Checking nc $name"
                $value = . $_.FullName
                $name | Should -Be $value.SourceName 
            }            
        }
    }

    It 'Checking that customizations produce commands' {
        $files | ForEach-Object {
            $name = $_.Name -ireplace ".ps1",""
            $name = $name -ireplace "AzureAD","EntraBeta"
            if(("Generic" -ne $name) -and ("Types" -ne $name)){
                Write-Host "Checking cus $name"                
                $module = Get-Module Microsoft.Graph.Entra.Beta
                $module.ExportedCommands.ContainsKey($name) | Should -BeTrue
            }
        }
    }
}