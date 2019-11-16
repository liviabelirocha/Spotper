import React from 'react';
import {Link} from 'react-router-dom';
import axios from 'axios';

import Navbar from '../Navbar/Navbar';

import {ReactComponent as PlaylistIcon} from '../../assets/album.svg';

import './styles.css';

export default class ShowPlaylists extends React.Component {
    state = {
        playlists: []
    }

    componentDidMount() {
        axios.get('http://localhost:5000/showplaylists')
            .then(res => {
               this.setState({playlists : res.data})
        })
    }

    render() {
        const playlistNames = this.state.playlists.map(item => {
            return (
                <Link to={`/playlistinfo/${item}`}>
                    <button className="show-button-playlists">
                        <div className="show-content">
                            <PlaylistIcon className="playlist-icon"/>
                            <p>{item}</p>
                        </div>
                    </button>
                </Link>
            )
        });
        
        return (
            <div className="playlists">
                <Navbar/>
                <Link to = '/'>
                    <button className="goBack">Voltar</button>
                </Link>
                <center className="available">Playlists Disponíveis</center>
                <div className="playlists-rol">{playlistNames}</div>
            </div>
        )
    }
}