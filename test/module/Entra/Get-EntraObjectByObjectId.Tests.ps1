
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @{
            value = @(
                @{
                    "Id"                               = "fd560167-ff1f-471a-8d74-3b0070abcea1" 
                    "OnPremisesSyncEnabled"            = $null
                    "userPrincipalName"                = "Adams@M365x99297270.OnMicrosoft.com"
                    "accountEnabled"                   = $true
                    "usageLocation"                    = "DE"
                    "displayName"                      = "Mock-App"
                    "userType"                         = "User"
                    "OnPremisesLastSyncDateTime"       = $null
                    "onPremisesProvisioningErrors"     = @{}
                    "Parameters"                       = $args
                }
            )
        }
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra

}


Describe "Get-EntraObjectByObjectId" {
    Context "Test for Get-EntraObjectByObjectId" {
        It "Should return specific object by objectId" {
            $result = Get-EntraObjectByObjectId -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'fd560167-ff1f-471a-8d74-3b0070abcea1'
            $result.displayName | should -Be 'Mock-App'
             $result.userType | should -Be 'User'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraObjectByObjectId -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectIds'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraObjectByObjectId -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectIds' because it is an empty string*"
        }
        It "Should return specific object by objectId and Types" {
            $result = Get-EntraObjectByObjectId -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -Types "User"
            $result | Should -Not -BeNullOrEmpty
            $result.userType | should -Be 'User'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraObjectByObjectId -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -Types } | Should -Throw "Missing an argument for parameter 'Types'*"
        }
        It "Should contain Ids in parameters when passed Id to it" {              
            $result = Get-EntraObjectByObjectId -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result.Parameters
            $para= $params | ConvertTo-json | ConvertFrom-Json
            $para.Body.Ids | Should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraObjectByObjectId"

            $result = Get-EntraObjectByObjectId -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" 
            $params = Get-Parameters -data $result.Parameters
            $para= $params | ConvertTo-json | ConvertFrom-Json
            $para.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }

    }

}    