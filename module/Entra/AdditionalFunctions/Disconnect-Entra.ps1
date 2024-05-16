function Disconnect-Entra { 
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param ()   
    Disconnect-MgGraph
}