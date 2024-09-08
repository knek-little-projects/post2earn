import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

struct BookingSchedule {
    uint startTime;
    uint startIndex;
    uint maxMinutes;
    uint[] counts;
}

library BookingLib {
    function init(BookingSchedule storage a, uint maxMinutes) internal {
        a.maxMinutes = maxMinutes;
        a.counts = new uint[](maxMinutes);
    }

    function countActive(BookingSchedule storage a) internal view returns (uint) {
        uint elapsedMinutes = (block.timestamp - a.startTime) / 1 minutes;

        if (elapsedMinutes < a.maxMinutes) {
            uint s = 0;
            for (uint i = elapsedMinutes; i < a.maxMinutes; i++) {
                s += a.counts[(i + a.startIndex) % a.maxMinutes];
            }
            return s;
        }

        return 0;
    }

    function schedule(BookingSchedule storage a) internal returns (uint expires) {
        uint elapsedMinutes = (block.timestamp - a.startTime) / 1 minutes;

        if (elapsedMinutes < a.maxMinutes) {
            for (uint i = 0; i < elapsedMinutes; i++) {
                a.counts[(i + a.startIndex) % a.maxMinutes] = 0;
            }
            a.startTime += elapsedMinutes * 1 minutes;
            a.startIndex = (a.startIndex + elapsedMinutes) % a.maxMinutes;
            a.counts[(a.startIndex + a.maxMinutes - 1) % a.maxMinutes]++;
        } else {
            a.startIndex = 0;
            a.startTime = block.timestamp;
            for (uint i = 0; i < a.maxMinutes; i++) {
                a.counts[i] = 0;
            }
        }

        expires = a.startTime + a.maxMinutes * 1 minutes;
    }

    function unschedule(BookingSchedule storage a, uint timestamp) internal {
        // TODO: check the edge case
        if (timestamp <= block.timestamp) {
            return;
        }

        uint elapsed = timestamp - a.startTime;
        a.counts[(a.startIndex + elapsed) % a.maxMinutes]--;
    }
}

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
    // TODO: blogger cooloff period
    // TODO: blogger net intersection
}

struct Campaign {
    address owner;
    uint started;
    uint finished;
    uint forcefullyClosedSlots;
    uint pipelinesFinished;
    uint pipelinesInProgress;
    BookingSchedule bookingSchedule;
    CampaignDescription description;
}

library CampaignLib {
    function countUsedSlots(Campaign storage camp) internal view returns (uint) {
        return
            camp.forcefullyClosedSlots +
            camp.pipelinesInProgress +
            camp.pipelinesFinished +
            BookingLib.countActive(camp.bookingSchedule);
    }

    function countFreeSlots(Campaign storage camp) internal view returns (uint) {
        return
            camp.description.maxPosts -
            camp.pipelinesInProgress -
            camp.forcefullyClosedSlots -
            camp.pipelinesFinished -
            BookingLib.countActive(camp.bookingSchedule);
    }
}

enum PostStatus {
    NOT_INITIALIZED,
    BOOKED,
    READY_FOR_ATTESTATION,
    FIRST_CHECK_PASSED,
    LAST_CHECK_PASSED,
    CLAIMED,
    FAILED
}

struct BlogPost {
    PostStatus status;
    uint bookingExpires;
    address owner;
    uint socialId;
    uint postId;
    uint campaignId;
    string postUrl;
    uint firstSeen;
    uint lastSeen;
}
