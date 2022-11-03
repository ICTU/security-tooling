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
  * Project: https://nuclei.projectdiscovery.io/nuclei/get-started/

Examples:

```
.\security_dependencycheck.ps1 c:\sources c:\reports

./security_dependencycheck.sh /build/src /tmp/report

./security_zap.sh https://www.host.com /tmp/report

./security_openvas.sh www.host.com,123.123.123.123

./security_nuclei.sh https://www.host.com /tmp/report
```
