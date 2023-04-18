// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract MyWill {
    struct patron {
        address patron;
        string name; //name of the client/patron
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

    modifier isAllowed() {
        require(
            msg.sender == person.patron ||
                (msg.sender == person.beneficiary &&
                    block.timestamp >=
                    (person.lastOwnerActive + person.lockingPeriod)),
            "Not Allowed!"
        );
        _;
    }

    function withdrawERC20(
        address _tokenAddress,
        address _to,
        uint _amount
    ) external isAllowed {
        IERC20Metadata token = IERC20Metadata(_tokenAddress);

        // get balace of token
        uint256 balance = token.balanceOf(address(this));
        // check of balance is less than required Amount
        require(balance >= _amount, "Not Enought Balance !");
        // transfer required amount
        token.transfer(_to, _amount);
        // emit event after transfer
        emit WithdrewERC20(_tokenAddress, msg.sender, _to, _amount);
    }

    function withdraw(address payable _to, uint256 _amount) external isAllowed {
        // check of balance is less than required Amount
        require(address(this).balance >= _amount, "Not Enought Balance !");
        // send celo (ether) to given address
        _to.transfer(_amount);
        // emit event
        emit Withdrew(msg.sender, _to, _amount);
    }

    function heartbeat() external isOwner {
        person.lastOwnerActive = block.timestamp;
    }

    receive() external payable {
        // check if sender is owner of the contract
        require(msg.sender == person.patron, "Not Owner");

        emit Received(msg.value);
    }
}
