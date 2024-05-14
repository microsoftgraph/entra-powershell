BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta

    $logoBytes = (Invoke-WebRequest "https://th.bing.com/th?q=Perennial+Garden+Ideas&w=138&h=138&c=7&o=5&dpr=1.3&pid=1.7&mkt=en-IN&cc=IN&setlang=en&adlt=moderate").Content
}

Describe "Set-EntraBetaMSApplicationLogo"{
    Context "Test for Set-EntraBetaMSApplicationLogo" {
        It "Should return empty object"{
            $result = Set-EntraBetaMSApplicationLogo -ObjectId f82a3f32-6bb6-404b-843c-5512fb3b35b8 -Content $logoBytes
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraBetaMSApplicationLogo -ObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is null" {
            { Set-EntraBetaMSApplicationLogo -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }  
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaMSApplicationLogo"
            $result = Set-EntraBetaMSApplicationLogo -ObjectId f82a3f32-6bb6-404b-843c-5512fb3b35b8 -Content $logoBytes
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}