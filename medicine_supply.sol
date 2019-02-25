// Solidity Version
pragma solidity >=0.4.26;

contract Medicines{
    // Global Variables
    address admin;
    Medicine[] medicines;
    uint[] ids;
    
    // Modifiers
    modifier checkAdmin(){
        require(msg.sender == admin,"You are not authorized.");
        _;
    }
    
    // Constructor
    constructor() public{
        admin = msg.sender;
    }
    
    // Admin Functions
    function getSuperAdmin() public view returns(address){
        return admin;
    }
    
    function setSuperAdmin(address superAdmin1) public checkAdmin{
        admin = superAdmin1; 
    }
    
    // Medicine Functions
    function addMedicine(uint id, uint q1, address sgAdmin1, address bhAdmin1, address phcAdmin1, address shcAdmin1, address anaAdmin1)public{
        medicines.push(new Medicine(id,q1,sgAdmin1,bhAdmin1,phcAdmin1,shcAdmin1,anaAdmin1));
        ids.push(id);
    }
    
    function getMedicines()public view returns(uint[] memory){
        return ids;
    }
    
    function getMedicineAddress()public view returns(Medicine[] memory){
        return medicines;
    }
}

contract Medicine{
    // Events
    event Quantity(uint);
    
    // Global Variables
    address anaAdmin;
    address hmAdmin;
    address shcAdmin;
    address phcAdmin;
    address sgAdmin;
    address bhAdmin;
    uint status;
    uint id;
    uint q;
    
    // Constructor
    constructor(uint id1, uint q1, address sgAdmin1, address bhAdmin1, address phcAdmin1, address shcAdmin1, address anaAdmin1) public{
        hmAdmin = msg.sender;
        id = id1;
        q=q1;
        sgAdmin=sgAdmin1;
        bhAdmin=bhAdmin1;
        phcAdmin=phcAdmin1;
        shcAdmin=shcAdmin1;
        anaAdmin=anaAdmin1;
        status = 1;
    }
    
    // Admin Functions
    function getSuperAdmin() public view returns(address){
        return hmAdmin;
    }
    
    function setSuperAdmin(address superAdmin1) public{
        require(msg.sender == hmAdmin,"You are not authorized.");
        hmAdmin = superAdmin1;
    }
    
    // Status Functions
    function getStatus()public view returns(uint){
        return status;
    }
    
    // SG Functions
    function approveSG()public {
        require(msg.sender == sgAdmin,"You are not Authorized");
        require(status==1,"Already approved");
        status=2;
    }
    
    // BH Functions
    function approveBH()public {
        require(msg.sender == bhAdmin,"You are not Authorized");
        require(status==2,"Already approved");
        status=3;
    }
    
    // PHC Functions
    function approvePHC()public {
        require(msg.sender == phcAdmin,"You are not Authorized");
        require(status==3,"Already approved");
        status=4;
    }
    
    // SHC Functions
    function approveSHC()public {
        require(msg.sender == shcAdmin,"You are not Authorized");
        require(status==4,"Already approved");
        status=5;
    }
    
    // ANA Functions
    function approveANA(uint q1)public {
        require(msg.sender == anaAdmin,"You are not Authorized");
        require(status==5,"Already approved");
        emit Quantity(q1);
    }
    
}
