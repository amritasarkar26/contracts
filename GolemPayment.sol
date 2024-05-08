// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8;

   contract golemRequest {

    address payable public provider;
    uint256 public paymentAmount;
    uint256 public requestTime;
    uint256 public completionTime;
    bool public isCompleted;

    event RequestStarted (address requester, uint256 amount);
    event RequestCompleted (address requester, uint256 completionTime);

    modifier onlyProvider() {

      require(msg.sender == provider, "Only provider can call this function");
      _;
    }

    constructor (uint256 _PaymentAmount) {

      provider = payable (msg.sender);
      paymentAmount = _PaymentAmount;
    }

     function requestResources() external payable {
      require (msg.value == paymentAmount, "incorrect payment amount");

      requestTime = block.timestamp;
      isCompleted = false;
      completionTime = 0;

      //Transfer amount to provider

      provider.transfer(address (this).balance);

      emit RequestCompleted(provider, completionTime);

     }

     function cancelRequest() external {
            require(msg.sender == provider, "Only provider can cancel the function");
            require (!isCompleted, "Request already completed");

            //Refund payment to requester
            payable(msg.sender).transfer(address (this).balance);

            isCompleted = true;

     }
    }
   
   

