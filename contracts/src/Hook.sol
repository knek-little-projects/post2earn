import "lib/sign-protocol-evm/src/interfaces/ISPHook.sol";
import "lib/sign-protocol-evm/src/interfaces/ISP.sol";
import "lib/sign-protocol-evm/src/models/DataLocation.sol";

contract Hook is ISPHook {
    event HookCalled(address sender, address attester, uint64 schemaId, uint64 attestationId);

    ISP immutable public sp = ISP(0x2b3224D080452276a76690341e5Cfa81A945a985);
    uint64 public schemaId;

    
    constructor(uint64 _schemaId) {
        schemaId = _schemaId;
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
