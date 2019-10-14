import React from 'react';
import {Link} from 'react-router-dom';
import logo from '../../assets/logo.svg';
import './styles.css';

const Navbar = () => {
    return(
        <nav>
            <Link to='/'>
                <img src={logo}/>
            </Link>
        </nav>
    )
}

export default Navbar;