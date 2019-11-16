import React from 'react';
import {Link} from 'react-router-dom';
import axios from 'axios';

import Navbar from '../Navbar/Navbar';

import './styles.css';

export default class AlbumInfo extends React.Component {
    state = {
        albumData: []
    }

    componentDidMount() {
        const link = this.props.match.params.album;
        axios.get('http://localhost:5000/showalbuminfo/'+link)
            .then(res => {
                this.setState({albumData: res.data});
        })
    }

    render() {
        return (
            <div className="album-info">
                <Navbar/>
                <Link to = '/albums'>
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
                <hr className="line"/>
            </div>
        )
    }
}