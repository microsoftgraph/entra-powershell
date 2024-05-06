Describe "The EntraGroup command executing unmocked" {

    Context "When getting user and group" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\setenv.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert

            $thisTestInstanceId = New-Guid | Select-Object -expandproperty guid
            $global:displayName = 'DemoName' + $thisTestInstanceId
            
            $global:newGroup = New-EntraGroup -DisplayName $displayName -MailEnabled $false -SecurityEnabled $true -MailNickName $displayName
            Write-Host $newGroup
        }

        It "should successfully get a specific group by using an Id" {
            $group = Get-EntraGroup -ObjectId $newGroup.Id
            $group.Id | Should -Be $newGroup.Id
            $group.DisplayName | Should -Be $displayName
        }

        It "should successfully update a group display name" {
            $global:updatedDisplayName = "Demo Name 2"
            Set-EntraGroup -ObjectId $newGroup.Id -DisplayName $updatedDisplayName
            $result = Get-EntraGroup -ObjectId $newGroup.Id
            $result.Id | Should -Contain $newGroup.Id
        }

        
        AfterAll {
            if ($newGroup) {
                Remove-EntraGroup -ObjectId $newGroup.Id | Out-Null
            }
        }
    }
}