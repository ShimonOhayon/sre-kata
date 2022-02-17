# sre-kata

This kata wants to simulate the setup of a dummy application which will be run as a container based workload in AWS.

Your application will be exposing an HTTP endpoint which, given an input string, returns the amount of characters appearing at least 2 times in it.

For instance, given the input string 'caiopa', the result will be 1 given that only the letter 'a' is repeated.


Please, follow these rules to achieve the goal:

1. Fork the repository.
2. Implement the application code, you can pick up any programming language or technology of your choice.
3. Define the infrastructure via any IaC tool of your choice.
4. Automate the application, and related infrastructure, deployment
5. Once deployed, the application should be secure, fast, scalable, and highly available.
6. Make any assumptions that you need to considering that your application will be publicly exposed.
7. Once your solution is ready, please send us the link of your project.
