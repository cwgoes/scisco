import React, { PropTypes } from 'react';
import { connect } from 'react-redux';
import Helmet from 'react-helmet';
import { createStructuredSelector } from 'reselect';
import makeSelectElections from './selectors';
import { Button } from '@blueprintjs/core';

import { spock, commitTx, eccKey, lrsKey } from '../../api';

export class Elections extends React.Component {
  constructor(props) {
    super(props)
    this.createElection = this.createElection.bind(this)
    this.attemptTransition = this.attemptTransition.bind(this)
    this.attemptRegisterCandidate = this.attemptRegisterCandidate.bind(this)
    this.attemptRegisterVoter = this.attemptRegisterVoter.bind(this)
    this.attemptCastVote = this.attemptCastVote.bind(this)
  }

  createElection() {
    commitTx({
      startelection: {
        electionName : this.refs.name.value,
        electionAuthorityPubKey : eccKey.public,
        electionTransitionBlocks : [parseInt(this.refs.blockA.value) || 0, parseInt(this.refs.blockB.value) || 0]
      }
    }); 
  } 

  attemptTransition(e, now) {
    const next = {
      registration: 'voting',
      voting: 'finished'
    }[now];
    if (!next) {
      alert('Election already finished!');
      return;
    }
    commitTx({
      transition: {
        electionName: e,
        fromStage: now,
        toStage: next
      }
    });
  }

  attemptRegisterCandidate(e) {
    commitTx({
      registerascandidate: {
        electionName: e,
        name: this.refs[e + ':candidateName'].value,
        pubKey: eccKey.public
      }
    });
    this.refs[e + ':candidateName'].value = '';
  }

  attemptRegisterVoter(e) {
    commitTx({
      registerasvoter: {
        electionName: e,
        name: this.refs[e + ':voterName'].value,
        pubKey: eccKey.public,
        lRSPubKey: lrsKey.public
      }
    });
    this.refs[e + ':voterName'].value = '';
  }

  acceptCandidate(e, pubKey) {
    spock('/aux/ecc/accept', 'POST', JSON.stringify([e, 'acceptCandidate', pubKey, eccKey.private]), (sig) => {
      commitTx({
        acceptcandidate: {
          candidateElectionName: e,
          candidatePubKey: pubKey,
          candidateSignature: sig
        }
      });
    });
  }

  rejectCandidate(e, pubKey) {
    const reason = prompt('Enter a reason for rejection: ');
    spock('/aux/ecc/reject', 'POST', JSON.stringify([e, 'rejectCandidate', pubKey, reason, eccKey.private]), (sig) => {
      commitTx({
        rejectcandidate: {
          candidateElectionName: e,
          candidatePubKey: pubKey,
          candidateSignature: sig,
          candidateReason: reason
        }
      });
    });
  }

  acceptVoter(e, pubKey) {
    spock('/aux/ecc/accept', 'POST', JSON.stringify([e, 'acceptVoter', pubKey, eccKey.private]), (sig) => {
      commitTx({
        acceptvoter: {
          voterElectionName: e,
          voterPubKey: pubKey,
          voterSignature: sig
        }
      });
    });
  }

  rejectVoter(e, pubKey) {
    const reason = prompt('Enter a reason for rejection: ');
    spock('/aux/ecc/reject', 'POST', JSON.stringify([e, 'rejectVoter', pubKey, reason, eccKey.private]), (sig) => {
      commitTx({
        rejectvoter: {
          voterElectionName: e,
          voterPubKey: pubKey,
          voterSignature: sig,
          voterReason: reason
        }
      });
    });
  }

  attemptCastVote(e, elec) {
    const name = this.refs[e + ':ballot'].value;
    const m = elec.acceptedCandidates.filter(x => x[1] === name);
    if (m.length === 0) {
      alert('Candidate not found!');
      return;
    };
    spock('/aux/lrs/votes/sign', 'POST', JSON.stringify([elec.voterRing, lrsKey.private, e, m[0][0]]), (sig) => {
      commitTx({
        castballot: {
          ballotElectionName: e,
          signature: sig,
          candidate: m[0][0]
        }
      });
    });
    this.refs[e + ':ballot'].value = '';
  }
  
