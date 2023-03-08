# aws-terraform


Consideration:

I used the ami that was already given in aws but that can be adjusted using data if you have a pre-built ami.


Question

How would future application obtain the loadbalancer DNS name if it wanted to use the service.

we can store the terraform statefile in a remote location and output the details of the loadbalancer dns.

we can also use data source to add obtain the details and pass it to the application as a  variable


What aspect needs to be considered to make the code work in a CD pipeline? (How does it successfully and safely get into production)

We have to consider where we store the code and how the changes we make trigger the CD pipeline. What controls we put in place to make sure breaking change are not deployed to production environment

We also need to consider the environment if it will work with the code e.g. do we want to use serverless or server? do we want control over the response and request rate? and if the application language will work with the environment we built.

We need to consider the application build stage. The variables, dependencies and the language it is written would command how we build it. 

We also need to  test the application to validate how correct the code it and how it behaves or it will behave when it gets into production environment.

We then need to consider the deploy stage, where we deploy first to maybe a dev environment and see how it works, then to maybe a staging environment so that the end users can test it and if at this stage everything work, we can consider pushing to production. 

There are many other but this are the main aspect  that needs to be considered and would help ensure thatthe code is successfully and safely pushed into production.
