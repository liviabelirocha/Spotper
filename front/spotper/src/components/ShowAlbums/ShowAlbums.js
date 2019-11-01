import React from 'react';
import {Link} from 'react-router-dom';
import axios from 'axios';

import Navbar from '../Navbar/Navbar';

import './styles.css';

export default class ShowAlbums extends React.Component {
    render() {
        return (
            <div className="albums">
                <Navbar/>
                <Link to = '/create'>
                    <button className="goBack">Voltar</button>
                </Link>
                <center className="available">Álbuns Disponíveis</center>
                <Link to = '/'>
                    <button className="continue">Continuar</button>
                </Link>
            </div>
        )
    }
}