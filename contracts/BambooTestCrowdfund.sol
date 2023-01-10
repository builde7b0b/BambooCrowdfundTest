// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;



// INTERFACE TO HELP WITH TRANSFER OF ERC20 TOKEN CALLS FROM ERC20 CONTRACT
interface IERC20 {
    function transfer(address, uint) external returns (bool);

    function transferFrom(
        address,
        address,
        uint
    ) external returns (bool);
}







   // START CONTRACT, DECLARE VARIABLES
contract BambooCrowdFund {
    struct Campaign { //create struct to store data of each campaign
        address creator; //Creator of the compaign
        uint goal; //campaign goal in number of tokens
        uint Contributed ; // amount Contributed 
        
        
        bool claimed; //true or false variable for campaign claim by creators
    }

    IERC20 public immutable token; //ERC20 Token contract
    uint public count; //Number of campaigns
    uint public maxDuration; //Max duration of each campaign

    // two mappings, 
    mapping(uint => Campaign) public campaigns; // map Campaign IDs to Campaigns
    mapping(uint => mapping(address => uint)) public TotalContribution; // Map address to Amount Contributed 



////////////////
////EVENTS///////
/////////////////

// fIRST Event to log Creation of Campaigns
    event StartCampaign( 
        uint id,
        address indexed creator,
        uint goal
        
    );

    // Events for each essential function of the contract, Cancel, Contribute, RemoveContribution, Claim, Refund
    event Cancel(uint id);
    event Contribute(uint indexed id, address indexed caller, uint amount);
    event RemoveContribution(uint indexed id, address indexed caller, uint amount);
    event Claim(uint id);
    event Refund(uint id, address indexed caller, uint amount);



    // CONSTRUCTOR FUNCTION 
    // takes only two args

    constructor(address _token, uint _maxDuration) {
        token = IERC20(_token);
        maxDuration = _maxDuration;
    }




    // First Main function - Launch Crowdfund Campaign
    //--------------------------

    function startCampaign(uint _goal) external {
       

        count += 1; // Increase Campagn Count
        campaigns[count] = Campaign({ //
            creator: msg.sender,
            goal: _goal,
            Contributed : 0,
            
            claimed: false // claim variable set to false on campaign launch
        });

        emit StartCampaign(count,msg.sender,_goal); // Log Campaign Launch tx
    }

    // Cancel Crowdfund Campaign
    //--------------------------

    function cancel(uint _id) external {
        Campaign memory campaign = campaigns[_id];
        require(campaign.creator == msg.sender, "You did not create this Campaign"); //Require caller to be creator
        

        delete campaigns[_id]; //remove campaign
        emit Cancel(_id); // Log Cancel tx
    }


    //--------------------------
    // Contribute to a Campaign

    function contribute(uint _id, uint _amount) external {
        Campaign storage campaign = campaigns[_id];
       
        campaign.Contributed  += _amount; //add current Campaign Contribution to Variable
        TotalContribution[_id][msg.sender] += _amount; // Add callers contribution to current total and variable
        token.transferFrom(msg.sender, address(this), _amount); //transfer tokens from caller to contract

        emit Contribute(_id, msg.sender, _amount); // Log Contribution tx
    }


    //--------------------------
    // Remove Contributoin from a Campaign

    function removeContribution(uint _id,uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        
        require(TotalContribution[_id][msg.sender] >= _amount,"You do not have enough tokens Contributed  to withraw");

        campaign.Contributed  -= _amount; // subtract amount from total campaign contribution
        TotalContribution[_id][msg.sender] -= _amount; // remove callers contribution to current total and update varaible
        token.transfer(msg.sender, _amount); // transfer tokens

        emit RemoveContribution(_id, msg.sender, _amount); // Log removal tx
    }



    //--------------------------
    // Claim Contributions from a SUCCESSFUL Campaign



    function claim(uint _id) external {
        Campaign storage campaign = campaigns[_id];

        //conditional statements
        require(campaign.creator == msg.sender, "You did not create this Campaign");
        
        require(campaign.Contributed  >= campaign.goal, "Campaign did not succed");
        require(!campaign.claimed, "claimed");

// set claimed to true so it can no longer be claimed
        campaign.claimed = true;
        token.transfer(campaign.creator, campaign.Contributed ); //tranfer tokens to creator

        emit Claim(_id); // log Claim tx
    }




    //--------------------------
    // Get a Refund from a Campaign or crowdfund 
    // 


    function refund(uint _id) external {
        Campaign memory campaign = campaigns[_id]; // ??
      
        require(campaign.Contributed  < campaign.goal, "You cannot Withdraw, Campaign has succeeded"); //require statement sets conditions for Successful execution
        // Campaign Creators cannot withdraw until campaign is SUCCESSFUL.

        uint bal = TotalContribution[_id][msg.sender]; // add users campaign contributions to a variable
        TotalContribution[_id][msg.sender] = 0; // update USer balance and transfer tokens to the creator
        token.transfer(msg.sender, bal);

        emit Refund(_id, msg.sender, bal); // log Refund tx
    }


}
