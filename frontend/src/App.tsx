import { BrowserRouter, Routes, Route } from 'react-router-dom'

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<div className="container-page py-20 text-center"><h1 className="text-4xl font-display font-bold text-primary">SHOP WITH gAI</h1><p className="mt-4 font-body text-muted-foreground">Coming soon</p></div>} />
      </Routes>
    </BrowserRouter>
  )
}

export default App
