import { createSelector } from 'reselect';

/**
 * Direct selector to the election state domain
 */
const selectElectionDomain = () => (state) => state.get('election');

/**
 * Other specific selectors
 */


/**
 * Default selector used by Election
 */

const makeSelectElection = () => createSelector(
  selectElectionDomain(),
  (substate) => substate.toJS()
);

export default makeSelectElection;
export {
  selectElectionDomain,
};
