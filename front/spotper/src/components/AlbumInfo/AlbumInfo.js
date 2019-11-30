import React from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';

import Navbar from '../Navbar/Navbar';

import './styles.css';

import { ReactComponent as Plus } from '../../assets/plus.svg';

export default class AlbumInfo extends React.Component {
    state = {
        albumData: [],
        musics: [],
        link: this.props.match.params.album,
        pl: this.props.match.params.playlist,
    }

    componentDidMount() {
        axios.get('http://localhost:5000/showalbuminfo/' + this.state.link)
            .then(res => {
                this.setState({ albumData: res.data });
                axios.get('http://localhost:5000/showmusicsalbum/' + this.state.link)
                    .then(res => {
                        this.setState({ musics: res.data });
                    });
            });
    }

    commitSong = (e) => {
        let data = {
            'faixa': e,
            'playlist': this.state.pl
        }
        console.log(data)
        /*
        axios.post('http://localhost:5000/addtoplaylist', data)
            .then(res => {
                console.log(res);
            }).catch(err => {
                console.log(err);
            })*/

    }

    render() {
        const musics = this.state.musics.map((item) => {
            return (
                <tr key={item.num_faixa}>
                    <td>
                        <button className="add-music-button" onClick={this.commitSong(item.cod_faixa)}>
                            <Plus className="add-music-icon" />
                        </button>
                    </td>
                    <td className="song-info">{item.num_faixa}</td>
                    <td className="song-info">{item.descricao}</td>
                    <td className="song-info">{item.compositor}</td>
                    <td className="song-info">{item.tempo_execucao}</td>
                    <td className="song-info">{item.interprete}</td>
                    <td className="song-info">{item.tipo_composicao}</td>
                    <td className="song-info">{item.tipo_gravacao}</td>
                </tr>
            )
        })

        return (
            <div className="album-info">
                <Navbar />
                <Link to={'/albums/' + this.state.pl}>
                    <button className="goBack">Voltar</button>
                </Link>

                <div className="main-album-info">
                    <h1>
                        {this.state.albumData.nome_album}&nbsp;
                        (cod_{this.state.albumData.cod_album})
                    </h1>
                    <h3>
                        R$ {this.state.albumData.preco_de_compra} -
                        &nbsp;{this.state.albumData.tipo_de_compra} -
                        &nbsp;{this.state.albumData.data_de_compra}
                        <br></br>
                        {this.state.albumData.nome_gravadora} -
                        &nbsp;{this.state.albumData.data_de_gravacao}
                    </h3>
                </div>
                <table>
                    <tr>
                        <th className="song-head">add</th>
                        <th className="song-head">nº</th>
                        <th className="song-head song-name">nome</th>
                        <th className="song-head">compositor(es)</th>
                        <th className="song-head">tempo</th>
                        <th className="song-head">intérprete</th>
                        <th className="song-head">tipo de composição</th>
                        <th className="song-head">tipo de gravação</th>
                    </tr>
                    <tbody>{musics}</tbody>
                </table>
            </div>
        )
    }
}