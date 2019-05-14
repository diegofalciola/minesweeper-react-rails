import * as actionTypes from './actionTypes'

function getAccountsPending() {
    return {
        type: actionTypes.GET_ACCOUNTS_PENDING
    }
}

function getAccountsSuccess(accounts) {
    return {
        type: actionTypes.GET_ACCOUNTS_SUCCESS,
        accounts
    }
}

function getAccountsFailed(error) {
    return {
        type: actionTypes.GET_ACCOUNTS_FAILED,
        error
    }
}

function getAccounts() {
    return dispatch => {
        dispatch(getAccountsPending());
        fetch('http://localhost:4000/balances')
            .then(res => res.json())
            .then(res => {
                if(res.error) {
                    throw (res.error);
                }
                dispatch(getAccountsSuccess(res))
                return res;
            })
            .catch(error => {
                dispatch(getAccountsFailed(error))
            })
    }
}

export default getAccounts;