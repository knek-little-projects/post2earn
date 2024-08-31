import "lib/sign-protocol-evm/src/interfaces/ISPHook.sol";
import "lib/sign-protocol-evm/src/interfaces/ISP.sol";

contract TestISP is ISPHook {
    event HookReceived(string);
    ISP immutable isp;
    
    constructor() {
        isp = ISP(0x2b3224D080452276a76690341e5Cfa81A945a985);
    }

    function attest() external {
    // function attest(
    //     Attestation calldata attestation,
    //     string calldata indexingKey,
    //     bytes calldata delegateSignature,
    //     bytes calldata extraData
    // )
    //     external
    //     returns (uint64 attestationId);

    }

    function didReceiveAttestation(
        address attester,
        uint64 schemaId,
        uint64 attestationId,
        bytes calldata extraData
    ) external payable {
        emit HookReceived("didReceiveAttestation");
    }

    function didReceiveAttestation(
        address attester,
        uint64 schemaId,
        uint64 attestationId,
        IERC20 resolverFeeERC20Token,
        uint256 resolverFeeERC20Amount,
        bytes calldata extraData
    ) external {
        emit HookReceived("didReceiveAttestation");
    }

    function didReceiveRevocation(
        address attester,
        uint64 schemaId,
        uint64 attestationId,
        bytes calldata extraData
    ) external payable {
        emit HookReceived("didReceiveRevocation");
    }

    function didReceiveRevocation(
        address attester,
        uint64 schemaId,
        uint64 attestationId,
        IERC20 resolverFeeERC20Token,
        uint256 resolverFeeERC20Amount,
        bytes calldata extraData
    ) external {
        emit HookReceived("didReceiveRevocation");
    }
}
