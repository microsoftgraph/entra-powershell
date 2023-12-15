BeforeAll {    
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module .\bin\Microsoft.Graph.Entra.psm1 -force
        Connect-MgGraph -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e" -AppId "8886ad7b-1795-4542-9808-c85859d97f23" -CertificateThumbprint 714CCF133715A7987BADA4E766FB3E9A1B3D8A6F
    }
}

# Test cases for Get-EntraGroup

Describe "Get-EntraGroup" {
    It "Should return specific group" {
        $result = Get-EntraGroup -ObjectId "e1c099f1-eb85-4b4c-b9ab-dabe82ecf682"
        $result | Should -Not -BeNullOrEmpty   
    }
    It "Should require ObjectId" {
        { Get-EntraGroup -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
    }
    It "Should return all group " {
        $result = Get-EntraGroup -All $true
        $result | Should -Not -BeNullOrEmpty
    }
    It "Should accept SearchString" {
        $result = Get-EntraGroup -SearchString "Parents of Contoso"
        $result.DisplayName | Should -Be "Parents of Contoso"
    }
    It "Should be empty for invalid SearchString" {
        $result = Get-EntraGroup -SearchString "abc"
        $result | Should -BeNullOrEmpty
    }
    It "Should return top groups" {
        $result = Get-EntraGroup -Top 1
        $result | Should -Not -BeNullOrEmpty
    }
    It "Should accept string for filter" {
        $result = Get-EntraGroup -Filter "DisplayName eq 'stest1'"
        $result.DisplayName | Should -Be @('stest1', 'stest1')
    }
    It "Should be empty for invalid string" {
        $result = Get-EntraGroup -Filter "DisplayName eq 'stest10'" 
        $result | Should -BeNullOrEmpty
    }
}
