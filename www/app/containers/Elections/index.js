import React, { PropTypes } from 'react';
import { connect } from 'react-redux';
import Helmet from 'react-helmet';
import { createStructuredSelector } from 'reselect';
import makeSelectElections from './selectors';

export class Elections extends React.Component {
  render() {
    return (
      <div>
        <Helmet
          title="Scisco - Elections"
        />
      </div>
    );
  }
}

Elections.propTypes = {
  dispatch: PropTypes.func.isRequired,
};

const mapStateToProps = createStructuredSelector({
  Elections: makeSelectElections(),
});

function mapDispatchToProps(dispatch) {
  return {
    dispatch,
  };
}

export default connect(mapStateToProps, mapDispatchToProps)(Elections);
