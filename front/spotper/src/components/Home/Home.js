import React from "react";
import {Link} from 'react-router-dom';

import Navbar from '../Navbar/Navbar';

import './styles.css';
import {ReactComponent as Plus} from '../../assets/plus.svg';
import {ReactComponent as Edit} from '../../assets/edit.svg';

const Home = () => {
    return(
        <div className="background">
            <Navbar/>
            <Link to ="/create">
                <button className="button1 homeButton">
                    <div className="content">
                        <Plus className="icon"/>
                        <p>Criar nova playlist</p>
                    </div>
                </button>
            </Link>
            <Link to="/">
                <button className="homeButton">
                    <div className="content">
                        <Edit className="icon"/>
                        <p>Editar playlist existente</p>
                    </div>
                </button>
            </Link>
        </div>
    )
}

export default Home;