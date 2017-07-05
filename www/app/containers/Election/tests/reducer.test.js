
import { fromJS } from 'immutable';
import electionReducer from '../reducer';

describe('electionReducer', () => {
  it('returns the initial state', () => {
    expect(electionReducer(undefined, {})).toEqual(fromJS({}));
  });
});
