// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {
    // Enum
    enum Status {
        Paid,
        Delivered,
        Received
    }
    Status public currentStatus;

    function paid() public {
        currentStatus = Status.Paid;
    }

    function delivered() public {
        currentStatus = Status.Delivered;
    }

    // Array
    // Fixed size:
    uint256[3][2] public items;

    function fixedSize() public {
        items = [[3, 4, 5], [6, 7, 8]];
    }

    // Dynamic
    uint256[] public itemsDinamic;
    uint256 public len;

    function dynArr() public {
        itemsDinamic.push(4);
        itemsDinamic.push(5);
        len = items.length;
    }

    function sampleMemory() public view returns (uint256[] memory) {
        uint256[] memory tempArray = new uint256[](10);
        tempArray[0] = 1;
        return tempArray;
    }

    // Byte
    bytes32 public myVar = "test here"; // fixed
    bytes public myDynVar = "test here"; // dynamic

    // 1 --> 32
    // 32 * 8 = 256
    // uint256

    function firstByte() public view returns (bytes1) {
        return myDynVar[0];
    }

    // Struct
    struct Payment {
        uint256 amount;
        uint256 timestamp;
        address from;
        string message;
    }

    struct Balance {
        uint256 totalPayments;
        mapping(uint256 => Payment) payments;
    }

    mapping(address => Balance) public balances;

    function getPayment(address _addr, uint256 _index)
        public
        view
        returns (Payment memory)
    {
        return balances[_addr].payments[_index];
    }

    function pay(string memory message) public payable {
        uint256 paymentNum = balances[msg.sender].totalPayments;
        balances[msg.sender].totalPayments++;

        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp,
            msg.sender,
            message
        );

        balances[msg.sender].payments[paymentNum] = newPayment;
    }
}
