// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;
import "./MyWill.sol";

contract lockerMyWill {
    mapping(address => address[]) public lockers;

    // get all Lockers associated with given address
    function getLocker(address _owner) public view returns (address[] memory) {
        return lockers[_owner];
    }

    event NewLocker(address locker, address owner);

    // create new locker
    function newLocker(
        string memory _name,
        address _owner,
        uint256 _lockingTime,
        address _beneficiary
    ) external {
        // create new locker
        MyWill locker = new MyWill(_name, _owner, _lockingTime, _beneficiary);

        // Add mapping
        lockers[_owner].push(address(locker));

        // emit new locker event
        emit NewLocker(address(locker), _owner);
    }
}