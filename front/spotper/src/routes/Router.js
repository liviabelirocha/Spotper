import React from 'react';

//router
import { BrowserRouter, Switch, Route } from 'react-router-dom';

//components
import Navbar from '../components/Navbar/Navbar';
import Home from '../components/Home/Home';
import CreatePlaylist from '../components/CreatePlaylist/CreatePlaylist';
import ShowAlbums from '../components/ShowAlbums/ShowAlbums';

const Router = () => (
    <BrowserRouter>
        <Switch>
            <Route path="/" exact={true} component={Home}/>
            <Route path="/create" component={CreatePlaylist}/>
            <Route path="/albums" component={ShowAlbums}/>
        </Switch>
    </BrowserRouter>
  );
  
  export default Router;