import React from 'react';

//router
import { BrowserRouter, Switch, Route } from 'react-router-dom';

//components
import Navbar from '../components/Navbar/Navbar';
import Home from '../components/Home/Home';
import NotFound from '../components/NotFound/NotFound';

const Router = () => (
    <BrowserRouter>
        <Navbar/>
        <Switch>
            <Route path="/" exact={true} component={Home}/>
            <Route path='*' component={NotFound} />
        </Switch>
    </BrowserRouter>
  );
  
  export default Router;