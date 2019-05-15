import * as actionTypes from '../actions/actionTypes';

const initialState = {
    pending: false,
    accounts: [],
    error: null
}
 
export default function accountsReducer(state = initialState, action) {
    switch(action.type) {
        case actionTypes.GET_ACCOUNTS_PENDING:
            return {
                ...state,
                pending: true
            }
        case actionTypes.GET_ACCOUNTS_SUCCESS:
            return {
                ...state,
                pending: false,
                accounts: action.payload
            }
        case actionTypes.GET_ACCOUNTS_FAILED: 
            return {
                ...state,
                pending: false,
                error: action.error
            }
        default:
            return state;
    }
}

export const getAccounts = state => state.accounts;
export const getAccountsPending = state => state.pending;
export const getAccountsError = state => state.error;