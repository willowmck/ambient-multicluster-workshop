# Ambient Multi-cluster Lab

This repo contains a runbook for Ambient Multi-cluster based on [Asciidoc](https://asciidoc.org/).  The main advantage of using asciidoc over Markdown is in the modularity of being able to include parts of the document from relative file paths or URLs.  The main content for the lab is found in `index.adoc` and you will find references to specific modules within this by include statements.  For example, 

```
include::modules/install-istio/install-istio.adoc[]
```

will include the Install Istio module.  

Each module is designed to be mostly independent and reusable although there will be some dependencies.  Also, note that the commands to be run are included into the asciidoc files as follows:

```
[source,bash]
----
include::scripts/05.sh[]
----
```

This allows all of the scripts to be executed independently of the resulting runbook that is delivered to the customer.  The result is that I can easily run a for loop on all of the scripts in the scripts folder within the module to easily test that section of the lab.  

## Testing
Additionally, it is fairly easy to add tests since all of the scripting is independent of the runbook.  Note that I have leverage [chainsaw](https://kyverno.github.io/chainsaw/latest/) for testing.  You can either run all tests from the root of the lab or navigate to each module independently to run tests via `chainsaw test`.

## Producing the runbook
To produce the runbook, you will need to install `asciidoctor` via Homebrew.  Then execute `asciidoctor index.adoc` from the root of the lab.  This will create an html file that you can send to the customer.  