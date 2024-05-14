BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Set-MgUserPhotoContent -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Set-EntraUserThumbnailPhoto" {
    Context "Test for Set-EntraUserThumbnailPhoto" {
        It "Should return specific User" {
            $result = Set-EntraUserThumbnailPhoto -ObjectId "26bb22db-6b8e-4adb-b761-264c869d5245" -FilePath D:\UserThumbnailPhoto.jpg
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Set-MgUserPhotoContent -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty string value" {
            { Set-EntraUserThumbnailPhoto -ObjectId ""} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when ObjectId is empty" {
            { Set-EntraUserThumbnailPhoto -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should fail when RefObjectId is invalid" {
            { Set-EntraUserThumbnailPhoto -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215"  RefObjectId ""} | Should -Throw "A positional parameter cannot be found that accepts argument*"
        }

        It "Should contain UserId in parameters when passed ObjectId to it" {
            Mock -CommandName Set-MgUserPhotoContent -MockWith { $args } -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraUserThumbnailPhoto -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -FilePath D:\UserThumbnailPhoto.jpg
            $params = Get-Parameters -data $result
            $params.UserId | Should -Match "412be9d1-1460-4061-8eed-cca203fcb215"
        }

        It "Should contain InFile in parameters" {
            Mock -CommandName Set-MgUserPhotoContent -MockWith { $args } -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraUserThumbnailPhoto -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -FilePath D:\UserThumbnailPhoto.jpg
            $params = Get-Parameters -data $result
            $params.InFile | Should -Match "UserThumbnailPhoto.jpg"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Set-MgUserPhotoContent -MockWith { $args } -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUserThumbnailPhoto"
            $result = Set-EntraUserThumbnailPhoto -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -FilePath D:\UserThumbnailPhoto.jpg
            $params = Get-Parameters -data $result

            $params.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }  

    }
}