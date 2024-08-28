BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-MgDevice with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "ComplianceExpirationDateTime"  = $null
                "AccountEnabled"                = $true
                "ApproximateLastSignInDateTime" = $null                
                "DeletedDateTime"               = $null
                "DeviceCategory"                = $null
                "DeviceId"                      = "6e9d44e6-f191-4957-bb31-c52f33817204"
                "DeviceMetadata"                = "MetaData"
                "DeviceOwnership"               = $null
                "DeviceVersion"                 = 2
                "DisplayName"                   = "Mock-Device"
                "EnrollmentProfileName"         = $null
                "Extensions"                    = $null
                "Id"                            = "74825acb-c984-4b54-ab65-d38347ea5e90"
                "IsCompliant"                   = $False
                "IsManaged"                     = $True
                "MdmAppId"                      = $null
                "MemberOf"                      = $null
                "OnPremisesLastSyncDateTime"    = $null
                "OnPremisesSecurityIdentifier"  = $null
                "OnPremisesSyncEnabled"         = $false
                "OperatingSystem"               = "WINDOWS"
                "OperatingSystemVersion"        = "10.0.22621.1700"               
                "ProfileType"                   = $null
                "RegisteredOwners"              = $null
                "RegisteredUsers"               = $null
                "RegistrationDateTime"          = $null
                "TransitiveMemberOf"            = $null
                "TrustType"                     = $null
                "PhysicalIds"                   = @{}
                "Parameters"                    = $args
            }
        )
    }

    Mock -CommandName Get-MgDevice -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraDevice" {
    Context "Test for Get-EntraDevice" {
        It "Should return specific device" {
            $result = Get-EntraDevice -ObjectId "bbbbbbbb-1111-2222-3333-ccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('74825acb-c984-4b54-ab65-d38347ea5e90')

            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraDevice -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return all devices" {
            $result = Get-EntraDevice -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All has an argument" {
            { Get-EntraDevice -All $true} | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        }       
        It "Should return specific device by searchstring" {
            $result = Get-EntraDevice -SearchString 'Mock-Device'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-Device'

            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        } 
        It "Should return specific device by filter" {
            $result = Get-EntraDevice -Filter "DisplayName -eq 'Mock-Device'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-Device'

            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Should return top device" {
            $result = Get-EntraDevice -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Property parameter should work" {
            $result = Get-EntraDevice -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock-Device'

            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Result should Contain ObjectId" {
            $result = Get-EntraDevice -ObjectId "74825acb-c984-4b54-ab65-d38347ea5e90"
            $result.ObjectId | should -Be "74825acb-c984-4b54-ab65-d38347ea5e90"
        }     
        It "Should contain DeviceId in parameters when passed ObjectId to it" {              
            $result = Get-EntraDevice -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.DeviceId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {               
            $result = Get-EntraDevice -SearchString 'Mock-Device'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Mock-Device"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDevice"
            $result = Get-EntraDevice -SearchString 'Mock-Device'
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraDevice -SearchString 'Mock-Device' -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}