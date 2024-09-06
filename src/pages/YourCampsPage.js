import CampTable from "../components/CampTable";
import Loader from "../components/Loader";
import useAsyncRequest from "../hooks/useAsyncRequest";
import * as api from "../api"

export default function () {

  const loader = useAsyncRequest(api.getCampaigns)

  return (
    <Loader {...loader}>
      <CampTable data={loader.data || []} />
    </Loader>
  )
}