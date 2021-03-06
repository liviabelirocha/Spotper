import React from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';

import Navbar from '../Navbar/Navbar';

import { ReactComponent as AlbumIcon } from '../../assets/album.svg';

import './styles.css';

export default class ShowAlbums extends React.Component {
    state = {
        albums: [],
        link: this.props.match.params.playlist
    }

    componentDidMount() {
        axios.get('http://localhost:5000/showalbums')
            .then(res => {
                this.setState({ albums: res.data })
            })
    }

    render() {
        const albumNames = this.state.albums.map(item => {
            return (
                <Link to={`/albuminfo/${this.state.link}/${item.cod_album}`}>
                    <button className="show-button">
                        <div className="show-content">
                            <AlbumIcon className="album-icon" />
                            <p>{item.descricao}</p>
                        </div>
                    </button>
                </Link>)
        });

        return (
            <div className="albums">
                <Navbar />
                <Link to={'/playlistinfo/' + this.state.link}>
                    <button className="goBack">Voltar</button>
                </Link>
                <center className="available">Álbuns Disponíveis</center>
                <div className="albums-rol">{albumNames}</div>
            </div>
        )
    }
}