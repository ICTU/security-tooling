# Project security-tooling [ARCHIVED]

## 🚨 Repository archived🚨
At March 22nd 2024, this repository is officially archived and will no longer be maintained.

## Why is this archived?
It is (only) a set of scripts to start several open source security tools but since some of them are deprecated or changed and all information in this repository is also available in documentation of the specific tools, there's no reason to keep it alive.

# security-tooling
Scripts for running CI/CD security tooling

This repository contains scripts to easily run several Open Source security tools from a build pipeline or job.

The output from all of these scripts can be used in Quality Time metrics.

* OWASP Dependency Check
  * Windows: security_dependencycheck.ps1
  * Linux (Docker): security_dependencycheck.sh
  * Project: https://jeremylong.github.io/DependencyCheck/
* OWASP ZAP
  * Linux (Docker): security_zap.sh
  * Project: https://www.zaproxy.org/
* OWASP OpenVAS
  * Linux (Docker): security_openvas.sh
  * Project: https://www.openvas.org/
* Nuclei
  * Linux (Docker): security_nuclei.sh
  * Project: https://github.com/projectdiscovery/nuclei

Examples:

```
.\security_dependencycheck.ps1 c:\sources c:\reports

./security_dependencycheck.sh /build/src /tmp/report

./security_zap.sh https://www.host.com /tmp/report

./security_openvas.sh www.host.com,123.123.123.123

./security_nuclei.sh https://www.host.com /tmp/report
```

## Get in touch
Point of contact for this repository is [Team ICTU/security](https://github.com/orgs/ICTU/teams/security), as stated above: this repository is now archived and will no longer be maintained actively.