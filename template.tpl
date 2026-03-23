___INFO___

{
  "type": "TAG",
  "id": "cvt_netaj_analytics",
  "version": 1,
  "securityGroups": [],
  "displayName": "Netaj",
  "categories": ["ANALYTICS", "EXPERIMENTATION", "HEAT_MAP"],
  "brand": {
    "id": "brand_netaj",
    "displayName": "Netaj",
    "thumbnail": ""
  },
  "description": "Netaj is an AB testing, heatmaps, session recordings, and conversion rate optimization platform. This tag loads the Netaj tracking script on your website. Enter your Organization ID from the Netaj dashboard to get started.",
  "containerContexts": [
    "WEB"
  ],
  "tosAccepted": true,
  "termsOfService": {
    "hasTermsOfService": true,
    "termsOfServiceUrl": "https://netaj.io/en/terms"
  }
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "orgId",
    "displayName": "Organization ID",
    "simpleValidators": [
      "NON_EMPTY"
    ],
    "help": "Your Netaj Organization ID (e.g. nj_a1b2c3d4). Find it in your Netaj dashboard under Settings \u2192 Websites.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "REGEX",
        "args": ["^nj_[a-f0-9]{8}$"]
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const injectScript = require('injectScript');
const createArgumentsQueue = require('createArgumentsQueue');
const log = require('logToConsole');

// Set up the global netaj() command queue (available before script loads)
const netaj = createArgumentsQueue('netaj', 'netaj.q');

const orgId = data.orgId;
const url = 'https://api.netaj.io/t/' + orgId + '.js';

log('[Netaj] Loading tracker for org: ' + orgId);

injectScript(url, function() {
  log('[Netaj] Script loaded successfully');
  data.gtmOnSuccess();
}, function() {
  log('[Netaj] Script failed to load');
  data.gtmOnFailure();
}, 'netajTracker');


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": "logging",
      "value": {
        "environments": "debug"
      }
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": "inject_script",
      "value": {
        "urls": [
          {
            "string": "https://api.netaj.io/t/*",
            "type": "WILDCARD"
          }
        ]
      }
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": "access_globals",
      "value": {
        "keys": [
          {
            "key": "netaj",
            "read": true,
            "write": true,
            "execute": true
          },
          {
            "key": "netaj.q",
            "read": true,
            "write": true,
            "execute": false
          }
        ]
      }
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: "Loads script with valid org ID"
  code: |-
    const mockData = {
      orgId: "nj_a1b2c3d4",
      gtmOnSuccess: () => {},
      gtmOnFailure: () => {}
    };

    mock('injectScript', function(url, onSuccess, onFailure, cacheKey) {
      assertThat(url).isEqualTo('https://api.netaj.io/t/nj_a1b2c3d4.js');
      assertThat(cacheKey).isEqualTo('netajTracker');
      onSuccess();
    });

    runCode(mockData);
    assertApi('gtmOnSuccess').wasCalled();

- name: "Handles script load failure"
  code: |-
    const mockData = {
      orgId: "nj_a1b2c3d4",
      gtmOnSuccess: () => {},
      gtmOnFailure: () => {}
    };

    mock('injectScript', function(url, onSuccess, onFailure, cacheKey) {
      onFailure();
    });

    runCode(mockData);
    assertApi('gtmOnFailure').wasCalled();
