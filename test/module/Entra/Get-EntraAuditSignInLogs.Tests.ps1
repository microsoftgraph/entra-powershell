BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-EntraAuditSignInLogs with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                conditionalAccessStatus  =      'success'
                userId                   =      'bbbbbbbb-1111-2222-3333-cccccccccccc'
                riskLevelDuringSignIn     =     'none'
                userPrincipalName        =      'test@m365x99297270.onmicrosoft.com'
                resourceDisplayName       =     'Windows Azure Active SignIn'
                riskEventTypes_v2        =      @{}
                ipAddress                =      '2409:40c2:401d:1cab:9464:4580:6282:b375'
                status                   =      @{}
                clientAppUsed            =      'Mobile Apps and Desktop clients'
                isInteractive           =       'True'
                createdDateTime         =       '06/21/2024 7:07:42 am'
                correlationId           =       'bbbbbbbb-1111-2222-3333-cccccccccc11'
                userDisplayName        =        'MOD Administrator'
                location              =         @{}
                riskDetail             =        'none'
                appDisplayName          =       'Azure Active SignIn PowerShell'
                id                          =   'bbbbbbbb-1111-2222-3333-cccccccccc22'
                appliedConditionalAccessPolicies =@{}
                deviceDetail               =    @{}
                riskLevelAggregated         =   'none'
                appId                       =   'bbbbbbbb-1111-2222-3333-cccccccccc55'
                resourceId                  =   'bbbbbbbb-1111-2222-3333-cccccccccc66'
                riskEventTypes              =   @{}
                riskState                  =    'none'


            }
        )
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraAuditSignInLogs" {
    Context "Test for Get-EntraAuditSignInLogs" {
        It "Should return specific Audit SignIn Logs" {
            $result = Get-EntraAuditSignInLogs -Id "bbbbbbbb-1111-2222-3333-cccccccccc22"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccc22'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }        
        It "Should fail when Id is empty" {
            { Get-EntraAuditSignInLogs -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }       
        It "Should fail when filter is empty" {
            { Get-EntraAuditSignInLogs -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should fail when Top is empty" {
            { Get-EntraAuditSignInLogs -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraAuditSignInLogs -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return all Audit SignIn Logs" {
            $result = Get-EntraAuditSignInLogs -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All has an argument" {
            { Get-EntraAuditSignInLogs -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }           
        
        It "Should return specific Audit SignIn Logs by filter" {
            $result = Get-EntraAuditSignInLogs -Filter "correlationId eq 'bbbbbbbb-1111-2222-3333-cccccccccc11'"
            $result | Should -Not -BeNullOrEmpty
            $result.id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccc22'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Should return top Audit SignIn Logs" {
            $result = @(Get-EntraAuditSignInLogs -Top 1)
            $result | Should -Not -BeNullOrEmpty
            $result | Should -HaveCount 1 

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        
        It "Should contain ID in parameters when passed Id to it" {
            $result = Get-EntraAuditSignInLogs -Id "bbbbbbbb-1111-2222-3333-cccccccccc22"
            
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc22"
        }
        
        It "Should contain 'User-Agent' header" {
          

            Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraAuditSignInLogs"
        $result = Get-EntraAuditSignInLogs -Id "bbbbbbbb-1111-2222-3333-cccccccccc22"
        $params = Get-Parameters -data $result
        $a= $params | ConvertTo-json | ConvertFrom-Json
        $a.headers.'User-Agent' | Should -Be $userAgentHeaderValue 
        }    
    }
}