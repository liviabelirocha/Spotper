import React from "react";
import {Link} from 'react-router-dom';

import './styles.css';
import {ReactComponent as Plus} from '../../assets/plus.svg';
import {ReactComponent as Edit} from '../../assets/edit.svg';

const Home = () => {
    return(
        <div>
            <Link to ="/">
                <button className="button1">
                    <div className="content">
                        <Plus className="icon"/>
                        <p>Criar nova playlist</p>
                    </div>
                </button>
            </Link>
            <Link to="/">
                <button>
                    <div className="content">
                        <Edit className="icon"/>
                        <p>Editar playlist existente</p>
                    </div>
                </button>
            </Link>
        </div>
    )
}

export default Home;