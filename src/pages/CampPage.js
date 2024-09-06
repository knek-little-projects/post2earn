import { useParams } from "react-router-dom"
import CampView from "../components/CampView"
import * as api from "../api"
import useAsyncRequest from "../hooks/useAsyncRequest"
import MultiLoader from "../components/MultiLoader"

const STATUS_EMPTY = 0
const STATUS_BOOKED = 1
const STATUS_SUBMITTED = 2
const STATUS_FAILED = 3
const STATUS_FIRST_SUCCEED = 4
const STATUS_FINAL_SUCCEED = 5


export default function () {
  const { id } = useParams()
  const profileLoader = useAsyncRequest(api.getProfile)
  const campLoader = useAsyncRequest(() => api.getCampaign(id))

  const camp = campLoader.data
  const profile = profileLoader.data

  return (
    <MultiLoader loaders={[profileLoader, campLoader]}>
      {
        camp
        &&
        profile
        &&
        <>
          <h1>
            {camp.title}
          </h1>
          <div>
            <h2>Campaign controls</h2>
            <button>STOP CAMPAIGN</button>
            <button>Withdraw available funds</button>
          </div>
          <div>
            <div>
              <h2>Want to earn?</h2>
              <button>POST TO EARN</button>
            </div>
            <div>
              <h2>Post status</h2>
              <div>You've booked a slot and have 10 minutes to make the post</div>
              <div>
                What to post
              </div>
              <button>I'VE POSTED!</button>
            </div>
            <div>
              <h2>Post status</h2>
              <div>
                Your post is on verification. It may take an hour. Thank you for your patience!
              </div>
            </div>
            <div>
              <h2>Post status</h2>
              <div>
                Verification failed!
                Reason: ...
              </div>
            </div>
            <div>
              <div>
                <h2>Post status</h2>
                <div>
                  Post was verified on XX/XX/XX XX:XX
                </div>
              </div>
              <div>
                DO NOT delete and DO NOT modify your post for the next 24 hours. We'll be checking on it time to time.
              </div>
            </div>
            <div>
              <h2>Post status</h2>
              <div>
                Post was verified on XX/XX/XX XX:XX
              </div>
              <div>
                Post check failed on XX/XX/XX XX:XX
              </div>
              <div>
                Reason: the post was modified | we couldn't open the post
              </div>
            </div>
            <div>
              <h2>
                Post status
              </h2>
              <div>
                Post was verified on XX/XX/XX XX:XX
              </div>
              <div>
                Post last check was on XX/XX/XX XX:XX
              </div>
              <div>
                You've earned XXX TKN!
              </div>
              <div>
                <button>CLAIM</button>
              </div>
            </div>
          </div>


          <h2>Full Details</h2>
          <CampView item={camp} />
        </>
      }
    </MultiLoader>
  )
}