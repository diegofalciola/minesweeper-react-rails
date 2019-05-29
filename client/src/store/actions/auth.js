import * as actionTypes from './actionTypes'
import API from '../../api';

export const authStart = () => {
    return {
        type: actionTypes.AUTH_START
    };
};

export const authSuccess = ( token ) => {
    return {
        type: actionTypes.AUTH_SUCCESS,
        token,
    };
};

export const authFailure = ( error ) => {
    return {
        type: actionTypes.AUTH_FAIL,
        error: error
    };
};

export const checkAuthTimeout = ( expirationTime ) => {
    return dispatch => {
        setTimeout(() => {
            dispatch( logout() ); 
        }, expirationTime * 1000 );
    };
};

export const logout = () => {
    localStorage.removeItem( 'token' );
    // localStorage.removeItem( 'expirationDate' );
    // localStorage.removeItem( 'userId' );
    return {
        type: actionTypes.AUTH_LOGOUT
    };
};

export const auth = ( email, password ) => {
    return dispatch => {
        
        dispatch( authStart() );

        const authData = {
            user: {
                email: email,
                password: password,
            }
        }

        API.get('/users/login')
            .then(res => res.json())
            .then(res => {
                if(res.error) {
                    throw (res.error);
                }
                
                localStorage.setItem( 'token', res.data.auth_token );

                dispatch( authSuccess( res.data.auth_token ) );
                // dispatch( checkAuthTimeout( res.data.expiresIn ) );
                
                return res;
            })
            .catch(error => {
                dispatch( authFailure( error.response.data.error ) );
            })
    };
};

export const setAuthRedirectPath = ( path ) => {
    return {
        type: actionTypes.SET_AUTH_REDIRECT_PATH,
        path: path    
    }
}

export const authCheckState = () => {
    return dispatch => {
        const token = localStorage.getItem( 'token');
        if( !token ){
            dispatch( logout() );
        }else{
            const expirationDate = new Date(localStorage.getItem( 'expirationDate' ));

            if( expirationDate > new Date() ){
                const userId = localStorage.getItem( 'userId ');
                dispatch( authSuccess( token, userId ) );
                dispatch( checkAuthTimeout( ( expirationDate.getTime() - new Date().getTime() ) / 1000 ) );
            }else{
                dispatch( logout() );
            }
            
        }

    };
};