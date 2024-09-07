import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "lib/sign-protocol-evm/src/interfaces/ISPHook.sol";
import "lib/sign-protocol-evm/src/interfaces/ISP.sol";
import "lib/sign-protocol-evm/src/models/DataLocation.sol";

import "lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";
import "lib/openzeppelin-contracts-upgradeable/contracts/utils/PausableUpgradeable.sol";

import "./Campaign.sol";

contract Hook is ISPHook, OwnableUpgradeable, PausableUpgradeable {
    using SafeERC20 for IERC20;
    using BookingLib for BookingSchedule;
    using CampaignLib for Campaign;

    event HookCalled(address sender, address attester, uint64 schemaId, uint64 attestationId);

    ISP public immutable sp = ISP(0x2b3224D080452276a76690341e5Cfa81A945a985);
    uint64 public schemaId;

    mapping(uint => Campaign) campaigns;
    uint public totalCampaigns;

    mapping(address blogger => mapping(uint campaignId => BlogPost)) posts;
    uint public totalPosts;

    modifier onlyCampaignOwner(uint campaignId) {
        require(campaigns[campaignId].started > 0, "I");
        require(campaigns[campaignId].owner == msg.sender, "O");
        _;
    }

    modifier onlyPostOwner(uint campaignId) {
        require(posts[msg.sender][campaignId].status != PostStatus.NOT_INITIALIZED, "I");
        require(posts[msg.sender][campaignId].owner == msg.sender, "O");
        _;
    }

    constructor() {
        _disableInitializers();
    }

    function initialize(address owner) public initializer {
        __Ownable_init(owner);
        __Pausable_init();
    }

    function initializeV2() public reinitializer(2) {
        __Pausable_init();
    }

    function getCampaignsPage(
        uint pageNumber,
        uint maxItemsPerPage
    ) external view returns (Campaign[] memory items, uint totalItems) {
        totalItems = totalCampaigns;

        uint skip = maxItemsPerPage * pageNumber;
        if (totalItems <= skip) {
            return (items, totalItems);
        }

        uint start = totalItems - skip - 1;
        uint finish = start < maxItemsPerPage ? 0 : start - maxItemsPerPage;
        uint count = start - finish + 1;
        items = new Campaign[](count);

        for (uint i = 0; i < count; i++) {
            items[i] = campaigns[start - i];
        }
    }

    function getCampaign(uint index) external view returns (Campaign memory) {
        return campaigns[index];
    }

    function setSchemaId(uint64 id) external onlyOwner {
        schemaId = id;
    }

    // function attest() external {
    //     Attestation memory sample = Attestation({
    //         schemaId: schemaId,
    //         linkedAttestationId: 0,
    //         attestTimestamp: 123,
    //         revokeTimestamp: 0,
    //         attester: address(this),
    //         validUntil: 0,
    //         dataLocation: DataLocation.ONCHAIN,
    //         revoked: false,
    //         recipients: new bytes[](0),
    //         data: ""
    //     });
    //     sp.attest(sample, "", "", "");
    // }

    function startCampaign(CampaignDescription calldata desc) external whenNotPaused returns (uint campaignId) {
        // TODO: review campaign

        if (address(desc.token) != address(0)) {
            require(desc.paymentSupply > 0, "P");
            desc.token.safeTransferFrom(msg.sender, address(this), desc.paymentSupply);
        }

        campaignId = totalCampaigns++;

        Campaign storage camp = campaigns[campaignId];
        camp.owner = msg.sender;
        camp.started = block.timestamp;
        camp.description = desc;
        camp.bookingSchedule.init(5);
    }

    function finishCampaign(uint id) external onlyCampaignOwner(id) {
        Campaign storage camp = campaigns[id];
        require(camp.owner == msg.sender, "O");
        require(camp.finished == 0, "F");
        camp.finished = block.timestamp;
    }

    function flushCampaign(uint id) external onlyCampaignOwner(id) whenNotPaused {
        Campaign storage camp = campaigns[id];
        require(camp.finished != 0, "F");

        uint freeSlots = camp.countFreeSlots();
        camp.forcefullyClosedSlots += freeSlots;

        uint withdrawableFunds = freeSlots * camp.description.paymentPerPost;
        camp.description.token.safeTransfer(camp.owner, withdrawableFunds);
    }

    function book(uint campaignId) external whenNotPaused {
        Campaign storage camp = campaigns[campaignId];
        require(camp.started > 0, "S");
        require(camp.finished == 0, "F");
        require(camp.countFreeSlots() > 0, "L");
        require(posts[msg.sender][campaignId].status == PostStatus.NOT_INITIALIZED, "B");

        BlogPost storage post = posts[msg.sender][campaignId];
        post.status = PostStatus.BOOKED;
        post.bookingExpires = camp.bookingSchedule.schedule();
        post.owner = msg.sender;
        post.socialId = 0;
        post.postId = totalPosts++;
    }

    function post(uint campaignId, string calldata postUrl) external whenNotPaused onlyPostOwner(campaignId) {
        BlogPost storage post = posts[msg.sender][campaignId];
        require(post.status == PostStatus.BOOKED, "B");
        require(block.timestamp < post.bookingExpires, "E");

        Campaign storage camp = campaigns[campaignId];
        camp.bookingSchedule.unschedule(post.bookingExpires);
        delete post.bookingExpires;
        camp.pipelinesInProgress++;
        
        post.status = PostStatus.READY_FOR_ATTESTATION;
        post.postUrl = postUrl;
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function postNotOK(address blogger, uint campaignId, string calldata reason) external onlyOwner {

    }

    function postOK(address blogger, uint campaignId, uint timestamp) external onlyOwner {
        // BlogPost storage post = posts[blogger][campaignId];
        //         Attestation memory sample = Attestation({
        //     schemaId: schemaId,
        //     linkedAttestationId: 0,
        //     attestTimestamp: 123,
        //     revokeTimestamp: 0,
        //     attester: address(this),
        //     validUntil: 0,
        //     dataLocation: DataLocation.ONCHAIN,
        //     revoked: false,
        //     recipients: new bytes[](0),
        //     data: ""
        // });
        // sp.attest(sample, "", "", "");
    }

    function claim(uint campaignId) external onlyPostOwner(campaignId) {
        //
    }

    function didReceiveAttestation(
        address attester,
        uint64 schemaId,
        uint64 attestationId,
        bytes calldata extraData
    ) external payable {
        emit HookCalled(msg.sender, attester, schemaId, attestationId);
    }

    function didReceiveAttestation(
        address attester,
        uint64 schemaId,
        uint64 attestationId,
        IERC20 resolverFeeERC20Token,
        uint256 resolverFeeERC20Amount,
        bytes calldata extraData
    ) external {
        emit HookCalled(msg.sender, attester, schemaId, attestationId);
    }

    function didReceiveRevocation(
        address attester,
        uint64 schemaId,
        uint64 attestationId,
        bytes calldata extraData
    ) external payable {
        emit HookCalled(msg.sender, attester, schemaId, attestationId);
    }

    function didReceiveRevocation(
        address attester,
        uint64 schemaId,
        uint64 attestationId,
        IERC20 resolverFeeERC20Token,
        uint256 resolverFeeERC20Amount,
        bytes calldata extraData
    ) external {
        emit HookCalled(msg.sender, attester, schemaId, attestationId);
    }
}