  render() {

    const { chainHeight, lastHash, peers, network, elections } = this.props;

    return (
      <div>
        <Helmet
          title="Scisco - Elections"
        />
        <br />
        <div style={{marginLeft: '10px', marginRight: '10px', width: '600px'}}>
          <div className='pt-callout pt-intent-danger'>
          Please note that all encryption keys in this demonstration are stored in your browser's local storage. If you wish to reset your keys, run "localStorage.clear()" in the JS console and reload the page. If you wish to test multiple users simultaneously, utilize separate private browsing instances.
          </div>
        </div>
        <br />
        <div style={{marginLeft: '10px', marginRight: '10px', width: '600px'}}>
          <div className='pt-callout pt-intent-primary'>{'Network name: ' + network}</div>
          <div className='pt-callout'>{'Connected peers: ' + peers}</div>
          <div className='pt-callout pt-intent-success'>{'Chain height: ' + chainHeight}</div>
          <div className='pt-callout pt-intent-warning'>{'Last block hash: ' + lastHash}</div>
        </div>
        {Object.keys(elections).sort().map(e => {
          const elec = elections[e];
          const amAuthority = elec.authorityPubKey === eccKey.public;
          const amVoter = elec.acceptedVoters.filter(x => x[0] === eccKey.public).length > 0;
          return (
            <div key={e} style={{margin: '10px', padding: '10px', border: '1px solid #000', width: '600px'}}>
            <span>Election <span className='pt-callout' style={{padding: '5px'}}>{e}</span> Stage <span className='pt-callout pt-intent-primary' style={{padding: '5px'}}>{elec.stage}</span></span>
            <span style={{position: 'relative', float: 'right'}}><Button className='pt-button pt-intent-warning' style={{marginLeft: '10px'}} onClick={() => this.attemptTransition(e, elec.stage.toLowerCase())}>Transition</Button></span>
            <br />
            <br />
            {amAuthority ? <span className='pt-callout pt-intent-warning' style={{padding: '5px'}}>You are the identification authority for this election.</span> : ''}
            <br />
            <br />
            {amVoter ? <span className='pt-callout pt-intent-warning' style={{padding: '5px'}}>You are a registered voter in this election.</span> : ''}
            <div>
              <div className='pt-callout' style={{marginTop: '10px'}}>Votes Cast</div>
              {elec.votes.sort((x, y) => x[1] > y[1] ? 1 : -1).map(x => {
                const name = elec.acceptedCandidates.filter(y => y[0] === x[0])[0][1];
                return <div style={{marginTop: '10px'}}><span className='pt-callout' style={{padding: '5px'}}>{name}</span><span className='pt-callout pt-intent-success' style={{padding: '5px', marginLeft: '10px'}}>{x[1]}</span></div>
              })}
            </div>
            {elec.stage === 'Voting' ? 
              <div>
                <div className='pt-callout' style={{marginTop: '10px'}}>Accepted Candidates</div>
                {elec.acceptedCandidates.map(x => {
                  return <div style={{marginTop: '10px', marginBottom: '10px'}}><span className='pt-callout'>{x[1]}</span></div>;
                })}
                <input type='text' className='pt-input pt-input-primary' placeholder='Candidate Name' ref={e + ':ballot'}></input>
                <span style={{width: '10px'}}> </span>
                <Button className='pt-intent-primary' onClick={() => this.attemptCastVote(e, elec)}>Cast Ballot</Button>
              </div>
            : ''}
            {elec.stage === 'Registration' ? 
              <div>
                <br />
                <input type='text' className='pt-input pt-input-primary' placeholder='Candidate Name' ref={e + ':candidateName'}></input>
                <span style={{width: '10px'}}> </span>
                <Button className='pt-intent-primary' onClick={() => this.attemptRegisterCandidate(e)}>Register As Candidate</Button>
                <br />
                <br />
                <input type='text' className='pt-input pt-input-primary' placeholder='Voter Name' ref={e + ':voterName'}></input>
                <span style={{width: '10px'}}> </span>
                <Button className='pt-intent-primary' onClick={() => this.attemptRegisterVoter(e)}>Register As Voter</Button>
                <br />
                <br />
                <div className='pt-callout' style={{marginTop: '10px'}}>Pending Candidates</div>
                {elec.pendingCandidates.map(x => {
                  return (
                    <div style={{padding: '10px'}}>
                    <span>Name <span className='pt-callout' style={{padding: '5px'}}>{x[1]}</span></span>
                    {amAuthority ?
                        <span>
                          <Button className='pt-button pt-intent-success' onClick={() => this.acceptCandidate(e, x[0])}>Accept</Button>
                          <span style={{width: '10px'}}> </span>
                          <Button className='pt-button pt-intent-danger' onClick={() => this.rejectCandidate(e, x[0])}>Reject</Button>
                        </span>
                      : ''}
                    </div>
                  );
                })}
                <div className='pt-callout' style={{marginTop: '10px'}}>Pending Voters</div>
                {elec.pendingVoters.map(x => {
                  return (
                    <div style={{padding: '10px'}}>
                    <span>Name <span className='pt-callout' style={{padding: '5px'}}>{x[1]}</span></span>
                    {amAuthority ?
                        <span>
                          <Button className='pt-button pt-intent-success' onClick={() => this.acceptVoter(e, x[0])}>Accept</Button>
                          <span style={{width: '10px'}}> </span>
                          <Button className='pt-button pt-intent-danger' onClick={() => this.rejectVoter(e, x[0])}>Reject</Button>
                        </span>
                      : ''}
                    </div>
                  );
                })}
                <div className='pt-callout' style={{marginTop: '10px'}}>Accepted Candidates</div>
                {elec.acceptedCandidates.map(x => {
                  return <div style={{marginTop: '10px', marginBottom: '10px'}}><span className='pt-callout'>{x[1]}</span></div>;
                })}
                <div className='pt-callout' style={{marginTop: '10px'}}>Accepted Voters</div>
                {elec.acceptedVoters.map(x => {
                  return <div style={{marginTop: '10px', marginBottom: '10px'}}><span className='pt-callout'>{x[1]}</span></div>;
                })}
              </div>
            : ''}
            </div>
          );
        })}
        <div style={{marginLeft: '10px', marginTop: '40px', marginBottom: '40px'}}>
          <input type='text' className='pt-input pt-input-primary' placeholder='Election Name' ref='name'></input>
          <input type='text' className='pt-input pt-input-primary' placeholder='Min. Registration End Block' ref='blockA'></input>
          <input type='text' className='pt-input pt-input-primary' placeholder='Min. Voting End Block' ref='blockB'></input>
          <span style={{width: '10px'}}> </span>
          <Button className='pt-button pt-intent-primary' onClick={this.createElection}>Create New Election</Button>
        </div>
      </div>
    );
  }
}

Elections.propTypes = {
  dispatch: PropTypes.func.isRequired,
};

const mapStateToProps = makeSelectElections();

function mapDispatchToProps(dispatch) {
  return {
    dispatch,
  };
}

export default connect(mapStateToProps, mapDispatchToProps)(Elections);
