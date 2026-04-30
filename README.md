# Create Terraform Infra to deploy Jenkins Server on AWS. Terraform Code must be modular and follow all best practices. The instance must be assigned a elastic IP and have scheduled ebs snapshots once per day Jenkins must be deployed using docker compose, ensure data persistence for jenkins. Maintain the docker compose in github repo and clone docker compose in the instance to launch Jenkins Server

In the userdata.sh file we have written the docker-compose installization from github 

terraform init it install requrired dependencies

terrafrom validate command to validate the iac code

<img width="748" height="142" alt="image" src="https://github.com/user-attachments/assets/e6219c65-a02a-46ab-9b55-a397d165ae25" />


terrafrom plan - command it shows list services to add only after applying we know our ips

<img width="887" height="369" alt="image" src="https://github.com/user-attachments/assets/19ae1716-0eb0-4d7f-8626-a402770d4966" />



