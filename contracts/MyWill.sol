// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract MyWill {

    struct patron {
        address patron;
        string name;             //name of the client/patron
        uint256 lastOwnerActive; //at which time the owner was last active
        uint256 lockingPeriod; //for how much time patron can claim assets
        address beneficiary;
    }

    patron public person;

    constructor(
        string memory _name,
        address _owner,
        uint256 _lockingPeriod,
        address _beneficiary
    ) {
        person.name = _name;
        person.patron = _owner;
        person.lockingPeriod = _lockingPeriod;
        person.beneficiary = _beneficiary;

        // set last owner active time to current time
        person.lastOwnerActive = block.timestamp;
    }

    modifier isOwner() {
        require(msg.sender == person.patron, "Not owner");
        _;
    }

    event WithdrewERC20(address token, address by, address to, uint256 amount);
    event Withdrew(address by, address to, uint256 amount);
    event Received(uint256 amount);

}