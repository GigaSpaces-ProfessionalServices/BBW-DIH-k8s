import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  insecureSkipTLSVerify: true,
  discardResponseBodies: true,
  scenarios: {
    per_vu_iterations: {
      executor: 'per-vu-iterations',
      startTime: '0s',
      vus: 1000,
      iterations: 1000,
      maxDuration: '1m',
    },
  },
  ext: {
    loadimpact: {
      projectID: 1234567,
      name: 'test2',
      logFile: './k6-test2.log',
    },
  },
};

export default function () {
  // Generate a random EMPID value between 1 and 50000000
  const randomEmpId = Math.floor(Math.random() * 50000000) + 1;

  // Use the generated EMPID value in the URL
  let url = `https://bbw-gs/api/get-emp-id?EMPID=${randomEmpId}`;

  // Log the URL before making the request
  console.log(`Calling: ${url}`);

  let response = http.get(url);

  // Perform checks on the response
  check(response, {
    'is status 200': (r) => r.status === 200,
  });

  // Optional: sleep for a short duration between requests
  // sleep(0.005); // Wait for 1 second before making the next request
}

