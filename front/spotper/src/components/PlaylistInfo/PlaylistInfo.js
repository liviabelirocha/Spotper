import React from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';

import Navbar from '../Navbar/Navbar';

import './styles.css';

export default class AlbumInfo extends React.Component {
    state = {
        playlistData: [],
        musics: [],
        duration: '',
        link: this.props.match.params.playlist
    }

    componentDidMount() {
        axios.get('http://localhost:5000/showplaylistinfo/' + this.state.link)
            .then(res => {
                this.setState({ playlistData: res.data });
                axios.get('http://localhost:5000/playlistduration/' + this.state.link)
                    .then(res => {
                        this.setState({ duration: res.data });
                        axios.get('http://localhost:5000/showmusicsplaylist/' + this.state.link)
                            .then(res => {
                                this.setState({ musics: res.data });
                            })
                    })
            })
    }

    removeSong = (e) => {
        let data = {
            'faixa': e,
            'playlist': parseInt(this.state.link)
        };
        axios.post('http://localhost:5000/removefromplaylist', data, {
            headers: { 'Access-Control-Allow-Origin': '*' },
        }).then(res => {
            console.log(res);
            alert("Música removida com sucesso!")
            window.location.reload();
        }).catch(err => {
            console.log(err);
            alert("Música já se encontra na playlist!")
        })
    }

    render() {
        const musics = this.state.musics.map((item) => {
            return (
                <tr key={item.num_faixa}>
                    <td>
                        <button className="remove-music-button" onClick={() => this.removeSong(item.cod_faixa)}> - </button>
                    </td>
                    <td className="song-info">{item.descricao}</td>
                    <td className="song-info">{item.album}</td>
                    <td className="song-info">{item.tempo_execucao}</td>
                </tr>
            )
        })

        return (
            <div className="playlist-info">
                <Navbar />
                <Link to='/playlists'>
                    <button className="goBack">Voltar</button>
                </Link>
                <Link to={'/albums/' + this.state.link}>
                    <button className="addSongs">Adicionar Músicas</button>
                </Link>

                <div className="main-playlist-info">
                    <h1>
                        {this.state.playlistData.nome}&nbsp;
                        (cod_{this.state.playlistData.cod_playlist})
                    </h1>
                    <h3>
                        Tempo de duração: &nbsp;
                        {this.state.duration} s
                        <br></br>
                        Criada em: &nbsp;
                        {this.state.playlistData.data_criacao}
                    </h3>
                </div>
                <table>
                    <tr>
                        <th className="song-head">remove</th>
                        <th className="song-head song-name">nome</th>
                        <th className="song-head">album</th>
                        <th className="song-head">duração</th>
                    </tr>
                    <tbody>{musics}</tbody>
                </table>
            </div >
        )
    }
}