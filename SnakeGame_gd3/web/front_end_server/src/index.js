// front_end_server/src/index.js
import ReactDOM from "react-dom/client";
import React from "react";
import {
  BrowserRouter,
  Routes,
  Route,
  useNavigate,
} from "react-router-dom";
import { LoginControl, Login, Register } from "./components/auth.js";

class App extends React.Component {
  render() {
    return (
      <BrowserRouter>
        <div>
          <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
              <a class="navbar-brand" href="/">Snake.io</a>
              <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                  <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/members">Group Members</a>
                  </li>
                </ul>
                <ul class="navbar-nav ml-auto mb-2 mb-lg-0">
                  { isLoggedIn.state.isLoggedIn?
                    <button type="button" class="btn btn-primary mx-2"><a href="/login" style={{textDecoration: 'none', color: 'white'}}> Logout </a></button>
                  :<div>
                    <button type="button" class="btn btn-outline-primary mx-2"><a href="/register" style={{textDecoration: 'none', color: 'white'}}> Register </a></button>
                    <button type="button" class="btn btn-primary mx-2"><a href="/login" style={{textDecoration: 'none', color: 'white'}}> Login </a></button>
                  </div>
                  }
                </ul>
              </div>
            </div>
          </nav>
          {/* Routes Setup */}
          <Routes>
            {/*<Route path="/" element={<HelloWorld />} />*/}
            <Route path="/" element={<Home />} />
            <Route path="/members" element={<Members />} />
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
  const navigate = useNavigate();
  return (
    <div align="center">
      <br/><br/>
      <img src="game_icon.png" style={{width: '300px', height: '300px', border: 'none'}}></img>
      <br/>
      <h1 style={{color: 'white'}}><b>Snake.io</b></h1>
      <br/>
      <h5 style={{color: 'white'}}>An Exciting Browser-Based Mini-Game</h5>
      <br/>
      { isLoggedIn.state.isLoggedIn?
      <button type="button" class="btn btn-success btn-lg" onClick={() => navigate("/game")}>Play</button>
      :<button type="button" class="btn btn-success btn-lg" onClick={() => navigate("/game")}>Play (without login)</button>
      }
    </div>
  );
}

const Members = () => {
  return (
    <div align="center">
      <br/><br/>
      <h1 style={{color: 'white'}}>2023/24 CSCI3100 Project</h1>
      <br/>
      <h3 style={{color: 'white'}}><b>Group E2</b></h3>
      <br/>
      <h5 style={{color: 'white'}}>1155142430 Wong Tsz Kin</h5>
      <h5 style={{color: 'white'}}>1155143354 Lau Hiu Wang</h5>
      <h5 style={{color: 'white'}}>1155176920 Chow Man Fung</h5>
      <h5 style={{color: 'white'}}>1155159055 Chong Hok Kan</h5>
      <h5 style={{color: 'white'}}>1155159054 Wong Man Nam</h5>
    </div>
  );
}

const GameIframe = () => {
  return (
    <div style={{width: '100vw', height: '100vh', overflow: 'hidden', display: 'flex', justifyContent: 'center', alignItems: 'center'}}>
      <iframe
        src={`${process.env.PUBLIC_URL}/mygame/Snake Game Gd 3.html`}
        style={{width: '100vw', height: '100vh', border: 'none'}}
        title="Game">
      </iframe>
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

let isLoggedIn = new LoginControl();
const root = ReactDOM.createRoot(document.querySelector("#app"));
root.render(<App />);
