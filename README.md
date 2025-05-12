# Parking Ticket App

This repository contains the Parking Ticket App, which is deployed using Terraform and runs on an AWS EC2 instance. Follow the instructions below to launch and test the app.

## Prerequisites

1. **Terraform**: Ensure Terraform is installed on your system. You can download it from [Terraform's official website](https://www.terraform.io/downloads.html).
2. **AWS Account**: You need an AWS account with appropriate permissions to create EC2 instances, security groups, and other resources.
3. **AWS CLI**: Install and configure the AWS CLI with your credentials.

## Steps to Launch the App

1. **Navigate to the Terraform Directory**:
   ```bash
   cd terraform
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```
   This command initializes the Terraform working directory and downloads the necessary provider plugins.

3. **Validate the Configuration**:
   ```bash
   terraform validate
   ```
   This ensures that the Terraform configuration files are syntactically valid.

4. **Apply the Terraform Configuration**:
   ```bash
   terraform apply
   ```
   Review the plan and type `yes` to deploy the infrastructure. Terraform will create the necessary AWS resources, including an EC2 instance.

5. **Retrieve the Public IP Address**:
   After the deployment, Terraform will output the public IP address of the EC2 instance. You can also find it in the AWS Management Console under the EC2 section.

## Testing the App

1. **Access the App**:
   Open a web browser and navigate to:
   ```
   http://<EC2_PUBLIC_IP>:3000
   ```
   Replace `<EC2_PUBLIC_IP>` with the actual public IP address of the EC2 instance.

2. **Verify Functionality**:
   - The app should display its main interface.
   - Test the app's features to ensure everything is working as expected.

## Troubleshooting

- **App Not Accessible**:
  - Ensure the security group allows inbound traffic on port 3000.
  - Verify that the EC2 instance is running in the AWS Management Console.

- **Logs**:
  - The app's logs can be found in the EC2 instance. Modify the `user_data` script in `main.tf` to save logs to a file or use AWS CloudWatch for debugging.

## Cleaning Up

To avoid incurring unnecessary costs, destroy the infrastructure when you're done:
```bash
terraform destroy
```
Type `yes` to confirm the destruction of resources.

## Notes

- The app is configured to automatically start on the EC2 instance using a `user_data` script.
- Ensure your AWS credentials are properly configured before running Terraform commands.