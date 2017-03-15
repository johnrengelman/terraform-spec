# Example Module

This folder contains a sample terraform module that is configured to use
`terraform-spec` to run tests.

### Testing modules locally

Testing modules locally can be accomplished using a series of `Make` tasks
contained in this repo.

| Make Task | What happens                                                                                                  |
|:----------|:--------------------------------------------------------------------------------------------------------------|
| ci        | Executes a local CI run using `drone exec`. This will execute `kitchen test --destroy=always` for all modules |
| test      | Execute `kitchen test --destroy=always` for all modules                                                       |
| converge  | Execute `kitchen converge` for all modules                                                                    |
| verify    | Execute `kitchen verify` for all modules                                                                      |
| destroy   | Execute `kitchen destroy` for all modules                                                                     |
| kitchen   | Execute `kitchen <command>`. Specify the command with the `COMMAND` argument to `make`                        |

#### Running Test Kitchen for a single module

Test Kitchen uses the concept of "instances" as it's medium for multiple test 
packages in a project.
An "instance" is the combination of a _test suite_ and a _platform_.
This project uses a single _platform_ for all specs (e.g. `aws`).
The name of this platform actually doesn't matter since the terraform provisioner
and driver are not affected by it.

You can see the available test instances by running the `kitchen list` command:

```bash
$ make kitchen COMMAND=list
Instance              Driver     Provisioner  Verifier   Transport  Last Action  Last Error
module1               Terraform  Terraform    Terraform  Ssh        Verified     <None>
module2               Terraform  Terraform    Terraform  Ssh        Created      <None>
```

To run Test Kitchen processes for a single instance, you **must** use the `kitchen`
target from the make file and pass the command and the instance name using the
`COMMAND` variable to make.

```bash
$ make kitchen COMMAND="converge module1"
```
