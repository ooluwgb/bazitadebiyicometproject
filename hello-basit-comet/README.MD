# hello-basit-comet
A lightweight Flask web app that greets you by name and tells you which container served your
request.
---
## Overview
This project uses **Flask** as the web framework and is containerized using **Docker**.
It includes:
- A simple form-based and API-friendly greeting.
- Unit tests using `pytest`.
- A GitHub Actions CI/CD pipeline:
 - Runs unit tests.
 - Builds and tags Docker images.
 - Pushes the image to an AWS ECR repo.
---
## Project Structure
```
hello-basit-comet/
 src/ # Application source code
 app.py
 tests/ # Unit tests
 test_hello_basit.py
 requirements.txt
 Dockerfile
 .github/
 workflows/
 build_and_push.yaml
 README.md
```
---
## Prerequisites
- Python 3.11+
- `pip`
- Docker
- AWS CLI configured (for ECR pushes)
---
## Local Development
1. **Clone the repo**
 ```bash
 git clone https://github.com/Basit1854/hello-basit-comet.git
 cd hello-basit-comet
 ```
2. **Create and activate a virtual environment**
 ```bash
 python -m venv venv
 source venv/bin/activate # On Windows: venv\Scripts\activate
 ```
3. **Install dependencies**
 ```bash
 pip install -r requirements.txt
 ```
4. **Run the Flask app**
 ```bash
 python src/app.py
 ```
 The app will be available at: http://localhost:5000
---
## Health Check
A basic health endpoint is exposed for liveness/readiness probes:
```bash
GET /healthz
```
- **Local test**:
 ```bash
 curl http://localhost:5000/healthz
 ```
- **Remote test**:
 ```bash
 curl http://<your-deployed-address>:5000/healthz
 ```
**Example response:**
```json
{
 "status": "ok",
 "pod": "<container-name>"
}
```
---
## Calling the App
### Browser
Navigate to:
http://localhost:5000
Enter your name to receive a personalized greeting.
### cURL
```bash
curl http://localhost:5000/greeting?name=Jane
```
Or with JSON accept header:
```bash
curl -H "Accept: application/json" http://localhost:5000/greeting?name=Jane
```
---
## Testing
Run all tests:
```bash
pytest -v
```
Run a specific test:
```bash
pytest tests/test_hello_basit.py::test_404
```
---
## Docker Usage
### Build the Docker image:
```bash
docker build -t hello-basit-comet:latest .
```
### Run the container:
```bash
docker run -p 5000:5000 hello-basit-comet:latest
```
Then visit: http://localhost:5000
---
## CI/CD via GitHub Actions
The workflow is defined in:
`.github/workflows/build_and_push.yaml`
It performs:
1. Runs tests (`pytest`)
2. Builds and tags a Docker image
3. Pushes the image to AWS ECR
### Triggering
- Automatically on changes to `src/` on `main`
- Manually via GitHub Actions UI
---
## Push to AWS ECR
1. **Log in**:
 ```bash
 aws ecr get-login-password --region <region> \
 | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com
 ```
2. **Tag and push**:
 ```bash
 docker tag hello-basit-comet:latest
<account_id>.dkr.ecr.<region>.amazonaws.com/hello-basit-comet:latest
 docker push <account_id>.dkr.ecr.<region>.amazonaws.com/hello-basit-comet:latest
 ```
---
## Future Improvements
- Add code linting (e.g., `flake8`, `black`) via CI
- Improve test coverage
- Automate deployment to EKS using ArgoCD
- Add versioning/tagging strategy for image releases
---
## Deployed App
You can access the deployed app at:
```
http://<your-deployed-address>:5000/
```
---
Made by Basit.