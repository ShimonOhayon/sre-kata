# sre-kata

## The Solution

**Summary:**

I used Terraform, GitHub Actions A Flask python App and [AWS App Runner](https://aws.amazon.com/apprunner).

To use it for the first time run the `First Time Setup` workflow (Can take up to 10 minutes to complete).

For every  change of the `app` (directory) that is pushed to `master` branch, A new version will be released and deployed.

The solution in this repository is fixed with my AWS account but its built in such a way that you can use it with your own account.

The app expect a `param` input argument under the `query` endpoint.
for exmaple: `https://Your-AWS-URL/query?param=acx333x`

### Coding

My approach to this was first to solve the coding logic locally.
I used python3 to do so:

I accept 1 param and i forced it to a string type.
I used *list comprehension* to loop over every character and check if its exists more than once using the python `str.count()` built in method.

I assume the focus of the task is not about counter loop.

If the character repeated at least twice it is added to a list.
Then i return the lenght of a set of the list (remove duplicates)

### Development Environment

For Development purpose i used a *Makefile* to ease the build run and removal of the docker container.

I've fixed the packages to specific versions to avoid missmatch with another environments or builds.

### Dockerizing

I used multistage DockerFile to install dependencies and copy them to a second image layer. This speed up the build and drop unneeded package/files from the image.

### IaaC

Since the task excplictly said to run the solution in container.
I was considering Lambda, ECS+fargate in the end i went with AWS App Runner.

From AWS:

*AWS App Runner is a fully managed service that makes it easy for developers to quickly deploy `containerized web applications` and APIs, `at scale` and with no prior infrastructure experience required. Start with your source code or a container image. App Runner builds and deploys the web application automatically, `load balances traffic with encryption`....*


Why not AWS Lambda?

- Not scalable
- Harder to monitor
- Dependecies are managed as layers.

Why not AWS EKS or ECS?

I took your advise not to over engineer this solution :)
I kept it simple.


### Terraform

Here I've created the minimum number of resources needed to create the AWS App Runner.

I've created before hand the S3 backend and dynamoDB Table for the remote state.

### GitHub Actions, Release and CI/CD

There are 2 workflow. The [First Time Setup](https://github.com/ohayonshimon/sre-kata/actions/workflows/run-once.yaml) is design to create the ECR and IAM role before the App Runner code is beeing applied.

Also App Runner will fail if there isn't Image ready in the asigned repository. so a Docker build and push are needed as well.

The [release](https://github.com/ohayonshimon/sre-kata/actions/workflows/release.yaml) workflow design to create a Github repository tag, Build and push a new docker image (overwrite `latest`), And update the AWS tags with the new version for better visibility For Every push to `master`

App Runner is set to automaticlly deploy on image changes.

### Assumptions

The task mention HTTP endpoint, But it was clear to me that nothing should run on HTTP protocol these days, not even recuirtment tasks. so I forced the use of HTTPS.

I didn't not santized the input to support URL encoding only, In real life this will be needed to protect from string query manipulation.

I used *Flask* app together with *Gunicorn* to make it more Production worthy, But this will probably will not be my recommendation goign to Production. I would used Nginx/HAproxy infront of python backend service.


### Known issues and limitations

- Incoming traffic will be protected with WAF and/or reverse proxy and not directly to the service
- Missing more extensive error handling and logging
- I used some online resources and examples to package the Flask app.
   The code logic its all by me
- Terraform can be improved to be more organized.
- AWS authentication from GitHub Action should be done with assuming role and not access keys
- It's not best practice to use mutable `latest` image tag to deploy versions of containers.
- I didn't automated the creation of the S3 bucket and dynamoDB, I assumed one time tasks are reasonable to create and the coding challange is  focusing on other aspects.

### Building and packaging a Flask app

#### Structure

- `app` dir - Contains the flask initialization and API server code.

#### Makefile

 For local development only

- `build`: Builds the docker image.
- `run`: Runs the docker image.
- `kill`: Cleans up the docker container and image.

#### Gunicorn

- Gunicorn is the python based WSGI HTTP Server to allow concurrency and load management in Production systems.

#### Third-Party Libs

Name     | Version
---------|------------
Flask    | 2.1.0
Gunicorn | 20.0.4

---

**For any questions or clarification feel free to contact me*
