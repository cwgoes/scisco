import React from 'react';
import { FormattedMessage } from 'react-intl';
import messages from './messages';
import { push } from 'react-router-redux';
import { Button } from "@blueprintjs/core";

export default class HomePage extends React.Component {

  constructor(props) {
    super(props);
    this.handleOverview = this.handleOverview.bind(this);
    this.viewElections = this.viewElections.bind(this);
  }

  handleOverview() {
    window.open('https://github.com/cwgoes/scisco/README.md');
  }

  viewElections() {
    dispatch(push('/elections'));
  }

  render() {
    return (
      <div style={{position: 'absolute', top: '40%', width: '100%', textAlign: 'center'}}>
        <h1>Scisco</h1>
        <br />
        <h4>A privacy-preserving, auditable, distributed voting system.</h4>
        <br />
        <br />
        <Button className='pt-button pt-intent-warning' iconName='link' onClick={this.handleOverview}>Motivation & Overview</Button>
        <br />
        <br />
        <Button className='pt-button pt-intent-success' iconName='share' onClick={this.viewElections}>View Elections</Button>
      </div>
    );
  }
}
