import React from 'react'
import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom'

import "./App.scss"

import Layout from './Layout'
import NotFoundPage from './pages/NotFoundPage'
import AllCampsPage from './pages/AllCampsPage'
import YourCampsPage from './pages/YourCampsPage'
import YourPostsPage from './pages/YourPostsPage'
import CampPage from './pages/CampPage'

export default function App() {
  return (
    <BrowserRouter basename={process.env.PUBLIC_URL}>
      <Layout>
        <Routes>
          <Route path="/" element={<Navigate to="/campaigns/" />} />
          <Route path="/campaigns" element={<Navigate to="/campaigns/" />} />
          <Route path="/campaigns/" element={<AllCampsPage />} />
          <Route path="/campaigns/:id" element={<CampPage />} />
          <Route path="/posts/:id" element={<YourPostsPage />} />
          <Route path="*" element={<NotFoundPage />} />
        </Routes>
      </Layout>
    </BrowserRouter>
  )
}