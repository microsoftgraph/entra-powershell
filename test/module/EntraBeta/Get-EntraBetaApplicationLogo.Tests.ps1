BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        @{
            "Info" = @(
            @{
                "logoUrl"    = ""
                "Parameters" = $args
            })                     
        }
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
  
Describe "Get-EntraBetaApplicationLogo" {
    It "Should return empty" {
        $result = Get-EntraBetaApplicationLogo -ObjectId "dc587a80-d49c-4700-a73b-57227856fc32" -FilePath "D:\image.jpg"        
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { Get-EntraBetaApplicationLogo -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
    }
    It "Should fail when ObjectId is null" {
        { Get-EntraBetaApplicationLogo -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
    }
    # It "Should contain 'User-Agent' header" {
    #     Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta
    #     $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaApplicationLogo"
    #     $result = Get-EntraBetaApplicationLogo -ObjectId "dc587a80-d49c-4700-a73b-57227856fc32"
    #     $params = Get-Parameters -data $result
    #     $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    # } 
}