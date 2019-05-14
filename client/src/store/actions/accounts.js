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