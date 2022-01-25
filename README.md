# CVWO AY21/22 Assignment - Backend
## Quick links
[Main](https://github.com/heyzec/cvwo-assignment) • [Frontend](https://github.com/heyzec/cvwo-frontend) • [Link to deployment](https://heyzec-cvwo.netlify.app/)


## Other info
![Repo size](https://img.shields.io/github/repo-size/heyzec/cvwo-backend)
- Ruby version: 3.0.2
- Rails version: 6.1.4.1
- Database: PostgreSQL

## Dependencies
_Only showing additionally installed_
|Gem|Purpose|
|---|---|
|[rack-cors](https://github.com/cyu/rack-cors)|For CORS|
|[bcrypt](https://github.com/bcrypt-ruby/bcrypt-ruby)|User authentication|
|[rest-client](https://github.com/rest-client/rest-client)|Making HTTP requests, required for OAuth logins|


## Local deployment
Note: Frontend runs on port 4000, while backend runs on port 3000. (By default, React will use port 3000).

Click [here](https://github.com/heyzec/cvwo-frontend#local-deployment) for frontend instructions.
### Backend instructions
0. Clone this repository and `cd` into it.
1. Rename the file in the [`config`](config) folder from [`local_env.yml.example`](config/local_env.yml.example) to `local_env.yml`.
2. Run the following commands:
```
bundle install
yarn install
rails db:create db:migrate db:seed
rails server
```


### Environment variables
_If you want to test out the OAuth login feature, you'll need to grab some credentials from GitHub and Google._
|Variable|Notes|
|---|---|
|APP_FRONTEND_URL|Required, without trailing slash|
|APP_BACKEND_URL|Required, trailing slash|
|AUTH_GITHUB_CLIENT_ID|
|AUTH_GITHUB_SECRET_ID|
|AUTH_GOOGLE_CLIENT_ID|
|AUTH_GOOGLE_SECRET_ID|
