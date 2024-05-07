BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                     = "fd560167-ff1f-471a-8d74-3b0070abcea1"
                "DisplayName"            = "Adams Smith"
                "UserPrincipalName"      = "Adams@contoso.com"
                "UserType"               = "Member"
                "appRoles"               = @{
                                                allowedMemberTypes=$null; 
                                                description="msiam_access";
                                                displayName="msiam_access"; 
                                                id="d0d7e4e4-96be-41c9-805a-08e0526868ad";
                                                isEnabled=$True; 
                                                origin="Application"
                                            }
                "oauth2PermissionScopes" = @{
                                                adminConsentDescription="Allow the application to access from tmplate test 3 on behalf of the signed-in user."; 
                                                adminConsentDisplayName="Access from tmplate test 3"; 
                                                id="64c2cef3-e118-4795-a580-a32bdbd7ba88"; 
                                                isEnabled=$True; 
                                                type="User";
                                                userConsentDescription="Allow the application to access from tmplate test 3 on your behalf."; 
                                                userConsentDisplayName="Access from tmplate test 3";
                                                value="user_impersonation"
                                            }
                "AdditionalProperties"   = @{
                                                "@odata.type" = "#microsoft.graph.servicePrincipal";
                                                accountEnabled = $true
                                            }
                "Parameters"             = $args
            }
        )
    }

    Mock -CommandName Get-MgServicePrincipalOwner -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "Get-EntraServicePrincipalOwner"{
    It "Result should not be empty" {
        $result = Get-EntraServicePrincipalOwner -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgServicePrincipalOwner -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { Get-EntraServicePrincipalOwner -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
    }
    It "Should return all applications" {
        $result = Get-EntraServicePrincipalOwner -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -All $true
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgServicePrincipalOwner -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when All is empty" {
        { Get-EntraServicePrincipalOwner -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -All } | Should -Throw "Missing an argument for parameter 'All'*"
    }
    It "Should return top application" {
        $result = Get-EntraServicePrincipalOwner -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -Top 1
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgServicePrincipalOwner -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Result should Contain ObjectId" {            
        $result = Get-EntraServicePrincipalOwner -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
        $result.ObjectId | should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"
    }
    It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {    
        $result = Get-EntraServicePrincipalOwner -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
        $params = Get-Parameters -data $result.Parameters
        $params.ServicePrincipalId | Should -Be "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalOwner"
        $result = Get-EntraServicePrincipalOwner -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
        $params = Get-Parameters -data $result.Parameters
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    }
}