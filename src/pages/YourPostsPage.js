import { useParams } from "react-router-dom"
import CampView from "../components/CampView"
import * as api from "../api"
import useAsyncRequest from "../hooks/useAsyncRequest"
import MultiLoader from "../components/MultiLoader"


export default function () {
  const { id } = useParams()
  const profileLoader = useAsyncRequest(api.getProfile)

  return (
    <div>
      <h2>Your posts</h2>
      <div>
        <div>
          <div>Blogger</div>
          <div>Status</div>
        </div>
        <div>
          <div>
            <div>0x...</div>
            <div>CHECKING</div>
          </div>
          <div>
            <div>0x...</div>
            <div>CHECKING</div>
          </div>
          <div>
            <div>0x...</div>
            <div>CLAIMED</div>
          </div>
        </div>
      </div>
    </div>
  )
}