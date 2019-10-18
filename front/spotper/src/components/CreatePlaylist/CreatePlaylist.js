import React from 'react';
import {Link} from 'react-router-dom';
import axios from 'axios';

import Navbar from '../Navbar/Navbar';

import './styles.css';

export default class CreatePlaylist extends React.Component {
    handleClick = () => {
        //REQUISIÇÃO HTPP P/ INSERIR NOVA PLAYLIST
        
    }

    render() {
        return (
            <div className="create">
                <Navbar/>
                <center className="title">Nova Playlist</center>
                <form className="form">
                    <p>Nome da Playlist: </p>
                    <input type="text" className="nomeForm"></input><br/>
                    <Link to ='/albums'>
                        <button className="createButton" onClick={this.handleClick}>Criar</button>
                    </Link>
                </form>
            </div>
        )
    }
}