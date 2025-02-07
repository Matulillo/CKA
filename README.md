# My-TF-demo
Basic terraform project template for demo. 
It enables the creation of AWS basic cloud enviroments with mainly: VPC,Subnets,routing config, instances, security groups, etc.. using custom modules.  

Follow the below steps

1. Copy template folder and rename it with the name of the new environmnet to deploy
2. In the main.tf file , set the value of the "key" under backend block as the env name 
3. Adjust the terrform.tfvars with the desired values for the resources to deploy (vpc cidr block, subnet, instances etc..)  
4. Run terraform init to inizialize the new TF folder
5. Run terraform plan to check the deployment plan
6. Run terraform apply to deploy the resources 


