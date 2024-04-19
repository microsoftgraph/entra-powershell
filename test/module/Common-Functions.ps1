$psVersion = $global:PSVersionTable.PSVersion
$entraVersion = (Get-module Microsoft.Graph.Entra | select version).Version.ToString()

function Get-Parameters{
    param(
        $data
    )

    PROCESS{
        $params = @{}
        for ($i = 0; $i -lt $data.Length; $i += 2) {
            $key = $data[$i] -replace '-', '' -replace ':', ''
            $value = $data[$i + 1]
            $params[$key] = $value
        }

        $params
    }
}