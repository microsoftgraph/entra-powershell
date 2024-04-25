Describe "The Get-EntraApplication command executing unmocked" {

    Context "When getting applications" {
        BeforeAll {
            $testReportPath = join-path $psscriptroot "\setenv.ps1"
            Import-Module -Name $testReportPath
            $appId = $env:TEST_APPID
            $tenantId = $env:TEST_TENANTID
            $cert = $env:CERTIFICATETHUMBPRINT
            Connect-Entra -TenantId $tenantId  -AppId $appId -CertificateThumbprint $cert

            $thisTestInstanceId = New-Guid | select -expandproperty guid
            $groupId = (Get-EntraGroup -Top 1).Id
            $user = (Get-EntraUser -Top 1).Id
            $servicePrincipal = (Get-EntraServicePrincipal -Top 1).Id
        }

        It "should successfully add user to the Group" {
            Add-EntraGroupMember -ObjectId $groupId -RefObjectId $memberId
            $result = Get-EntraGroupMember -ObjectId $groupId
            $result.Id | Should -Contain $memberId
        }

        It "should successfully add service principal to the Group" {
            Add-EntraGroupMember -ObjectId $groupId -RefObjectId $memberId
            $result = Get-EntraGroupMember -ObjectId $servicePrincipal
            $result.Id | Should -Contain $memberId
        }

        It "should successfully add group to the Group" {
            Add-EntraGroupMember -ObjectId $groupId -RefObjectId $memberId
            $result = Get-EntraGroupMember -ObjectId $servicePrincipal
            $result.Id | Should -Contain $memberId
        }
        # It "should throw an exception if a nonexistent object ID parameter is specified" {
        #     $Id = (New-Guid).Guid
        #     Get-EntraGroupMember -ObjectId $Id -ErrorAction Stop
        #     $Error[0] | Should -match "Resource '([^']+)' does not exist"
        # }

        AfterAll {
            Remove-EntraGroupMember -ObjectId $groupId -MemberId $memberId
        }
    }
}
