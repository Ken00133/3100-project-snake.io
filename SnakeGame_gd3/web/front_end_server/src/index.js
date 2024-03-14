// front_end_server/src/index.js
import ReactDOM from "react-dom/client";
import React from "react";
import {
  BrowserRouter,
  Routes,
  Route,
} from "react-router-dom";

const App = () => {
  return (
    <BrowserRouter>
      <div>
        {/* Routes Setup */}
        <Routes>
          {/*<Route path="/" element={<HelloWorld />} />*/}
          <Route path="/" element={<GameIframe />} />
        </Routes>
      </div>
    </BrowserRouter>
  );
};

const HelloWorld = () => {
  return <div>Hello World</div>;
};

const GameIframe = () => {
  return (
    //<iframe src="https://www.youtube.com/embed/uXWycyeTeCs" width={1000} height={500} title='A youtube video on React hooks'></iframe>
    <iframe src={`${process.env.PUBLIC_URL}/mygame/Snake Game Gd 3.html`} style={{width: '100%', height: '100vh', border: 'none'}} title="Game"></iframe>
  );
};

const root = ReactDOM.createRoot(document.querySelector("#app"));
root.render(<App />);
