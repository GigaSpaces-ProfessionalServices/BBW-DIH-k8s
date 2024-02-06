import http from 'k6/http';
import { check, sleep } from 'k6';

let url = "https://bbw-gs/api/get-emp-id?EMPID=456"

export const options = {
  insecureSkipTLSVerify: true,
  discardResponseBodies: true,
 // tlsAuth: [ { cert: open('./test-client.cer'), key: open('./test-client.key'), }, ],
  scenarios: {
      per_vu_iterations: {
          executor: 'per-vu-iterations',
          startTime: '0s',
          vus: 30, 
          iterations: 1500,
          maxDuration: '10s',
      },
  },
};

export default function () {
  let response = http.get(url);
  //console.log(`Response status code: ${response.status}`);
  //console.log(`Response body: ${response.body}`);
  check(response, {
    'is status 200': (r) => r.status === 200,
  });
  // sleep(0.005); // Wait for 1 second before making the next request
}
