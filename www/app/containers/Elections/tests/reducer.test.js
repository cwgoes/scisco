
import { fromJS } from 'immutable';
import electionsReducer from '../reducer';

describe('electionsReducer', () => {
  it('returns the initial state', () => {
    expect(electionsReducer(undefined, {})).toEqual(fromJS({}));
  });
});
