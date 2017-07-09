import { createSelector } from 'reselect';

/**
 * Direct selector to the elections state domain
 */
const selectElectionsDomain = () => (state) => state.get('global');

/**
 * Other specific selectors
 */


/**
 * Default selector used by Elections
 */

const makeSelectElections = () => createSelector(
  selectElectionsDomain(),
  (substate) => substate.toJS()
);

export default makeSelectElections;
export {
  selectElectionsDomain,
};
