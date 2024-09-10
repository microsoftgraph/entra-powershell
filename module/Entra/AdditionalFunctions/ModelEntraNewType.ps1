class EntraNewType {
    [string] $Id
    [string] $Description

    EntraNewType(){
        
    }
    EntraNewType([string]$id, [string]$description) {
        $this.Name = $id
        $this.Description = $description        
    }

}