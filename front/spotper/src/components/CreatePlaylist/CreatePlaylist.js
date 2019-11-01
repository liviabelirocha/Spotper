import React from 'react';
import {Redirect} from 'react-router-dom';
import axios from 'axios';

import Navbar from '../Navbar/Navbar';

import './styles.css';

export default class CreatePlaylist extends React.Component {
    state = {
        name: '',
        redirect: false,
    }

    handleChange = () => {
        this.setState({name: this.state.name});
    }

    /*
    handleClick = () => {
        const playlistName = { name: this.state.name };
        axios.post('link', {playlistName}).then(res => {
            this.setState({ redirect: true });
        })
    }*/

    handleClick = () => {
        this.setState({redirect:true})
    }

    render() {
        if (this.state.redirect) { return <Redirect push to = '/albums'/> }

        return (
            <div className="create">
                <Navbar/>
                <center className="title">Nova Playlist</center>
                <form className="form" onSubmit={this.handleClick}>
                    <p>Nome da Playlist: </p>
                    <input type="text" className="nomeForm" name={this.state.name} onChange={this.handleChange} required></input><br/>
                    <button className="createButton" type='submit'>Criar</button>
                </form>
            </div>
        )
    }
}