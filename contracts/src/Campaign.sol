import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

struct CampaignDescription {
    string title;
    string text;
    string link;
    string tag;
    uint bloggerMinFollowers;
    uint postTTL;
    IERC20 token;
    uint paymentPerPost;
    uint maxPosts;
    uint paymentSupply;
}

struct Campaign {
    address owner;
    uint started;
    uint finished;
    uint postsInProgress;
    uint postsSuccess;
    CampaignDescription description;
}

struct BlogPost {
    // ...
}
