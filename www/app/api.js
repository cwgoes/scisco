import request from 'request';
import basex from 'base-x';

export const TENDERMINT_STATUS    = '@@API/TENDERMINT_STATUS';
export const TENDERMINT_NET_INFO  = '@@API/TENDERMINT_NET_INFO';

export const SCISCO_ELECTIONS     = '@@API/SCISCO_ELECTIONS';

const b16 = basex('0123456789ABCDEF'); 

/* Tendermint does not use standard HTTP query parameter encoding - instead JSON. */

function encodeData(data) {
  return Object.keys(data).map(function(key) {
    return [key, JSON.stringify(data[key])].join("=");
  }).join("&");
}   

const tendermint = (path, params, method, body, cb) => {
  request({url: 'http://localhost:46657' + path + '?' + encodeData(params), method: method, body: body || ''}, (err, resp, body) => {
    cb(JSON.parse(body))
  });
};

export const spock = (path, method, body, cb) => {
  request({url: 'http://localhost:8080' + path, method: method, body: body || ''}, (err, resp, body) => {
    cb(JSON.parse(body))
  });
};

export var eccKey = localStorage.eccKey ? JSON.parse(localStorage.eccKey) : undefined;
export var lrsKey = localStorage.lrsKey ? JSON.parse(localStorage.lrsKey) : undefined;

if (eccKey) {
  console.log('Found ECC keypair in local storage')
} else {
  console.log('No ECC keypair found, generating one')
  spock('/aux/ecc/keys/generate', 'GET', '', (res) => {
    eccKey = res;
    localStorage.eccKey = JSON.stringify(res)
    console.log('ECC keypair found and stored')
  });
};

if (lrsKey) {
  console.log('Found LRS keypair in local storage')
} else {
  console.log('No LRS keypair found, generating one')
  spock('/aux/lrs/keys/generate', 'GET', '', (res) => {
    lrsKey = res;
    localStorage.lrsKey = JSON.stringify(res)
    console.log('LRS keypair found and stored')
  });
};

export const commitTx = (json) => {
  tendermint('/broadcast_tx_commit', {tx: b16.encode(new Buffer(JSON.stringify(json)))}, 'POST', '', (res) => {
    const c = res.result.check_tx;
    if (c.code != 0) {
      alert('Transaction rejected at CheckTx! Log message: "' + c.log + '"');
      return;
    }
    const d = res.result.deliver_tx;
    if (c.code != 0) {
      alert('Transaction rejected at DeliverTx! Log message: "' + d.log + '"');
      return;
    }
    alert('Transaction committed! Height: ' + res.result.height + ' Hash: ' + res.result.hash);
  });
};

window.commitTx = commitTx;

export const middleware = store => next => {

  setInterval(() => {
    tendermint('/status', {}, 'GET', undefined, (res) => {
      next({type: TENDERMINT_STATUS, data: res.result});
    });
  }, 1000);

  setInterval(() => {
    tendermint('/net_info', {}, 'GET', undefined, (res) => {
      next({type: TENDERMINT_NET_INFO, data: res.result});
    });
  }, 1000);

  setInterval(() => {
    tendermint('/abci_query', {proof: false, data: '', path: 'state/elections'}, 'GET', undefined, (res) => {
      const elections = JSON.parse(b16.decode(res.result.response.value).toString('ascii'));
      next({type: SCISCO_ELECTIONS, data: elections});
    });
  }, 1000);

  const wrapped = action => {
    next(action);
  };  

  return wrapped;

};
