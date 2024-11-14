# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll{
    if($null -eq (Get-Module -Name Microsoft.Graph.Entra)){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "\EntraCmdletsMap.ps1") -Force

    
}

Describe "Valid parameter Tests"{
    Context "Test for valid parameters"{      
        It "Should debug Remove cmdlet with Id parameter"{
            Write-Host "--------Start mock remove cmdlets with Id parameter only--------"
            $count=0
            $module = Get-Module -Name Microsoft.Graph.Entra
            $module.ExportedCommands.Keys | ForEach-Object{
                $commandName = $_
                $command = Get-Command $_
                if($command.Name.StartsWith('Remove')){
                    $params = ($command.ParameterSets.Parameters | Where-Object {$_.IsMandatory -eq $true} | select -expand Name)
                    if($params.count -eq 1 -and $params -eq 'Id'){
                        $filter = $cmdlets | Where-Object { $_.SourceName -eq $command }
                        if($null -ne $filter){                             
                            try { 
                                Write-Host "$command"                                
                                $commandScriptBlock = [scriptblock]::Create("$commandName -Id 056b2531-005e-4f3e-be78-01a71ea30a04 -Debug")                                
                                if($filter.IsApi){                                     
                                    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
                                    $result = Invoke-Command -ScriptBlock $commandScriptBlock 
                                    $result | Should -BeNullOrEmpty
                                    Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
                                }
                                else {                                    
                                    Mock -CommandName $filter.TargetName -MockWith {} -ModuleName Microsoft.Graph.Entra    
                                    $result = Invoke-Command -ScriptBlock $commandScriptBlock 
                                    $result | Should -BeNullOrEmpty
                                    Should -Invoke -CommandName $filter.TargetName -ModuleName Microsoft.Graph.Entra -Times 1                                
                                }
                            }
                            catch {
                                Write-Host "Exception in cmdlet" $command
                            }
                            $count++
                        }      
                    }
                }
            }
            Write-Host "Cmdlets count: $count"
            Write-Host "---------End mock remove cmdlets with Id parameter only---------"
        }
        It "Should debug Remove cmdlet with ObjectId parameter"{
            Write-Host "--------Start mock remove cmdlets with ObjectId parameter only--------"
            $count=0
            $module = Get-Module -Name Microsoft.Graph.Entra
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $module.ExportedCommands.Keys | ForEach-Object{
                $commandName = $_
                $command = Get-Command $_
                if($command.Name.StartsWith('Remove')){
                    $params = ($command.ParameterSets.Parameters | Where-Object {$_.IsMandatory -eq $true} | select -expand Name)
                    if($params.count -eq 1 -and $params -eq 'ObjectId'){
                        $filter = $cmdlets | Where-Object { $_.SourceName -eq $command }
                        if($null -ne $filter){   
                            $originalDebugPreference = $DebugPreference
                            $DebugPreference = 'Continue'                          
                            try { 
                                Write-Host "$command"                                
                                $commandScriptBlock = [scriptblock]::Create("$commandName -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04 -Debug")                                
                                if($filter.IsApi){   
                                                         
                                    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
                                    $result = Invoke-Command -ScriptBlock $commandScriptBlock 
                                    $result | Should -BeNullOrEmpty
                                    Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
                                }
                                else {                                    
                                    Mock -CommandName $filter.TargetName -MockWith {} -ModuleName Microsoft.Graph.Entra    
                                    $result = Invoke-Command -ScriptBlock $commandScriptBlock 
                                    $result | Should -BeNullOrEmpty
                                    Should -Invoke -CommandName $filter.TargetName -ModuleName Microsoft.Graph.Entra -Times 1                                
                                }
                            }
                            catch {
                                Write-Host "Exception in cmdlet" $command
                            }
                            $DebugPreference = $originalDebugPreference
                            $count++
                        }      
                    }
                }
            }

            Write-Host "Cmdlets count: $count"
            Write-Host "---------End mock remove cmdlets with ObjectId parameter only---------"
        }
        It "Should debug Get cmdlet with ObjectId parameter"{
            Write-Host "--------Start mock Get cmdlets with ObjectId parameter only--------"
            $count=0
            $module = Get-Module -Name Microsoft.Graph.Entra
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $module.ExportedCommands.Keys | ForEach-Object{
                $commandName = $_
                $command = Get-Command $_
                if($command.Name.StartsWith('Get')){
                    $params = ($command.ParameterSets.Parameters | Where-Object {$_.IsMandatory -eq $true} | select -expand Name)
                    if($params -eq 'ObjectId'){
                        $filter = $cmdlets2 | Where-Object { $_.SourceName -eq $command }
                        if($null -ne $filter){   
                            $originalDebugPreference = $DebugPreference
                            $DebugPreference = 'Continue'                          
                            try { 
                                Write-Host "$command"                                
                                $commandScriptBlock = [scriptblock]::Create("$commandName -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04 -Debug")                                
                                if($filter.IsApi){   
                                                                      
                                    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
                                    $result = Invoke-Command -ScriptBlock $commandScriptBlock 
                                    $result | Should -BeNullOrEmpty
                                    Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
                                }
                                else {                                    
                                    Mock -CommandName $filter.TargetName -MockWith {} -ModuleName Microsoft.Graph.Entra    
                                    $result = Invoke-Command -ScriptBlock $commandScriptBlock 
                                    $result | Should -BeNullOrEmpty
                                    Should -Invoke -CommandName $filter.TargetName -ModuleName Microsoft.Graph.Entra -Times 1                                
                                }
                            }
                            catch {
                                Write-Host "Exception in cmdlet" $command
                            }
                            $DebugPreference = $originalDebugPreference
                            $count++
                        }      
                    }
                }
            }

            Write-Host "Cmdlets count: $count"
            Write-Host "---------End mock remove cmdlets with ObjectId parameter only---------"
        }
        It "Should debug Get cmdlet with Id parameter"{
            Write-Host "--------Start mock Get cmdlets with Id parameter only--------"
            $count=0
            $module = Get-Module -Name Microsoft.Graph.Entra
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $module.ExportedCommands.Keys | ForEach-Object{
                $commandName = $_
                $command = Get-Command $_
                if($command.Name.StartsWith('Get')){
                    $params = ($command.ParameterSets.Parameters | Where-Object {$_.IsMandatory -eq $true} | select -expand Name)
                    if($params -eq 'Id'){
                        $filter = $cmdlets3 | Where-Object { $_.SourceName -eq $command }
                        if($null -ne $filter){   
                            $originalDebugPreference = $DebugPreference
                            $DebugPreference = 'Continue'                          
                            try { 
                                Write-Host "$command"                                
                                $commandScriptBlock = [scriptblock]::Create("$commandName -Id 056b2531-005e-4f3e-be78-01a71ea30a04 -Debug")                                
                                if($filter.IsApi){   
                                                                      
                                    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
                                    $result = Invoke-Command -ScriptBlock $commandScriptBlock 
                                    $result | Should -BeNullOrEmpty
                                    Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
                                }
                                else {                                    
                                    Mock -CommandName $filter.TargetName -MockWith {} -ModuleName Microsoft.Graph.Entra    
                                    $result = Invoke-Command -ScriptBlock $commandScriptBlock 
                                    $result | Should -BeNullOrEmpty
                                    Should -Invoke -CommandName $filter.TargetName -ModuleName Microsoft.Graph.Entra -Times 1                                
                                }
                            }
                            catch {
                                Write-Host "Exception in cmdlet" $command
                            }
                            $DebugPreference = $originalDebugPreference
                            $count++
                        }      
                    }
                }
            }

            Write-Host "Cmdlets count: $count"
            Write-Host "---------End mock remove cmdlets with ObjectId parameter only---------"
        }
        
    } 
}