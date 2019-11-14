import React from 'react';
import {Link} from 'react-router-dom';
import axios from 'axios';

import Navbar from '../Navbar/Navbar';

import {ReactComponent as AlbumIcon} from '../../assets/album.svg';

import './styles.css';

export default class ShowAlbums extends React.Component {
    state = {
        albums: []
    }

    componentDidMount() {
        axios.get('http://localhost:5000/showalbums')
            .then(res => {
               this.setState({albums : res.data})
        })
    }

    render() {
        const albumNames = this.state.albums.map(item => 
            <button className="show-button">
                <div className="show-content">
                    <AlbumIcon className="album-icon"/>
                    <p>{item}</p>
                </div>
            </button>
        );
        
        return (
            <div className="albums">
                <Navbar/>
                <Link to = '/create'>
                    <button className="goBack">Voltar</button>
                </Link>
                <center className="available">Álbuns Disponíveis</center>
                <div className="albums-rol">{albumNames}</div>
                <Link to = '/'>
                    <button className="continue-album">Continuar</button>
                </Link>
            </div>
        )
    }
}