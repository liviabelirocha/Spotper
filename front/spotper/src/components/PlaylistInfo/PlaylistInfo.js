import React from 'react';
import {Link} from 'react-router-dom';
import axios from 'axios';

import Navbar from '../Navbar/Navbar';

import './styles.css';

export default class AlbumInfo extends React.Component {
    state = {
        playlistData: []
    }

    componentDidMount() {
        const link = this.props.match.params.playlist;
        axios.get('http://localhost:5000/showplaylistinfo/'+link)
            .then(res => {
                this.setState({playlistData: res.data});
        })
    }

    render() {
        return (
            <div className="playlist-info">
                <Navbar/>
                <Link to = '/playlists'>
                    <button className="goBack">Voltar</button>
                </Link>
                
                <div className="main-playlist-info">
                    <h1>
                        {this.state.playlistData.nome}&nbsp;
                        (cod_{this.state.playlistData.cod_playlist})
                    </h1>
                    <h3>
                        Tempo de execução: &nbsp;
                        {this.state.playlistData.tempo_exec} s
                        <br></br>
                        Criada em: &nbsp;
                        {this.state.playlistData.data_criacao}
                    </h3>
                </div>
                <hr className="line"/>
            </div>
        )
    }
}