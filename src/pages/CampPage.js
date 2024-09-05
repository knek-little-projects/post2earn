import { useParams } from "react-router-dom"
import CampView from "../components/CampView"
import * as api from "../api"
import useAsyncRequest from "../hooks/useAsyncRequest"
import MultiLoader from "../components/MultiLoader"

export default function () {
  const { id } = useParams()
  const profileLoader = useAsyncRequest(api.getProfile)
  const campLoader = useAsyncRequest(() => api.getCampaign(id))

  const camp = campLoader.data
  const profile = profileLoader.data

  const isOwner = profile?.address === camp?.owner

  return (
    <MultiLoader loaders={[profileLoader, campLoader]}>
      <CampView item={camp} isOwner={isOwner} />
    </MultiLoader>
  )
}