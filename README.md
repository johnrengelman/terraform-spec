# Terraform-Spec

This repository provides a docker image for authoring and executing tests
for Terraform modules.

## Testing Terraform Modules

Terraform modules are testing using the 
[Kitchen-Terraform](https://github.com/newcontext-oss/kitchen-terraform)
test framework.
This framework provides a custom `driver`, `provisioner`, and `verify` for
[Test Kitchen](http://kitchen.ci/) that integrations Terraform into the
test flow.
Specs are written using the [InSpec](http://inspec.io/) framework along with
the [AWSpec](https://github.com/k1LoW/awspec) library.
Additionally, a small utility library, 
[terraform-utils](https://github.com/johnrengelman/terraform-spec/tree/vendor/gems/terraform-utils),
is added to the runtime container and provides methods for loading and parsing
the Terraform state file.
This is used to retrieve the physical IDs of resources to be used with `AWSpec`.

Terraform, kitchen, ruby, terraform-kitchen, awspec, and terraform-utils are
installed together into this container image.

## Overriding Git clone URLs

Some modules may be configured to clone nested modules using the `ssh` protocol.

```
module "base" {
  source = "git::ssh://git@github.com/example-org/tf-modules.git//module-1?ref=1.0.0"
}
```

Some modules may use a nested module source that refers to a private GitHub 
repository. To support this, the build processes relies on your GitHub 
credentials being located in your `~/.netrc` file. 
This file should be volume mounted into the `terrraform-spec` container
to make them available for the test process.
The `terraform-spec` container is configured to have Git automatically 
override any `ssh` clone URLs to use HTTPS instead. 

```
git config --global url."https://github.com/".insteadOf "ssh://git@github.com/"
```

The `~/.netrc` file is then automatically referenced for credentials when
cloning over HTTPS.

The contents of the `~/.netrc` file look like so:

```
machine github.com
login <username>
password <password or personal token if MFA is enabled>
```

**NOTE**: if MFA is enabled on your GitHub account, then you **must** create a 
personal access token and use that as the password in the `~/.netrc` file.
