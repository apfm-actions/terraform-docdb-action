Lambda Terraform Action
============================
Deploy an AWS Lambda using Terraform.

Usage
-----

```yaml
  - name: Lambda Deploy
    uses: aplaceformom/terraform-lambda-action@master
    with:
      workspace: dev
      project: examples
      owner: MyTeam
      email: myteam@mydomain.org
      public: true
      debug: false
```


Inputs
-----

### workspace
Terraform Workspace
- required: true

### project
Project this Service is part of.
- required: true

### owner
Project owner/team.
- required: true

### email
Project email address.
- required: true

### function_name:
Lambda function name.
- required: true

### region:
AWS region to deploy to.
- required: false
- default: us-west-2

### runtime:
Programming language to use for the lambda. Valid values: https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime
- required: true

### zip_payload:
Path to the function's deployment package within the local filesystem.
- required: true

### environmental_variables:
JSON map of environment variables to configure on the lambda
- required: false

### memory_size:
Amount of memory in MB your Lambda Function can use at runtime
- required: false
- default: 128

### timeout:
The amount of time your Lambda Function has to run in seconds
- required: false
- default: 3

### policy_arns:
A comma separated list of IAM policies ARNs to be attached to the auto-created lambda role
- required: false

### subnet_ids:
A comma separated list of subnet IDs associated with the Lambda function. (Required for vpc_config ONLY)
- required: false

### security_group_ids:
A comma separated list of security group IDs associated with the Lambda function. (Required for vpc_config ONLY)
- required: false

### enable_cloudwatch_event_trigger:
Boolean to configure the lambda to fire based on a cloudwatch rule
- required: false
- default: false

### cloudwatch_event_name:
Name attribute of the cloudwatch event to fire off of
- required: false

### cloudwatch_event_arn:
ARN attribute of the cloudwatch event to fire off of
- required: false


Outputs
-------

|       Context         |          Description            |
|-----------------------|---------------------------------|
| documentdb_name           | Name of the created documentdb cluster    |
| documentdb_arn            | ARN of the created documentdb cluster     |
| documentdb_endpoint     | The DNS address of the DocDB instance  |
| documentdb_reader_endpoint           | A read-only endpoint for the DocDB cluster, automatically load-balanced across replicas               |


To Do
-------
- fix credstash
- update readme
