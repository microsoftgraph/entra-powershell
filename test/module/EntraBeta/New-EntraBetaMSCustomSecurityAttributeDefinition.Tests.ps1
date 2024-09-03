BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "AllowedValues"             = ""
                "AttributeSet"              = "Test"
                "Description"               = "Target completion date"
                "Id"                        = "Test_Date"
                "IsCollection"              = $false
                "IsSearchable"              = $true 
                "Name"                      = "Date"
                "Status"                    = "Available"
                "Type"                      = "String"
                "UsePreDefinedValuesOnly"   = $true
                "AdditionalProperties"      = @{"@odata.context" = "https://graph.microsoft.com/beta/$metadata#directory/customSecurityAttributeDefinitions/$entity"}
                "Parameters"                = $args
            }
        )
    }    
    Mock -CommandName  New-MgBetaDirectoryCustomSecurityAttributeDefinition -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "New-EntraBetaMSCustomSecurityAttributeDefinition" {
    Context "Test for New-EntraBetaMSCustomSecurityAttributeDefinition" {
        It "Should create new custom security attribute definition" {
            $result = New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "Test" -Name "Date" -Description "Target completion date" -Type "String" -Status "Available" -IsCollection $false -IsSearchable $true -UsePreDefinedValuesOnly $true
            $result | Should -Not -BeNullOrEmpty
            $result.AllowedValues | should -BeNullOrEmpty
            $result.Id | should -Be 'Test_Date'
            $result.AttributeSet | should -Be 'Test'
            $result.Description | should -Be 'Target completion date'
            $result.Name | should -Be 'Date'
            $result.Status | should -Be 'Available'
            $result.Type | should -Be 'String'
            $result.IsCollection | should -Be $false
            $result.IsSearchable | should -Be $true
            $result.UsePreDefinedValuesOnly | should -Be $true

            Should -Invoke -CommandName  New-MgBetaDirectoryCustomSecurityAttributeDefinition -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when AttributeSet is empty" {
            { New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet  -Name "Date" -Description "Target completion date" -Type "String" -Status "Available" -IsCollection $false -IsSearchable $true -UsePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'AttributeSet'*"
        }

        It "Should fail when Description is empty" {
            { New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "Test" -Name "Date" -Description  -Type "String" -Status "Available" -IsCollection $false -IsSearchable $true -UsePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'Description'*"
        }

        It "Should fail when Name is empty" {
            { New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "Test" -Name -Description "Target completion date" -Type "String" -Status "Available" -IsCollection $false -IsSearchable $true -UsePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'Name'*"
        }

        It "Should fail when Type is empty" {
            { New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "Test" -Name "Date" -Description "Target completion date" -Type -Status "Available" -IsCollection $false -IsSearchable $true -UsePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'Type'*"
        }

        It "Should fail when Status is empty" {
            { New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "Test" -Name "Date" -Description "Target completion date" -Type "String" -Status -IsCollection $false -IsSearchable $true -UsePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'Status'*"
        }

        It "Should fail when IsCollection is empty" {
            { New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "Test" -Name "Date" -Description "Target completion date" -Type "String" -Status "Available" -IsCollection -IsSearchable $true -UsePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'IsCollection'*"
        }

        It "Should fail when IsSearchable is empty" {
            { New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "Test" -Name "Date" -Description "Target completion date" -Type "String" -Status "Available" -IsCollection $false -IsSearchable -UsePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'IsSearchable'*"
        }

        It "Should fail when UsePreDefinedValuesOnly is empty" {
            { New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "Test" -Name "Date" -Description "Target completion date" -Type "String" -Status "Available" -IsCollection $false -IsSearchable $true -UsePreDefinedValuesOnly  } | Should -Throw "Missing an argument for parameter 'UsePreDefinedValuesOnly'*"
        }

        It "Should fail when AttributeSet is invalid" {
            { New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "" -Name "Date" -Description "Target completion date" -Type "String" -Status "Available" -IsCollection $false -IsSearchable $true -UsePreDefinedValuesOnly $true } | Should -Throw "Cannot bind argument to parameter 'AttributeSet' because it is an empty string.*"
        }

        It "Should fail when Name is invalid" {
            { New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "Test" -Name "" -Description "Target completion date" -Type "String" -Status "Available" -IsCollection $false -IsSearchable $true -UsePreDefinedValuesOnly $true } | Should -Throw "Cannot bind argument to parameter 'Name' because it is an empty string.*"
        }

        It "Should fail when Type is invalid" {
            { New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "Test" -Name "Date" -Description "Target completion date" -Type "" -Status "Available" -IsCollection $false -IsSearchable $true -UsePreDefinedValuesOnly $true } | Should -Throw "Cannot bind argument to parameter 'Type' because it is an empty string.*"
        }

        It "Should fail when Status is invalid" {
            { New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "Test" -Name "Date" -Description "Target completion date" -Type "String" -Status "" -IsCollection $false -IsSearchable $true -UsePreDefinedValuesOnly $true } | Should -Throw "Cannot bind argument to parameter 'Status' because it is an empty string.*"
        }

        It "Should fail when IsCollection is invalid" {
            { New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "Test" -Name "Date" -Description "Target completion date" -Type "String" -Status "Available" -IsCollection "" -IsSearchable $true -UsePreDefinedValuesOnly $true } | Should -Throw "Cannot process argument transformation on parameter 'IsCollection'*"
        }

        It "Should fail when IsSearchable is invalid" {
            { New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "Test" -Name "Date" -Description "Target completion date" -Type "String" -Status "Available" -IsCollection $false -IsSearchable "" -UsePreDefinedValuesOnly $true } | Should -Throw "Cannot process argument transformation on parameter 'IsSearchable'*"
        }

        It "Should fail when UsePreDefinedValuesOnly is invalid" {
            { New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "Test" -Name "Date" -Description "Target completion date" -Type "String" -Status "Available" -IsCollection $false -IsSearchable $true -UsePreDefinedValuesOnly "" } | Should -Throw "Cannot process argument transformation on parameter 'UsePreDefinedValuesOnly'*"
        }

        It "Result should Contain ObjectId" {
            $result = New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "Test" -Name "Date" -Description "Target completion date" -Type "String" -Status "Available" -IsCollection $false -IsSearchable $true -UsePreDefinedValuesOnly $true
            $result.ObjectId | should -Be "Test_Date"
        } 

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaMSCustomSecurityAttributeDefinition"

            $result = New-EntraBetaMSCustomSecurityAttributeDefinition -AttributeSet "Test" -Name "Date" -Description "Target completion date" -Type "String" -Status "Available" -IsCollection $false -IsSearchable $true -UsePreDefinedValuesOnly $true
            $params = Get-Parameters -data $result.Parameters
            $params.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }    
    }
}
