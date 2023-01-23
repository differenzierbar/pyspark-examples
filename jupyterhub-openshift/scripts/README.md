# OAuth Service account & client secret creation

We are currently using Openshift OAuth with a service account as OAuth client:
https://oauthenticator.readthedocs.io/en/latest/getting-started.html#service-accounts-as-oauth-clients

We do not automate the service account creation with flux since we have to update our OAuth client secret
with the service account token.

Therefore we have this script: [oauth-service-account-and-secret.sh](oauth-service-account-and-secret.sh) which has to be manually executed (only once though).
