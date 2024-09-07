import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "lib/sign-protocol-evm/src/interfaces/ISPHook.sol";
import "lib/sign-protocol-evm/src/interfaces/ISP.sol";
import "lib/sign-protocol-evm/src/models/DataLocation.sol";

import "lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";

import "./Campaign.sol";

contract Hook is ISPHook, OwnableUpgradeable {
    using SafeERC20 for IERC20;

    event HookCalled(address sender, address attester, uint64 schemaId, uint64 attestationId);

    ISP public immutable sp = ISP(0x2b3224D080452276a76690341e5Cfa81A945a985);
    uint64 public schemaId;

    mapping(uint => Campaign) campaigns;
    uint public totalCampaigns;

    constructor() {
        _disableInitializers();
    }

    function initialize(address owner) public initializer {
        __Ownable_init(owner);
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

    function attest() external {
        Attestation memory sample = Attestation({
            schemaId: schemaId,
            linkedAttestationId: 0,
            attestTimestamp: 123,
            revokeTimestamp: 0,
            attester: address(this),
            validUntil: 0,
            dataLocation: DataLocation.ONCHAIN,
            revoked: false,
            recipients: new bytes[](0),
            data: ""
        });
        sp.attest(sample, "", "", "");
    }

    function startCampaign(CampaignDescription calldata desc) external returns (uint campaignId) {
        if (address(desc.token) != address(0)) {
            require(desc.paymentSupply > 0, "P");
            desc.token.safeTransferFrom(msg.sender, address(this), desc.paymentSupply);
        }

        campaignId = totalCampaigns++;

        Campaign storage camp = campaigns[campaignId];
        camp.owner = msg.sender;
        camp.started = block.timestamp;
        camp.description = desc;
    }

    function finishCampaign(uint id) external {
        Campaign storage camp = campaigns[id];
        require(camp.owner == msg.sender, "O");
        require(camp.finished == 0, "F");
        camp.finished = block.timestamp;
        _flushCampaign(camp);
    }

    function flushCampaign(uint id) external {
        Campaign storage camp = campaigns[id];
        require(camp.owner == msg.sender, "O");
        _flushCampaign(camp);
    }

    function _flushCampaign(Campaign storage camp) internal {
        uint unavailable = (camp.postsInProgress + camp.postsSuccess) *
            camp.description.paymentPerPost;
        if (camp.description.paymentSupply <= unavailable) {
            return;
        }
        uint availableFunds = camp.description.paymentSupply - unavailable;
        camp.description.token.safeTransfer(camp.owner, availableFunds);
        camp.description.paymentSupply -= availableFunds;
    }

    // book(id)
    // post(link) postId
    // verify(postId)
    // fail(postId, reason)
    // success(postId)
    // claim(postId)

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
