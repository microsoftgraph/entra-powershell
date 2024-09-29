# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
              "DeletedDateTime"              = $null
              "AdditionalProperties"         = @{
                                                    "@odata.context"               = 'https://graph.microsoft.com/beta/$metadata#scopedRoleMemberships/$entity]'
                                                    "@odata.type"                  = "#microsoft.graph.group"
                                                    "createdByAppId"               = "8886ad7b-1795-4542-9808-c85859d97f23"
                                                    "DisplayName"                  = "Mock-Admin-UnitMember"
                                                    "mailNickname"                 = "Mock-Admin-UnitMember"
                                                    "organizationId"               = "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
                                                    "Description"                  = "NewAdministrativeUnitMember"
                                                    "groupTypes"                   = {"Unified", "DynamicMembership"}
                                                    "proxyAddresses"               = "SMTP:testGroupInAU10@M365x99297270.onmicrosoft.com"
                                                    "membershipRuleProcessingState"= "On"
                                                    "membershipRule"               = ("user.department -contains 'Marketing'")
                                                    "createdDateTime"              = "2024-06-03T06:03:32Z"
                                                    "securityIdentifier"           = "S-1-12-1-45050116-1081357872-244239291-3460319952"
                                                    "securityEnabled"              = $False
                                                    "Members"                      = $null
                                                    "ScopedRoleMembers"            = $null
                                                    "Visibility"                   = "Public"
                                                    
                                                }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName New-MGBetaAdministrativeUnitMember -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "New-EntraBetaAdministrativeUnitMember" {
    Context "Test for New-EntraBetaAdministrativeUnitMember" {
        It "Should return created administrative unit member" {
            $result = New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -OdataType "Microsoft.Graph.Group" -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False -GroupTypes @("Unified","DynamicMembership") -MembershipRule "(user.department -contains 'Marketing')" -MembershipRuleProcessingState "On" -IsAssignableToRole $False
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result.AdditionalProperties.DisplayName | Should -Be "Mock-Admin-UnitMember"
            $result.AdditionalProperties.Description | Should -Be "NewAdministrativeUnitMember"

            Should -Invoke -CommandName New-MGBetaAdministrativeUnitMember -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            {New-EntraBetaAdministrativeUnitMember -Id  -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { New-EntraBetaAdministrativeUnitMember -Id "" -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False} | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when DisplayName is empty" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName   -Description "NewAdministrativeUnitMember" -MailEnabled $True -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }
        It "Should fail when DisplayName is invalid" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName  "" -Description "NewAdministrativeUnitMember" -MailEnabled $True -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False } | Should -Throw "Cannot bind argument to parameter 'DisplayName' because it is an empty string."
        }
        It "Should fail when Description is empty" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName  "Mock-Admin-UnitMember" -Description  -MailEnabled $True -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False } | Should -Throw "Missing an argument for parameter 'Description'*"
        }
        It "Should fail when MailNickname is empty" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True -MailNickname  -SecurityEnabled $False } | Should -Throw "Missing an argument for parameter 'MailNickname'*"
        }
        It "Should fail when MailNickname is invalid" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True -MailNickname "" -SecurityEnabled $False } | Should -Throw "Cannot bind argument to parameter 'MailNickname' because it is an empty string."
        }
        It "Should fail when MailEnabled is empty" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled  -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False } | Should -Throw "Missing an argument for parameter 'MailEnabled'*"
        }
        It "Should fail when MailEnabled is invalid" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled xy -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False } | Should -Throw  "Cannot process argument transformation on parameter 'MailEnabled'*"
        }
        It "Should fail when SecurityEnabled is empty" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled  } | Should -Throw "Missing an argument for parameter 'SecurityEnabled'*"
        }
        It "Should fail when SecurityEnabled is invalid" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled xy } | Should -Throw  "Cannot process argument transformation on parameter 'SecurityEnabled'*"
        }
        It "Should fail when OdataType is empty" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -OdataType  -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True  -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False } | Should -Throw "Missing an argument for parameter 'OdataType'*"
        }
        It "Should fail when GroupTypes is empty" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -GroupTypes  -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True  -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False } | Should -Throw "Missing an argument for parameter 'GroupTypes'*"
        }
        It "Should fail when MembershipRule is empty" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -MembershipRule  -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True  -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False } | Should -Throw "Missing an argument for parameter 'MembershipRule'*"
        }
        It "Should fail when MembershipRuleProcessingState is empty" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -MembershipRuleProcessingState  -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True  -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False } | Should -Throw "Missing an argument for parameter 'MembershipRuleProcessingState'*"
        }
        It "Should fail when AssignedLabels is empty" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -AssignedLabels  -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True  -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False } | Should -Throw "Missing an argument for parameter 'AssignedLabels'*"
        }
        It "Should fail when ProxyAddresses is empty" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -ProxyAddresses  -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True  -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False } | Should -Throw "Missing an argument for parameter 'ProxyAddresses'*"
        }
        It "Should fail when IsAssignableToRole is empty" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False -IsAssignableToRole  } | Should -Throw "Missing an argument for parameter 'IsAssignableToRole'*"
        }
        It "Should fail when IsAssignableToRole is invalid" {
            { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False -IsAssignableToRole xy } | Should -Throw  "Cannot process argument transformation on parameter 'IsAssignableToRole'*"
        }
        It "Should contain @odata.type in parameters when passed OdataType to it" {
            $result = New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -OdataType "Microsoft.Graph.Group" -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False -GroupTypes @("Unified","DynamicMembership") -MembershipRule "(user.department -contains 'Marketing')" -MembershipRuleProcessingState "On" -IsAssignableToRole $False
            $jsonArray = $result.Parameters

            $hashTable = @{}
            for ($i = 0; $i -lt $jsonArray.Length; $i += 2) {
                $key = $jsonArray[$i] -replace '^-', '' -replace ':$', ''
                $value = $jsonArray[$i + 1]
                if ($value -is [PSCustomObject]) {
                    $value.PSObject.Properties | ForEach-Object { $_.Name = $_.Name -replace '^-', '' -replace ':$', '' }
                }
                $hashTable[$key] = $value
            }
            $OdataType = $hashTable.BodyParameter.AdditionalProperties.'@odata.type'
            $OdataType | Should -Be "Microsoft.Graph.Group"

        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaAdministrativeUnitMember"
            
            $result =  New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -OdataType "Microsoft.Graph.Group" -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False -GroupTypes @("Unified","DynamicMembership") -MembershipRule "(user.department -contains 'Marketing')" -MembershipRuleProcessingState "On" -IsAssignableToRole $False
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaAdministrativeUnitMember"
            Should -Invoke -CommandName New-MGBetaAdministrativeUnitMember -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { New-EntraBetaAdministrativeUnitMember -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -OdataType "Microsoft.Graph.Group" -DisplayName  "Mock-Admin-UnitMember" -Description "NewAdministrativeUnitMember" -MailEnabled $True -MailNickname "Mock-Admin-UnitMember" -SecurityEnabled $False -GroupTypes @("Unified","DynamicMembership") -MembershipRule "(user.department -contains 'Marketing')" -MembershipRuleProcessingState "On" -IsAssignableToRole $False -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}   