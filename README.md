# security-tooling
Scripts for running CI/CD security tooling

This repository contains scripts to easily run several Open Source security tools from a build pipeline or job.

* OWASP Dependency Check
  * Windows: security_dependencycheck.ps1
  * Linux (Docker): security_dependencycheck.sh
* OWASP ZAP
  * Linux (Docker): security_zap.sh
* OWASP OpenVAS
  * Linux (Docker): security_openvas.sh

Examples:

```
.\security_dependencycheck.ps1 c:\sources c:\reports

./security_dependencycheck.sh /build/src /tmp/report

./security_zap.sh https://www.host.com /tmp/report

./security_openvas.sh www.host.com,123.123.123.123
```
