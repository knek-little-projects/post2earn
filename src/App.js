import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'
import React from 'react'

import "./App.scss"

import Layout from './Layout'
import NotFoundPage from './pages/NotFoundPage'

export default function App() {
  return (
    <BrowserRouter basename={process.env.PUBLIC_URL}>
      <Layout>
        <Routes>
          <Route path="*" element={<NotFoundPage />} />
        </Routes>
      </Layout>
    </BrowserRouter>
  )
}