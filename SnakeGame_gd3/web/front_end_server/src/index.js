// front_end_server/src/index.js
import ReactDOM from "react-dom/client";
import React from "react";
import {
  BrowserRouter,
  Routes,
  Route,
} from "react-router-dom";
import { Login, Register } from "./components/auth";

class App extends React.Component {
  render() {
    return (
      <BrowserRouter>
        <div>
          <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
              <a class="navbar-brand" href="#">Snake.io</a>
              <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                  <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/">Home</a>
                  </li>
                </ul>
              </div>
            </div>
          </nav>
          {/* Routes Setup */}
          <Routes>
            {/*<Route path="/" element={<HelloWorld />} />*/}
            <Route path="/" element={<Home />} />
            <Route path="/login" element={<Login />} />
            <Route path="/register" element={<Register />} />
            {/* <Route element={<PrivateRoute />}> */}
              <Route path="/game" element={<GameIframe />} />
            {/* </Route> */}
            <Route path="*" element={<NoMatch />} />
          </Routes>
        </div>
      </BrowserRouter>
    );
  }
};

const Home = () => {
  return (
    <div align="center">
      <br/><br/>
      <img src="game_icon.png" style={{width: '300px', height: '300px', border: 'none'}}></img>
      <br/>
      <h1 style={{color: 'white'}}><b>Snake.io</b></h1>
      <br/>
      <h5 style={{color: 'white'}}>An Exciting Browser-Based Mini-Game</h5>
      <br/>
      <button type="button" class="btn btn-success btn-lg"><a href="/login" style={{textDecoration: 'none', color: 'white'}}> Login </a></button>
      <br/><br/>
      <button type="button" class="btn btn-outline-success btn-sm"><a href="/register" style={{textDecoration: 'none', color: 'white'}}> Register </a></button>
    </div>
  );
}

const GameIframe = () => {
  return (
    <div className="Game">
      <iframe src={`${process.env.PUBLIC_URL}/mygame/Snake Game Gd 3.html`} style={{width: '100%', height: '85vh', border: 'none'}} title="Game"></iframe>
    </div>
  );
};

const NoMatch = () => {
  return (
    <div>
      <h2>The page you are looking for does not exist!</h2>
      <a href="/">Back to Home</a>
    </div>
  );
}

const root = ReactDOM.createRoot(document.querySelector("#app"));
root.render(<App />);
