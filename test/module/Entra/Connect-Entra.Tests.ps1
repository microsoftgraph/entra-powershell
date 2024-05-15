BeforeAll{
    if($null -eq (Get-Module -Name Microsoft.Graph.Entra)){
        Import-Module Microsoft.Graph.Entra      
    }

    Mock -CommandName Connect-MgGraph -MockWith {} -ModuleName Microsoft.Graph.Entra
}
Describe "Connect-Entra"{
    Context "Positive scenarios"{
        It "should return empty object"{
            $result = Connect-Entra -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e" -ApplicationId "8886ad7b-1795-4542-9808-c85859d97f23" -CertificateThumbprint F8813914053FBFB5D84F1EFA9EDB3205621C1126
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Connect-MgGraph -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should connect to specified env"{
            $result = Connect-Entra -Environment Global
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Connect-MgGraph -ModuleName Microsoft.Graph.Entra -Times 1
        }
    }
    Context "Negetive scenarios"{
        It "Should return error when TenantId is null"{
            { Connect-Entra -TenantId }| Should -Throw "Missing an argument for parameter 'TenantId'*"
        }
    }
}