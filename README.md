# Demo - Docker Registry on EC2 Instance

Note: This example uses an insecure Docker registry.

## Prerequisites

- An AWS account that can execute Terraform commands
- Docker and Docker Compose installed on your local machine

## Run the app locally

```sh
# development
docker-compose up -d

# production
docker-compose -f docker-compose.prod.yml up -d
```

## Deploy the app to EC2

Start the EC2 instance (if you're using this local one). You'll need to update `keys.tf` with your public key.

```
cd terraform
terraform plan
terraform apply
```

You will need to update the `/bin/deploy.sh` script with the IP address of the EC2 Instance. The script also assumes you have an entry in `~/.ssh/config` called `ec2`:

```
Host ec2
  HostName <EC2_IP_ADDRESS>
  IdentityFile <PATH_TO_MY_SSH_KEY>
  User ec2-user
  Port 22
```

Finally, make sure that your local Docker preferences include an Insecure Registry entry for <EC2_IP_ADDRESS>:5000. Otherwise the deploy script will fail with `connection refused`.

Before deploying, run the commands in `./bin/setup.sh` on the EC2 instance, to ensure docker is installed and the registry is running (TODO: use packer or some other instance customization for this setup).

```sh
./bin/deploy.sh
```

This will build the production images, upload them to the registry on the EC2 instance, then pull and update the containers on the instance.

To validate the app is running on the container:

```
$ curl <IP_ADDRESS>:8080
Hello, World!
```
