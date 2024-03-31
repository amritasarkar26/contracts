
// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract registerValidatorOnSSVNetwork {
   address public owner;
   address public user;
   address  Validator;
   mapping(address=> bool) public isConsideredAsValidator;
   constructor(address _user) {
    owner = msg.sender;
    user = _user;
   }

   modifier onlyUser() {
    require(msg.sender==user, "only user has access");
    _;
   }

   modifier onlyOwner() {
    require(msg.sender==owner, "only owner has access");
    _;
   }

   function registerAsValidator(address validator) public onlyOwner {
    require(validator != address(0), "validator address has to be valid");
    require(!isConsideredAsValidator[validator], "validator not considered as yet");
    isConsideredAsValidator[validator]=true;
   }

   function updateValidator(address _validator) public onlyOwner {
        require(isConsideredAsValidator[_validator], "validator not considered as yet");
     Validator = _validator;
   }

   function getValidatorInFo() public view onlyUser returns(address){
    require(isConsideredAsValidator[Validator], "validator not considered as yet");
    return Validator;

   }

   function removeValidator() public  onlyOwner {
    require(isConsideredAsValidator[Validator], "validator not considered as yet");
      isConsideredAsValidator[Validator] = false;
   }

   function isValidator(address _address) public view returns(bool) {
    return   isConsideredAsValidator[_address];
   }

   function getOwner() public view onlyOwner returns(address) {
      return owner;
   }
}
