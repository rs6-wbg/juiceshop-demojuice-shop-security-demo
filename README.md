# 🔒 Secure DevOps Demo with Vulnerable Application

This repository is built as a demonstration of how various DevSecOps and security automation tools can be integrated into a CI/CD pipeline using **GitHub Actions**. It uses [OWASP Juice Shop](https://github.com/juice-shop/juice-shop), a deliberately insecure web application, as the target application to test the effectiveness of modern security tools in a live CI workflow.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 🧭 Purpose

To showcase a secure CI/CD pipeline with automated scans and security controls across:

- Source code
- Secrets
- Infrastructure as Code (IaC)
- Containers
- Application runtime
- Third-party dependencies
- Web/API vulnerabilities

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## ⚙️ Tools Integrated

| Tool        | Trigger                     | Scan Scope                              | Description |
|-------------|-----------------------------|------------------------------------------|-------------|
| **GitHub CodeQL** | On push to `main`, PRs        | Source code (JavaScript/TypeScript)      | Static code analysis engine for identifying vulnerabilities like injections, insecure deserialization, etc. |
| **GitHub Advanced Security - Secret Scanning** | Always on (via GitHub)           | Source code (commits & PRs)             | Scans for accidental exposure of secrets, API tokens, passwords. |
| **OWASP ZAP (Baseline Scan)** | Manual trigger (`workflow_dispatch`) | Running app (`http://localhost:3000`)   | DAST scanner used to detect runtime vulnerabilities like XSS, CSRF, missing headers. |
| **Snyk**     | Manual or Scheduled         | Dependencies & Docker image              | Scans for known vulnerabilities in open-source packages and container images. |
| **Trivy**    | On Docker build or scheduled | Dockerfile, packages, config files       | Scans for OS-level, app-level, and misconfigurations in container images. |
| **Checkov**  | On PR to `main`, manual     | Terraform, CloudFormation, Kubernetes    | Scans Infrastructure-as-Code for security misconfigurations. |
| **Nikto**    | Manual                      | Web app over HTTP/HTTPS                  | Detects server-side misconfigurations and outdated server components. |

---

## 🚦Workflow Summary

### ✅ CodeQL
- **Trigger**: Automatically runs on PRs and `push` to `main`
- **Scope**: Scans JavaScript/TypeScript for coding flaws
- **Report**: Uploaded to GitHub Security tab (Code Scanning Alerts)

### ✅ GitHub Secret Scanning
- **Trigger**: Automatically scans all commits and PRs
- **Scope**: Detects hardcoded secrets (API keys, tokens)
- **Report**: Security alerts in GitHub

### ✅ OWASP ZAP
- **Trigger**: Manually via `workflow_dispatch`
- **Scope**: DAST scan of live app at `http://localhost:3000`
- **Output**: HTML/Markdown/SARIF reports
- **Integration**: SARIF uploaded to Code Scanning

### ✅ Snyk
- **Trigger**: Manual or scheduled
- **Scope**: Open-source dependencies & Docker image vulnerabilities
- **Integration**: Requires Snyk token via GitHub Secrets

### ✅ Trivy
- **Trigger**: Manual or post-Docker build
- **Scope**: Full container image (OS + app layer + config)
- **Output**: JSON/SARIF (optional for GitHub Code Scanning)

### ✅ Checkov
- **Trigger**: PRs or manual
- **Scope**: Terraform/Kubernetes/cloud IaC
- **Report**: CLI logs + optional SARIF for GitHub

### ✅ Nikto
- **Trigger**: Manual execution
- **Scope**: Web server fingerprinting and security headers
- **Integration**: Run via GitHub Action with `curl` output

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 📌 How to Use

1. **Fork this repository**  
2. Go to **Actions** tab and manually trigger the OWASP ZAP workflow  
3. Push code or create a PR to see CodeQL, Secret Scanning, Checkov run  
4. (Optional) Configure [Snyk](https://snyk.io/) with your API token via GitHub Secrets  
5. Review reports under the **Security** tab or in workflow artifacts

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 🗂️ Directory Structure 

.github/
workflows/
zap.yml # OWASP ZAP baseline scan
codeql.yml # CodeQL scanning
checkov.yml # IaC scanning
snyk.yml # Snyk integration (optional)
trivy.yml # Trivy scan for containers

src/
(Juice Shop source code)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 🚀 Future Enhancements

- ✅ Integrate API scanning with tools like **APISec**, **Tinfoil**, or **Postman’s CLI**
- ✅ SBOM generation via CycloneDX (npm or Trivy)
- ✅ CSPM integration with **Azure Security Center**
- ✅ AI-driven vulnerability triage (using agents like PyRIT or Giskard)
- ✅ Runtime Security with **Falco**, **Sysdig**, or **eBPF tools**

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 🛡️ License & Acknowledgements

This repo leverages the incredible work of [OWASP Juice Shop](https://github.com/juice-shop/juice-shop) and many open-source security tools. Intended for educational and demonstration purposes.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 🧪 Disclaimer

This repository uses the [OWASP Juice Shop](https://github.com/juice-shop/juice-shop) codebase **purely for demonstration purposes** to simulate a realistic web application environment. 

- Some configuration files (e.g., Dockerfiles, Terraform manifests, Kubernetes specs) have been **deliberately modified or added** to introduce insecure patterns.  
- These were intentionally created to **trigger findings** in tools like Checkov, Trivy, and other scanners.

⚠️ **Do not deploy this repository in a production environment.**  
It is meant for learning, evaluation, and DevSecOps workflow testing only.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
