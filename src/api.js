import CAMPAIGNS from "./data/sample/campaigns.json"
import PROFILE from "./data/sample/profile.json"

const API_BASE_URL = process.env.REACT_APP_BACK_URL || "http://localhost:8000"

async function get(path) {
  const response = await fetch(API_BASE_URL + path, {
    method: 'GET',
    headers: {
      'X-USER-ID': window.localStorage.getItem('X-USER-ID'),
    }
  })

  const result = await response.json()
  console.debug("GET", path, result)
  return result
}

async function post(path, data) {
  const response = await fetch(API_BASE_URL + path, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-USER-ID': window.localStorage.getItem('X-USER-ID'),
    },
    body: JSON.stringify(data),
  })

  const result = await response.json()
  console.debug("POST", path, data, result)
  return result
}

export async function getCampaigns() {
  return CAMPAIGNS
}

export function getCampaign(id) {
  return CAMPAIGNS.find(c => c.id == /** approx */ id)
}

export function getProfile() {
  return PROFILE
}