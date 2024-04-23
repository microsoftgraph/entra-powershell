if($null -eq (Get-Module -Name Microsoft.Graph.Entra)){
    Import-Module Microsoft.Graph.Entra
}

Describe "demo"{
    It "Should fail when parameters are empty"{
        $module = Get-Module -Name Microsoft.Graph.Entra
        $module.ExportedCommands.Keys | ForEach-Object{
            $command = Get-Command $_
            $GetViaIdentityParameterSet = $command.ParameterSets | Where-Object Name -eq "GetById"
            if($GetViaIdentityParameterSet.Parameters.Name -contains 'ObjectId'){     
                $objectId = ""
                $commandScriptBlock = [scriptblock]::Create("$command -ObjectId $objectId")
                {Invoke-Command -ScriptBlock $commandScriptBlock} | Should -Throw "Missing an argument for parameter 'ObjectId'.*"
            }
        }
    }
    It "Should fail when parameters are invalid"{
        $module = Get-Module -Name Microsoft.Graph.Entra
        $module.ExportedCommands.Keys | ForEach-Object{
            $command = Get-Command $_
                { Invoke-Command $command -demo "" } | Should -Throw "A parameter cannot be found that matches parameter name 'demo'."
            }
    }
}