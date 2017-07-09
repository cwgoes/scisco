import { combineReducers } from 'redux-immutable';
import { fromJS } from 'immutable';
import { LOCATION_CHANGE } from 'react-router-redux';
import { TENDERMINT_STATUS, TENDERMINT_NET_INFO, SCISCO_ELECTIONS } from './api';

import languageProviderReducer from 'containers/LanguageProvider/reducer';

const routeInitialState = fromJS({
  locationBeforeTransitions: null,
});

function routeReducer(state = routeInitialState, action) {
  switch (action.type) {
    case LOCATION_CHANGE:
      return state.merge({
        locationBeforeTransitions: action.payload,
      });
    default:
      return state;
  }
}

const globalInitialState = fromJS({
  elections: [],
  peers: 0,
  network: '',
  chainHeight: 0,
  lastHash: ''
});

function globalReducer(state = globalInitialState, action) {

  switch(action.type) {
    case TENDERMINT_STATUS:
      return state.set('network', action.data.node_info.network).set('chainHeight', action.data.latest_block_height).set('lastHash', action.data.latest_block_hash);
    case TENDERMINT_NET_INFO:
      return state.set('peers', action.data.peers.length);
    case SCISCO_ELECTIONS:
      return state.set('elections', action.data);
    default:
      return state;
  }

}

export default function createReducer(asyncReducers) {
  return combineReducers({
    route: routeReducer,
    language: languageProviderReducer,
    global: globalReducer,
    ...asyncReducers,
  });
}
