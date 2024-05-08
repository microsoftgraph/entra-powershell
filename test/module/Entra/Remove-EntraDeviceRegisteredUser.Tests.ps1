BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        #Import-Module .\bin\Microsoft.Graph.Entra.psm1 -Force
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module .\test\module\Common-Functions.ps1 -Force

    Mock -CommandName Remove-MgDeviceRegisteredUserByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraDeviceRegisteredUser" {
    Context "Test for Remove-EntraDeviceRegisteredUser" {
        It "Should return empty object" {
            $result = Remove-EntraDeviceRegisteredUser -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755" -UserId "412be9d1-1460-4061-8eed-cca203fcb215"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDeviceRegisteredUserByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Remove-EntraDeviceRegisteredUser -ObjectId  -UserId "412be9d1-1460-4061-8eed-cca203fcb215" | Should -Throw "Missing an argument for parameter 'ObjectId'*" }
        }
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraDeviceRegisteredUser -ObjectId "" -UserId "412be9d1-1460-4061-8eed-cca203fcb215" | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string.*" }
        }
        It "Should fail when UserId is empty" {
            { Remove-EntraDeviceRegisteredUser -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755" -UserId  | Should -Throw "Missing an argument for parameter 'UserId'*" }
        }
        It "Should fail when UserId is invalid" {
            { Remove-EntraDeviceRegisteredUser -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755" -UserId "" | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string.*" }
        }  
        It "Should contain DeviceId in parameters when passed UserId to it" {
            Mock -CommandName Remove-MgDeviceRegisteredUserByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraDeviceRegisteredUser -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755" -UserId "412be9d1-1460-4061-8eed-cca203fcb215"
            $params = Get-Parameters -data $result
            $params.DeviceId | Should -Be "8542ebd1-3d49-4073-9dce-30f197c67755"
        } 
        It "Should contain DirectoryObjectId in parameters when passed UserId to it" {
            Mock -CommandName Remove-MgDeviceRegisteredUserByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraDeviceRegisteredUser -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755" -UserId "412be9d1-1460-4061-8eed-cca203fcb215"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "412be9d1-1460-4061-8eed-cca203fcb215"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgDeviceRegisteredUserByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDeviceRegisteredUser"

            $result = Remove-EntraDeviceRegisteredUser -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755" -UserId "412be9d1-1460-4061-8eed-cca203fcb215"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}