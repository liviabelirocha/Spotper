import React from 'react';
import axios from 'axios';

import Navbar from '../Navbar/Navbar';

import './styles.css';

export default class CreatePlaylist extends React.Component {
    state = {
        name: '',
    }

    handleChange = event => { this.setState({ name: event.target.value }); }

    handleClick = event => {
        event.preventDefault();
        axios.post('http://localhost:5000/createplaylist', { name: this.state.name }, {
            headers: { 'Access-Control-Allow-Origin': '*' },
        }).then(res => {
            console.log(res);
            alert("Playlist Criada!");
            this.props.history.push('/playlists');
        }).catch(error => {
            console.log(error);
            alert("Erro!");
            this.props.history.push('/');
        });
    }

    render() {
        return (
            <div className="create">
                <Navbar />
                <center className="title">Nova Playlist</center>
                <form className="form" onSubmit={this.handleClick}>
                    <p>Nome da Playlist: </p>
                    <input type="text" className="nomeForm" name='name' onChange={this.handleChange} autocomplete="off" required></input><br />
                    <button className="createButton" type='submit'>Criar</button>
                </form>
            </div>
        )
    }
}