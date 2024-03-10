import ReactDOM from "react-dom/client";
import React, { useEffect, useState } from "react";
import {
  BrowserRouter,
  Routes,
  Route,
  Link,
  useParams,
  useLocation,
  useNavigate,
} from "react-router-dom";

const App = () => {
    return (
      <BrowserRouter>
        <div>
          {/* Routes Setup */}
          <Routes>
            <Route path="/" element={<HelloWorld />} />
          </Routes>
        </div>
      </BrowserRouter>
    );
};

const HelloWorld = () => {
    return <div>Hello World</div>;
};


const root = ReactDOM.createRoot(document.querySelector("#app"));
root.render(<App />);
