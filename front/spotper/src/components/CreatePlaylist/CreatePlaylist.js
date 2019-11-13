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

    handleChange = event => { this.setState({name: event.target.value}); }

    handleClick = event => {
        event.preventDefault();
        axios.post('http://localhost:5000/createplaylist', {name: this.state.name}, 
        ).then(res => {
            console.log(res);
            this.setState({ redirect: true });
        }).catch(error => {
            console.log(error.response);
        });
    }

    render() {
        if (this.state.redirect) { return <Redirect push to = '/albums'/> }

        return (
            <div className="create">
                <Navbar/>
                <center className="title">Nova Playlist</center>
                <form className="form" onSubmit={this.handleClick}>
                    <p>Nome da Playlist: </p>
                    <input type="text" className="nomeForm" name='name' onChange={this.handleChange} required></input><br/>
                    <button className="createButton" type='submit'>Criar</button>
                </form>
            </div>
        )
    }
}