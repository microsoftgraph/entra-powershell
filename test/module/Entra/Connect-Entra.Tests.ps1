BeforeAll{
    if($null -eq (Get-Module -Name Microsoft.Graph.Entra)){
        Import-Module Microsoft.Graph.Entra      
    }

    Mock -CommandName Connect-MgGraph -MockWith {} -ModuleName Microsoft.Graph.Entra

    $ConnectEntraCommand = Get-Command Connect-Entra
}

Describe "Connect-Entra Mock"{
    It "should return empty object"{
        $result = Connect-Entra -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e" -ApplicationId "8886ad7b-1795-4542-9808-c85859d97f23" -CertificateThumbprint F8813914053FBFB5D84F1EFA9EDB3205621C1126
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Connect-MgGraph -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should connect to specified environment"{
        $result = Connect-Entra -Environment Global
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Connect-MgGraph -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should connect to an environment as a different identity"{
        $result = Connect-Entra -ContextScope "Process"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Connect-MgGraph -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should allow for authentication using environment variables"{
        $result = Connect-Entra -EnvironmentVariable
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Connect-MgGraph -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should return error when TenantId is null"{
        { Connect-Entra -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
    }
    It "Should return error when Environment is null"{
        { Connect-Entra -Environment } | Should -Throw "Missing an argument for parameter 'Environment'*"
    }
    It "Should return error when invalid parameter is provided"{
        { Connect-Entra -DisplayName } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'*"
    }
}

Describe "Connect-Entra ParameterSets"{
    It 'Should have three ParameterSets' {
        $ConnectEntraCommand | Should -Not -BeNullOrEmpty
        $ConnectEntraCommand.ParameterSets | Should -HaveCount 6
    }
    It 'Should have UserParameterSet' {
        $UserParameterSet = $ConnectEntraCommand.ParameterSets | Where-Object Name -eq 'UserParameterSet'
        $UserParameterSet | Should -Not -BeNull
        $UserParameterSet.IsDefault | Should -BeTrue
        $UserParameterSet.Parameters | Where-Object IsMandatory | Should -HaveCount 0
        @('ClientId', 'TenantId', 'ContextScope', 'Environment', 'ClientTimeout') | Should -BeIn $UserParameterSet.Parameters.Name
    }
    It 'Should have AppCertificateParameterSet' {
        $AppCertificateParameterSet = $ConnectEntraCommand.ParameterSets | Where-Object Name -eq 'AppCertificateParameterSet'
        $AppCertificateParameterSet | Should -Not -BeNull
        @('ClientId', 'TenantId', 'CertificateSubjectName', 'CertificateThumbprint', 'ContextScope', 'Environment', 'ClientTimeout') | Should -BeIn $AppCertificateParameterSet.Parameters.Name                
    }

    It 'Should have AppSecretCredentialParameterSet' {
        $AppSecretCredentialParameterSet = $ConnectEntraCommand.ParameterSets | Where-Object Name -eq 'AppSecretCredentialParameterSet'
        $AppSecretCredentialParameterSet | Should -Not -BeNull
        @('ClientSecretCredential', 'TenantId', 'ContextScope', 'Environment', 'ClientTimeout') | Should -BeIn $AppSecretCredentialParameterSet.Parameters.Name
        $MandatoryParameters = $AppSecretCredentialParameterSet.Parameters | Where-Object IsMandatory
        $MandatoryParameters | Should -HaveCount 0
    }

    It 'Should have EnvironmentVariableParameterSet' {
        $EnvironmentVariableParameterSet = $ConnectEntraCommand.ParameterSets | Where-Object Name -eq 'EnvironmentVariableParameterSet'
        $EnvironmentVariableParameterSet | Should -Not -BeNull
        @('EnvironmentVariable', 'ContextScope', 'Environment', 'ClientTimeout') | Should -BeIn $EnvironmentVariableParameterSet.Parameters.Name
        $MandatoryParameters = $EnvironmentVariableParameterSet.Parameters | Where-Object IsMandatory
        $MandatoryParameters | Should -HaveCount 0
    }

    It 'Should Have AccessTokenParameterSet' {
        $AccessTokenParameterSet = $ConnectEntraCommand.ParameterSets | Where-Object Name -eq 'AccessTokenParameterSet'
        $AccessTokenParameterSet | Should -Not -BeNull
        @('AccessToken', 'Environment', 'ClientTimeout') | Should -BeIn $AccessTokenParameterSet.Parameters.Name
    }
}