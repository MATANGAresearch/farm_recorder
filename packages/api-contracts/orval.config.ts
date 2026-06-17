export default {
  farmRecorder: {
    input: {
      target: 'http://localhost:8082/q/openapi.json',
    },
    output: {
      mode: 'tags-split',
      target: '../../apps/web/src/api/farmRecorder.ts',
      schemas: '../../apps/web/src/api/schemas',
      client: 'react-query',
      mock: false,
    },
  },
};
