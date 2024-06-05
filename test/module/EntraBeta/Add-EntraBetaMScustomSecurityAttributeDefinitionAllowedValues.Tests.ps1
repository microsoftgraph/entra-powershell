BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                   = "sss"
                "IsActive"             = $true
                "AdditionalProperties" = @{"@odata.context"="https://graph.microsoft.com/beta/$metadata#directory/customSecurityAttributeDefinitions('Engineering_Projectt')/allowedValues/$entity"}
                "Parameters"           = $args
            }
        )
    }    
    Mock -CommandName New-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Add-EntraBetaMScustomSecurityAttributeDefinitionAllowedValues" {
    Context "Test for Add-EntraBetaMScustomSecurityAttributeDefinitionAllowedValues" {
        It "Should update a specific value for the Id" {
            $result = Add-EntraBetaMScustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "sss" -IsActive $true
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "sss"
            $result.IsActive | Should -Be $true

            Should -Invoke -CommandName New-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when CustomSecurityAttributeDefinitionId are empty" {
            { Add-EntraBetaMScustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId  -Id "sss" -IsActive $true } | Should -Throw "Missing an argument for parameter 'CustomSecurityAttributeDefinitionId'*"
        }

        It "Should fail when CustomSecurityAttributeDefinitionId is Invalid" {
            { Add-EntraBetaMScustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId "" -Id "sss" -IsActive $true } | Should -Throw "Cannot bind argument to parameter 'CustomSecurityAttributeDefinitionId' because it is an empty string."
        }

        It "Should fail when Id are empty" {
            { Add-EntraBetaMScustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id -IsActive $true } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is Invalid" {
            { Add-EntraBetaMScustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "" -IsActive $true } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should fail when IsActive are empty" {
            { Add-EntraBetaMScustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "sss" -IsActive } | Should -Throw "Missing an argument for parameter 'IsActive'*"
        }

        It "Should fail when IsActive are invalid" {
            { Add-EntraBetaMScustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "sss" -IsActive dffg } | Should -Throw "Cannot process argument transformation on parameter 'IsActive'*"
        }

        It "Result should Contain ObjectId" {
            $result = Add-EntraBetaMScustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "sss" -IsActive $true
            $result.ObjectId | should -Be "sss"
        } 

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaMScustomSecurityAttributeDefinitionAllowedValues"
            
            $result = Add-EntraBetaMScustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "sss" -IsActive $true
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   
    }
}